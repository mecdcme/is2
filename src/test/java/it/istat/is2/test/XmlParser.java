package it.istat.is2.test;

import static org.junit.Assert.assertNull;

import java.io.File;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import it.istat.is2.xmlparser.domain.Service;

@RunWith(SpringJUnit4ClassRunner.class)
public class XmlParser extends TestBase {
    
	
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
        File xmlFile = new File(fileName);
         
        JAXBContext jaxbContext;
        try
        {
            //jaxbContext = JAXBContext.newInstance("xmlparser");
            jaxbContext = JAXBContext.newInstance("it.istat.is2.xmlparser.domain");
            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
            // Act
            Service service = (Service) jaxbUnmarshaller.unmarshal(xmlFile);
             
            System.out.println(service);
        }
        catch (JAXBException e) 
        {
            e.printStackTrace();
        }    
        

        // Assert
        assertNull(fileName);
    }
}