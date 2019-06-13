/**
 * Copyright 2019 ISTAT
 *
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 *
 * http://ec.europa.eu/idabc/eupl5
 *
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
package it.istat.is2.graph.controller.rest;

import it.istat.is2.dataset.domain.DatasetColonna;
import it.istat.is2.dataset.service.DatasetService;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GraphControllerRest {
    
    @Autowired
    private DatasetService datasetService;

    @GetMapping("/rest/graph/getColumns/{ids}")
    public List<DatasetColonna> getColumns(HttpServletRequest request, @PathVariable("ids") List<Integer> ids) {
        
        List<DatasetColonna> colonne = new ArrayList();
        DatasetColonna colonna;
        
        for(Integer id:ids){
            colonna = datasetService.findOneColonna(new Long(id));
            System.out.println("Nome colonna " + colonna.getNome() );
            colonne.add(colonna);
        }
        
        return colonne;
    }

}
