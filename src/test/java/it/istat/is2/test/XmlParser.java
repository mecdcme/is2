package it.istat.is2.test;

import static org.junit.Assert.assertNotNull;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import it.istat.is2.workflow.service.BusinessServiceService;

@RunWith(SpringJUnit4ClassRunner.class)
public class XmlParser extends TestBase {
	@Mock BusinessServiceService businessServiceService;;
    
	
//	public static void main(String[] args) 
//    {
//        String fileName = "C:\\Users\\Renzo\\Desktop\\Java xml parser\\is2_mlest_Form.xml";
// 
//        jaxbXmlFileToObject(fileName);
//    }
	@Test
    public void jaxbXmlFileToObject() {
         
		// Arrange
		String fileName = "C:\\Users\\Renzo\\Desktop\\Java xml parser\\is2_mlest_Form.xml";
      

        // Assert
        assertNotNull(fileName);
    }
}