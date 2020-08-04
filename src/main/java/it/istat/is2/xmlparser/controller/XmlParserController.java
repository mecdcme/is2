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
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import it.istat.is2.app.bean.InputFormBean;
import it.istat.is2.app.service.NotificationService;
import it.istat.is2.app.util.FileHandler;
import it.istat.is2.workflow.domain.BusinessService;
import it.istat.is2.workflow.service.BusinessServiceService;
import it.istat.is2.xmlparser.domain.BusinessServiceXml;
import it.istat.is2.xmlparser.domain.BusinessServiceXml.AppServiceXml;
import it.istat.is2.xmlparser.domain.BusinessServiceXml.AppServiceXml.Instances;
import it.istat.is2.xmlparser.domain.BusinessServiceXml.AppServiceXml.Instances.StepInstanceXml;
import it.istat.is2.xmlparser.domain.BusinessServiceXml.AppServiceXml.Instances.StepInstanceXml.Signature;
import it.istat.is2.xmlparser.domain.BusinessServiceXml.AppServiceXml.Instances.StepInstanceXml.Signature.InputVariables.InputVariable;
import it.istat.is2.xmlparser.domain.BusinessServiceXml.AppServiceXml.Instances.StepInstanceXml.Signature.OutputVariables.OutputVariable;
import it.istat.is2.xmlparser.domain.BusinessServiceXml.AppServiceXml.Instances.StepInstanceXml.Signature.Parameters.ParameterXml;

@Controller
public class XmlParserController {
    @Autowired
    private BusinessServiceService businessServiceService;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private MessageSource messages;

    @GetMapping(value = "/xmlparser")
    public String getXmlParser(HttpSession session, Model model) {
        notificationService.removeAllMessages();
        // Do something


        return "xmlparser/upload";
    }

    @PostMapping(value = "/loadXmlFile")
    public String loadInputData(HttpSession session, HttpServletRequest request, Model model,
                                @ModelAttribute("inputFormBean") InputFormBean form) throws IOException {
        notificationService.removeAllMessages();

        File file = null;


        file = FileHandler.convertMultipartFileToXmlFile(form.getFileName());


        if (file != null && !form.getName().equals("") && jaxbXmlFileToObject(file)) {
            notificationService.addInfoMessage("Il file è stato caricato con successo nel db");
        } else {
            notificationService.addErrorMessage("ERRORE: Non è stato possibile caricare il file nel db");
        }

        return "xmlparser/upload";
    }

    // TEST inserimento del solo Service
    public boolean jaxbXmlFileToObject(File file) {

        JAXBContext jaxbContext;
        try {

            jaxbContext = JAXBContext.newInstance("it.istat.is2.xmlparser.domain");
            Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();


            BusinessServiceXml bservice = (BusinessServiceXml) jaxbUnmarshaller.unmarshal(file);


            // TEST inserimento del solo primo livello
            BusinessService bs = new BusinessService();
            bs.setDescr(bservice.getDescr());
            bs.setName(bservice.getName());

            businessServiceService.save(bs);


            // TEST ALBERO XML STATICO
            AppServiceXml appServices = bservice.getAppServiceXml();


            //List<Method> appServices = (List<Method>)appServices.getMethod();

            Instances istancesSet = appServices.getInstances();

            // Per il momento mi occupo solo della prima instances
            List<StepInstanceXml> listaInstancesXml = istancesSet.getStepInstanceXml();


            for (int y = 0; y < listaInstancesXml.size(); y++) {
                Signature listaSignatures = listaInstancesXml.get(y).getSignature();

                if (listaSignatures != null) {


                    List<InputVariable> listaInputVariables = listaSignatures.getInputVariables().getInputVariable();
                    List<OutputVariable> listaOutputVariables = listaSignatures.getOutputVariables().getOutputVariable();
                    List<ParameterXml> listaParameters = listaSignatures.getParameters().getParameterXml();


                    for (int z = 0; z < listaInputVariables.size(); z++) {
                        InputVariable inputVariable = listaInputVariables.get(z);
                        inputVariable.getRole().getCode();
                        inputVariable.getRole().getName();
                        inputVariable.getRole().getDescr();
                        inputVariable.getRole().getOrder();
                        inputVariable.getRole().getClsDataType();
                        System.out.println(inputVariable.getRole().getName());
                    }

                    for (int z = 0; z < listaOutputVariables.size(); z++) {
                        OutputVariable outputVariable = listaOutputVariables.get(z);
                        outputVariable.getRole().getCode();
                        outputVariable.getRole().getName();
                        outputVariable.getRole().getDescr();
                        outputVariable.getRole().getOrder();
                        outputVariable.getRole().getClsDataType();
                        System.out.println(outputVariable.getRole().getName());
                    }

                    for (int z = 0; z < listaParameters.size(); z++) {
                        ParameterXml parameterXml = listaParameters.get(z);
                        parameterXml.getName();
                        parameterXml.getDescr();
                        parameterXml.getDefault();

                    }


                }

            }

        } catch (JAXBException e) {
            notificationService.addErrorMessage(
                    messages.getMessage("error.message.xml.parsing", null, LocaleContextHolder.getLocale()));
        }
        return true;
    }
}
