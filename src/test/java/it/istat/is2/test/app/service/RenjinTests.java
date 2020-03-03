package it.istat.is2.test.app.service;

import static org.junit.Assert.assertEquals;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;

import javax.script.ScriptException;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.renjin.base.Lapack;
import org.renjin.eval.Session;
import org.renjin.eval.SessionBuilder;
import org.renjin.script.RenjinScriptEngine;
import org.renjin.script.RenjinScriptEngineFactory;
import org.renjin.sexp.AtomicVector;
import org.renjin.sexp.Environment;
import org.renjin.sexp.SEXP;
import org.renjin.sexp.Vector;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import it.istat.is2.test.*;

 

@RunWith(SpringJUnit4ClassRunner.class)
public class RenjinTests extends TestBase {

	@Test
    public void goTest()  {
		String h ="a";
		   try {
		 URLClassLoader classLoader = new URLClassLoader(
			    new URL[] {
			        new File("C:/Users/framato/.m2/repository/org/renjin/renjin-core/3.5-beta76").toURI().toURL()  });

		
	        // Create a Renjin engine:
		Session session = new SessionBuilder()
				  .setClassLoader(classLoader)
				  .build();
		RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
		RenjinScriptEngine engine = factory.getScriptEngine();
  
		  engine.eval("library(netlib) ");

	    		engine.eval(" y <- matrix(1:6, nrow=2, ncol=2)");
		  	engine.eval("t<-.Internal(det_ge_real(y, TRUE))") ;
				     SEXP res = (SEXP)  engine.eval("print(y)");
				     System.out.println(res);
			} catch (ScriptException | MalformedURLException e) {
				// TODO Auto-generated catch block
				System.out.println(e);
			}

	    assertEquals("a", h);
	
	}
}
