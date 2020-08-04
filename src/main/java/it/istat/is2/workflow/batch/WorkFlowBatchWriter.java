package it.istat.is2.workflow.batch;

import java.util.List;

import org.springframework.batch.item.ItemWriter;

import it.istat.is2.workflow.domain.DataProcessing;

public class WorkFlowBatchWriter implements ItemWriter<DataProcessing> {

    @Override
    public void write(List<? extends DataProcessing> items) throws Exception {

    }


}
