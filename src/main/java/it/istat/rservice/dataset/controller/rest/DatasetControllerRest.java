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
package it.istat.rservice.dataset.controller.rest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import it.istat.rservice.app.service.NotificationService;
import it.istat.rservice.app.util.Utility;
import it.istat.rservice.dataset.domain.DatasetColonna;
import it.istat.rservice.dataset.domain.DatasetFile;
import it.istat.rservice.dataset.domain.TipoVariabileSum;
import it.istat.rservice.dataset.service.DatasetService;

@RestController
public class DatasetControllerRest {

    @Autowired
    private DatasetService datasetService;
    @Autowired
    private NotificationService notificationService;

    @GetMapping("/datasetfile/{id}")
    @ResponseBody
    public DatasetFile loadDataSetFile(@PathVariable Long id) throws IOException {
        DatasetFile df = datasetService.findDataSetFile(id);
        return df;
    }

    @GetMapping("/datasetfile")
    @ResponseBody
    public List<DatasetFile> loadDataSetFile() throws IOException {
        List<DatasetFile> df = datasetService.findAllDatasetFile();
        return df;
    }

    @GetMapping("/datasetfilesql/{id}")
    @ResponseBody
    public DatasetFile loadDataSetFileSql(@PathVariable Long id) throws IOException {
        DatasetFile df = datasetService.findDataSetFileSQL(id);
        return df;
    }

    @GetMapping("/datasetfilesql")
    @ResponseBody
    public List<DatasetFile> loadDataSetFileSql() throws IOException {
        List<DatasetFile> df = datasetService.findAllDatasetFileSQL();
        return df;
    }

    @GetMapping("/datasetcolonnasql/{dfile}/{rigainf}/{rigasup}")
    @ResponseBody
    public List<DatasetColonna> loadDataSetColonnaSql(@PathVariable Long dfile, @PathVariable Integer rigainf, @PathVariable Integer rigasup) throws IOException {
        List<DatasetColonna> df = datasetService.findAllDatasetColonnaSQL(dfile, rigainf, rigasup);
        return df;
    }

    @RequestMapping(value = "/rest/datasetvalori/{dfile}/{parametri:.+}", method = RequestMethod.POST)
    public String loadDatasetValori2(HttpServletRequest request, Model model, @PathVariable("dfile") Long dfile,
            @PathVariable("parametri") String parametri, @RequestParam("length") Integer length,
            @RequestParam("start") Integer start, @RequestParam("draw") Integer draw,
            @RequestParam Map<String, String> allParams) throws IOException {

        String indexColunmToOrder = allParams.get("order[0][column]");
        String nameColumnToOrder = allParams.get("columns[" + indexColunmToOrder + "][data]");
        String dirColumnOrder = allParams.get("order[0][dir]");

        HashMap<String, String> parameters = null;
        String noparams = "noparams";
        if (!noparams.equals(parametri)) {
            StringTokenizer st = new StringTokenizer(parametri, "&");
            StringTokenizer st2 = null;
            parameters = new HashMap<String, String>();

            ArrayList<String> nomeValore = null;
            while (st.hasMoreTokens()) {
                st2 = new StringTokenizer(st.nextToken(), "=");
                nomeValore = new ArrayList<String>();
                while (st2.hasMoreTokens()) {
                    nomeValore.add(st2.nextToken());
                }

                parameters.put(nomeValore.get(0), nomeValore.get(1));
            }
        }
        String dtb = datasetService.loadDatasetValori1(dfile, length, start, draw, parameters, nameColumnToOrder, dirColumnOrder);

        return dtb;
    }

    @RequestMapping(value = "/rest/setvariabilesum/{idcol}/{idvar}", method = RequestMethod.POST)
    public DatasetColonna setVarSum(HttpServletRequest request, Model model, @PathVariable("idcol") Long idcol, @PathVariable("idvar") Integer idvar) throws IOException {

        DatasetColonna dcol = datasetService.findOneColonna(idcol);
        TipoVariabileSum sum = new TipoVariabileSum(idvar);
        dcol.setTipoVariabile(sum);
        try {
            dcol = datasetService.salvaColonna(dcol);
        } catch (Exception e) {
            notificationService.addErrorMessage("Errore: ", e.getMessage());
        }
        return dcol;
    }

    @RequestMapping(value = "/rest/download/dataset/{tipoFile}/{dfile}", method = RequestMethod.GET)
    public void downloadWorkset(HttpServletRequest request, HttpServletResponse response,
            @PathVariable("tipoFile") String tipoFile, @PathVariable("dfile") Long dfile) throws Exception {

        String fileName = "";
        String contentType = "";
        switch (tipoFile) {
            case "csv":
                fileName = "dataset.csv";
                contentType = "text/csv";
                break;
            case "pdf":
                fileName = "dataset.pdf";
                contentType = "application/pdf";
                break;
            case "excel":
                fileName = "dataset.xlsx";
                contentType = "application/vnd.ms-excel";
                break;
        }

        response.setHeader("charset", "utf-8");
        response.setHeader("Content-Type", contentType);
        response.setHeader("Content-disposition", "attachment; filename=" + fileName);
        Map<String, List<String>> dataMap = datasetService.loadDatasetValori(dfile);
        Utility.writeObjectToCSV(response.getWriter(), dataMap);
    }
}
