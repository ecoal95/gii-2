/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package library;

import java.util.Comparator;

/**
 *
 * @author emilio
 */
public class PenPriceComparator implements Comparator <Pen> {

    @Override
    public int compare(Pen o1, Pen o2) {
        Float p1 = o1.getPrice();
        Float p2 = o2.getPrice();
        return p1.compareTo(p2);
    }
    
    
}
