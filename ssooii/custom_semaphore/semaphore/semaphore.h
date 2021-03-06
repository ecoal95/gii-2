/**
 * Custom unix signal-based semaphore
 * this works for inter-process communication, not inter-thread
 *
 * @author Emilio Cobos Álvarez <emiliocobos@usal.es>
 * @license GPLv3 or greater
 *
 * IMPORTANT NOTES:
 *	Since queue_push is far less than atomic,
 *  I can't guarantee that it will work for more than two
 *  processes. Being clear, **we have a mutex**.
 *  Anyways, it's an interesting experiment.
 *
 *	Since I realised it's just a mutex, the queue is no longer
 *	useful... I haven't removed it anyways. Maybe I could implement
 *	a software-based lock for that push...
 *
 *	I haven't splitted between .c and .h files, lazyness, you know
 */
#ifndef SEMAPHORE_H
#define SEMAPHORE_H

#include <unistd.h>
#include <signal.h>
#include <sys/mman.h>
#include <fcntl.h>
#include "queue.h"
#include "spinlock.h"

#define SEMAPHORE_RESUME_SIGNAL_NUMBER SIGUSR1

typedef struct semaphore {
    spinlock_t lock;
    queue_t queue;
    int count;
} semaphore_t;

#define SHARED_SEMAPHORE_SIZE (sizeof(int) + sizeof(semaphore_t))
/**
 * We create a shared segment with:
 *  - fd: the file descriptor to the opened file
 *  - semaphore_t: the semaphore that we return
 */
semaphore_t* get_shared_semaphore(const char* data_path) {
    int* temp;
    int fd = open(data_path, O_RDWR | O_CREAT | O_TRUNC, 0666);

    ftruncate(fd, SHARED_SEMAPHORE_SIZE);

    temp = (int*)mmap(NULL, SHARED_SEMAPHORE_SIZE, PROT_READ | PROT_WRITE,
                      MAP_SHARED, fd, 0);

    *temp = fd;

    return (semaphore_t*)(temp + 1);
}

void release_shared_semaphore(semaphore_t* sem, const char* path) {
    int* temp = ((int*)sem) - 1;
    int fd = *temp;

    munmap(temp, SHARED_SEMAPHORE_SIZE);
    close(fd);
    /** TODO: do not force path as parameter */
    unlink(path);
}

void semaphore_init(semaphore_t* sem, int num) {
    sigset_t set;
    sigemptyset(&set);
    sigaddset(&set, SEMAPHORE_RESUME_SIGNAL_NUMBER);

    sigprocmask(SIG_BLOCK, &set, NULL);

    sem->count = num;
    queue_init(&sem->queue);
    spinlock_init(&sem->lock);
}

void semaphore_lock(semaphore_t* sem) {
    static sigset_t set;

    /** TODO: optimize */
    sigfillset(&set);
    sigdelset(&set, SEMAPHORE_RESUME_SIGNAL_NUMBER);

    spinlock_acquire(&sem->lock);
    /** If we're full */
    if (--sem->count < 0) {
        queue_push(&sem->queue, getpid());
        spinlock_release(&sem->lock);
        sigsuspend(&set);
    } else {
        spinlock_release(&sem->lock);
    }
}

void semaphore_unlock(semaphore_t* sem) {
    /** If we have still some pending process */
    spinlock_acquire(&sem->lock);
    if (++sem->count <= 0) {
        kill(queue_front(&sem->queue), SEMAPHORE_RESUME_SIGNAL_NUMBER);
        queue_pop(&sem->queue);
    }
    spinlock_release(&sem->lock);
}

#endif
