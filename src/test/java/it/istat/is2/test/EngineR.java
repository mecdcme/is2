/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.test;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.script.ScriptEngine;
import javax.script.ScriptException;
import org.junit.Test;
import static org.junit.Assert.*;
import org.renjin.script.RenjinScriptEngineFactory;
import org.renjin.sexp.DoubleVector;
import org.renjin.sexp.ListVector;
import org.renjin.sexp.StringVector;
import org.renjin.sexp.Vector;

/**
 *
 * @author UTENTE
 */
public class EngineR {

    public EngineR() {
    }

    @Test
    public void testVector() {
        try {
            // Create a script engine manager:
            RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
            // Create a Renjin engine:
            ScriptEngine engine = factory.getScriptEngine();

            Vector x = (Vector) engine.eval("x <- c(6, 7, 8, 9)");
            System.out.println("The vector 'x' has length " + x.length());
            for (int i = 0; i < x.length(); i++) {
                System.out.println("Element x[" + (i + 1) + "] is " + x.getElementAsInt(i));
            }

        } catch (ScriptException ex) {
            Logger.getLogger(EngineR.class.getName()).log(Level.SEVERE, null, ex);
        }

        assertTrue(true);
    }
    
    @Test
    public void testList() {
        try {
            // Create a script engine manager:
            RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
            // Create a Renjin engine:
            ScriptEngine engine = factory.getScriptEngine();

            ListVector data = (ListVector) engine.eval("data <- list(out = c(1,2,3), x = c(4,5,6), y = c(7,8,9))");
            StringVector names = (StringVector) engine.eval("names(data)");
            System.out.println("The list 'data' has elements " + data.length());
            for (int i = 0; i < data.length(); i++) {
                DoubleVector element = (DoubleVector) data.getElementAsSEXP(i);
                for(int j = 0 ; j < element.length(); j++){
                    System.out.println( names.getElementAsString(i) + "[" + (j + 1) + "] is " + element.getElementAsInt(j));
                }
                System.out.println("");
            }

        } catch (ScriptException ex) {
            Logger.getLogger(EngineR.class.getName()).log(Level.SEVERE, null, ex);
        }

        assertTrue(true);
    }
}
