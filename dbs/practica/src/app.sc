// vim:set syntax=c:
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "question.h"
#include "answer.h"
#include "exam.h"
#include "interactive.h"
#include "common.h"

#include <commands.h>

int create_question(int argc, char** argv) {
    char buffer[255];
    char is_correct;

    printf("Give me the statement:");
    get_str(buffer, sizeof(buffer));

    char* args[] = { "-a", buffer, NULL };
    question(2, args);

    char* id_str = NULL;

    while ( 1 ) {
        printf("Give me one answer (empty to stop):");
        get_str(buffer, sizeof(buffer));

        if ( ! *buffer )
            break;

        printf("Is correct? (Y/n):");
        do {
            is_correct = getchar();
        } while ( is_correct != 'n' && is_correct != 'Y' );

        if ( is_correct == 'Y' ) {
            char* args[] = { "-a", id_str, buffer, "--correct", NULL };
            answer(4, args);
        } else {
            char* args[] = { "-a", id_str, buffer, NULL };
            answer(3, args);
        }
    }

    return 1;
}

// The list of our supported commands
struct command commands[] = {
    { "question",  question, "manages questions",
        "Usage: question [args...]\n"
        "\t-a\tcreates a new question\t-a <statement>\n"
        "\t-d\tdeletes a question\t-d <id>\n"
        "\t-e\tedits a question\t-e <id> <statement>\n"
        "\t-s\tshows a question\t-s <id>\n"
        "\t-l\tlists all questions\t-l [<theme_id>] [--detailed]\n"
        "\t-t\tlists all questions by theme and subject\t-t [--detailed]\n"
        "Prints the question id on success to stdout." },
    { "answer", answer, "manages answers",
        "Usage: answer [args...]\n"
        "\t-a\tcreates an answer\t-a <question_id> <statement> [--correct]\n"
        "\t-l\tlist answers for a question\t-l <question_id>\n"
        "\t-d\tdeletes a question\t-d <id>" },
    { "exam", exam, "manages exams",
        "Usage: answer [args...]\n"
        "\t-l\tlist exams for a question\t-l <question_id>\n" },
    { "interactive", interactive, "Open an interactive session" },
    { NULL, NULL, NULL, NULL } // End of the list
};


// TODO: Recover graciously
void handle_error() {
    fprintf(stderr, "[ERROR] %s | SQLSTATE(%s), SQLCODE(%ld)\n", sqlca.sqlerrm.sqlerrmc, SQLSTATE, SQLCODE);
    exit(1);
}




/// Comentario de prueba
int main(int argc, char** argv) {
    EXEC SQL WHENEVER SQLERROR DO handle_error();
    EXEC SQL CONNECT TO exams;

    int ret = command_exec(commands, argc, argv);

    EXEC SQL COMMIT;

    return ret;
}
