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
package it.istat.is2.workflow.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.istat.is2.workflow.dao.GsbpmProcessDao;
import it.istat.is2.workflow.domain.GsbpmProcess;

import java.util.HashMap;
import java.util.LinkedHashMap;

@Service
public class GsbpmProcessService {

    @Autowired
    GsbpmProcessDao gsbpmProcessDao;

    public GsbpmProcess findById(Long sbpmProcessId) {
        return gsbpmProcessDao.findById(sbpmProcessId).orElse(null);
    }

    public List<GsbpmProcess> findAllProcesses() {
        return gsbpmProcessDao.findAllProcesses();
    }

    public List<GsbpmProcess> findAllSubProcesses() {
        return gsbpmProcessDao.findAllSubProcesses();
    }

    public List<GsbpmProcess> findSubProcessesByGsbpmParentProcess(GsbpmProcess gsbpmProcess) {
        return gsbpmProcessDao.findSubProcessesByGsbpmParentProcess(gsbpmProcess);
    }

    public Integer getGsbpmRows() {
        return gsbpmProcessDao.getGsbpmRows();
    }

    public Integer getGsbpmColumns() {
        return gsbpmProcessDao.getGsbpmColumns();
    }

    public HashMap<String, GsbpmProcess> getGsbpmMatrix() {

        HashMap<String, GsbpmProcess> matrix = new LinkedHashMap<>();

        int x = 0, y = 0;
        long parent = -1;
        boolean isFirst = true;

        //Process row (x>=0, y=0)
        List<GsbpmProcess> processList = this.findAllProcesses();
        for (GsbpmProcess process : processList) {
            matrix.put(x + "_" + y, process);
            if (isFirst) {
                parent = process.getId(); //register code of first process
                isFirst = false;
            }
            x++;
        }

        //Subprocesses rows (x>=0, y>=1)
        List<GsbpmProcess> subprocessList = this.findAllSubProcesses();
        x = 0;
        y = 0;
        for (GsbpmProcess process : subprocessList) {
            if (process.getGsbpmProcessParent().getId() != parent) {
                parent = process.getGsbpmProcessParent().getId();
                x++;
                y = 1;
            } else {
                y++;
            }
            matrix.put(x + "_" + y, process);
        }

        return matrix;
    }

}
