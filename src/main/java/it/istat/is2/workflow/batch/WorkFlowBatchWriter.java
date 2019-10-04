package it.istat.is2.workflow.batch;

import java.util.List;

import org.springframework.batch.item.ItemWriter;

import it.istat.is2.workflow.domain.Elaborazione;

public class WorkFlowBatchWriter implements ItemWriter<Elaborazione> {

	@Override
	public void write(List<? extends Elaborazione> items) throws Exception {
		
	}


}
