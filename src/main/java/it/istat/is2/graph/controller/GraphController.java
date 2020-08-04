/**
 * Copyright 2019 ISTAT
 * <p>
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 * <p>
 * http://ec.europa.eu/idabc/eupl5
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * Licence for the specific language governing permissions and limitations under
 * the Licence.
 *
 * @author Francesco Amato <framato @ istat.it>
 * @author Mauro Bruno <mbruno @ istat.it>
 * @author Paolo Francescangeli  <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
package it.istat.is2.graph.controller;

import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import it.istat.is2.dataset.domain.DatasetColumn;
import it.istat.is2.dataset.domain.DatasetFile;
import it.istat.is2.dataset.service.DatasetService;


@Controller
public class GraphController {

    @Autowired
    private DatasetService datasetService;
    @Autowired
    ServletContext context;


    @GetMapping("/graph/home/{idfile}")
    public String caricaMetadati(Model model, @PathVariable("idfile") Long idfile) {

        DatasetFile dfile = datasetService.findDataSetFile(idfile);

        List<DatasetColumn> colonne = datasetService.findAllNameColum(idfile);

        model.addAttribute("colonne", colonne);
        model.addAttribute("idfile", idfile);
        model.addAttribute("dfile", dfile);

        return "graph/home";
    }

    @GetMapping("/metadatiDatasetGrafici/{idfile}")
    public String caricaGraph(Model model, @PathVariable("idfile") Long idfile) {

        @SuppressWarnings("unused")
        DatasetFile dfile = datasetService.findDataSetFile(idfile);

        return "dataset/graph3";
    }
}
