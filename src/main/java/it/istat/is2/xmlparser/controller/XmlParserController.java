package it.istat.is2.xmlparser.controller;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import it.istat.is2.app.bean.InputFormBean;
import it.istat.is2.app.domain.User;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.service.BusinessServiceService;
import it.istat.is2.xmlparser.domain.Service;
import it.istat.is2.xmlparser.domain.Service.Methods;
import it.istat.is2.xmlparser.domain.Service.Methods.Method;
import it.istat.is2.xmlparser.domain.Service.Methods.Method.InputParameter;
import it.istat.is2.xmlparser.domain.Service.Methods.Method.InputVariable;
import it.istat.is2.xmlparser.domain.Service.Methods.Method.OutputVariable;

@Controller
public class XmlParserController {
	@Autowired
    private BusinessServiceService businessServiceService;
	@Autowired
    private NotificationService notificationService;
	
	@GetMapping(value = "/xmlparser")
    public String getXmlParser(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        // Do something
        
        
        
        return "xmlparser/upload";
    }
	@RequestMapping(value = "/loadXmlFile", method = RequestMethod.POST)
    public String loadInputData(HttpSession session, HttpServletRequest request, Model model,
            @AuthenticationPrincipal User user, @ModelAttribute("inputFormBean") InputFormBean form) throws IOException {	
        notificationService.removeAllMessages();
        
        File file = FileHandler.convertMultipartFileToXmlFile(form.getFileName());        
        
        if(jaxbXmlFileToObject(file)) {
        	notificationService.addInfoMessage("Il file è stato caricato con successo nel db");
        }else {
        	notificationService.addErrorMessage("Non è stato possibile caricare il file nel db");
        }

        return "xmlparser/upload";
    }
	
	// TEST inserimento del solo Service
	public boolean jaxbXmlFileToObject(File file) {
		
        JAXBContext jaxbContext;
        try
        {
            //jaxbContext = JAXBContext.newInstance("xmlparser");
            jaxbContext = JAXBContext.newInstance("it.istat.is2.xmlparser.domain");
            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
            
            Service service = (Service) jaxbUnmarshaller.unmarshal(file);
             
            System.out.println(service);
            
            // TEST inserimento
            BusinessService bs=new BusinessService();
            bs.setDescr(service.getDescription());
            bs.setName(service.getShortname());
            
            
            businessServiceService.save(bs);
            System.out.println("Inserimento avvenuto");
            
//            AppService e = new AppService();
//            bs.getAppServices().add(e);
            
            
            Methods methods = (Methods) service.getMethods();
            
            
        	List<Method> method = (List<Method>)methods.getMethod();
        	
        	
        	for(int y=0; y<method.size(); y++) {
        		List<InputVariable> inputVariable = (List<InputVariable>) method.get(y).getInputVariable();
            	
            	if(inputVariable!=null) {
            		for(int w=0; w<inputVariable.size(); w++) {
            			InputVariable inputv1 = inputVariable.get(w);
            			// Popolare domain e chiamare service per inserimento
            			System.out.println("Popolo InputVariable");
            		}
            	}
        	
        	
        	
            	List<InputParameter> inputParameter = (List<InputParameter>) method.get(y).getInputParameter();
        	
            	if(inputParameter!=null) {            		
            		for(int w=0; w<inputParameter.size(); w++) {
            			InputParameter inputp1 = inputParameter.get(w);
            			// Popolare domain e chiamare service per inserimento
            			System.out.println("Popolo InputParameter");
            		}
            	}
            	
            	List<OutputVariable> outputVariable = (List<OutputVariable>) method.get(y).getOutputVariable();
            	
            	if(outputVariable!=null) {
            		for(int w=0; w<outputVariable.size(); w++) {
            			OutputVariable out1 = outputVariable.get(w);
            			// Popolare domain e chiamare service per inserimento
            			System.out.println("Popolo OutputVariable");
            		}
            	}            
            	
            	
        	}
            
            
            
        }
        catch (JAXBException e) 
        {
            e.printStackTrace();
        }       
        return true;
    }
}
