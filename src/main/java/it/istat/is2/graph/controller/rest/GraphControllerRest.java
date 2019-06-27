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
import it.istat.is2.graph.bean.Coordinate;
import it.istat.is2.graph.bean.GraphData;
import it.istat.is2.graph.bean.Point;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GraphControllerRest {

    @Autowired
    private DatasetService datasetService;

    @GetMapping("/rest/graph/getColumns/{ids}")
    public List<DatasetColonna> getColumns(HttpServletRequest request, @PathVariable("ids") List<Integer> ids) {
        List<DatasetColonna> colonne = new ArrayList();
        DatasetColonna colonna;
        for (Integer id : ids) {
            colonna = datasetService.findOneColonna(new Long(id));
            System.out.println("Nome colonna " + colonna.getNome());
            colonne.add(colonna);
        }
        return colonne;
    }

    @GetMapping("/rest/graph/getPoints/{ids}")
    public List<Point> getPoints(HttpServletRequest request, @PathVariable("ids") List<Integer> ids) {
        List<String> valorix;
        List<String> valoriy;
        List<Point> points = new ArrayList();
        valorix = datasetService.findOneColonna(new Long(ids.get(0))).getDatiColonna();
        valoriy = datasetService.findOneColonna(new Long(ids.get(1))).getDatiColonna();
        for (int i = 0; i < valorix.size(); i++) {
            points.add(new Point(valorix.get(i), valoriy.get(i)));
        }
        return points;
    }

    @GetMapping("/rest/graph/getCoordinates/{ids}")
    public Coordinate geCoordinates(HttpServletRequest request, @PathVariable("ids") List<Integer> ids) {

        Coordinate coordinateXY = new Coordinate();

        coordinateXY.setX(datasetService.findOneColonna(new Long(ids.get(0))).getDatiColonna());
        coordinateXY.setY(datasetService.findOneColonna(new Long(ids.get(1))).getDatiColonna());

        return coordinateXY;
    }

    @GetMapping(value = "/rest/graph/getData/{filters}/{xAxis}/{yAxis}")
    public GraphData getData(HttpServletRequest request, @PathVariable("filters") List<Integer> filters,
            @PathVariable("xAxis") List<Integer> xAxis, @PathVariable("yAxis") List<Integer> yAxis) {

        Map<String, List<String>> filterData = new HashMap<>();
        for (int i = 0; i < filters.size(); i++) {
            if (filters.get(i) > 0) {
                filterData.put("FILTER_" + i, datasetService.findOneColonna(new Long(filters.get(i))).getDatiColonna());
            }
        }
        Map<String, List<String>> xData = new HashMap<>();
        for (int i = 0; i < xAxis.size(); i++) {
            if (xAxis.get(i) > 0) {
                xData.put("X_" + i, datasetService.findOneColonna(new Long(xAxis.get(i))).getDatiColonna());
            }
        }
        Map<String, List<String>> yData = new HashMap<>();
        for (int i = 0; i < yAxis.size(); i++) {
            if (yAxis.get(i) > 0) {
                yData.put("Y_" + i, datasetService.findOneColonna(new Long(yAxis.get(i))).getDatiColonna());
            }
        }

        return new GraphData(filterData, xData, yData);
    }

}
