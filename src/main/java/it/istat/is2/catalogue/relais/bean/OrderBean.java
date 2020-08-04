package it.istat.is2.catalogue.relais.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderBean implements Comparable<OrderBean> {

    int index;
    String value;

    public OrderBean(int index, String value) {
        this.index = index;
        this.value = value;
    }

    @Override
    public int compareTo(OrderBean e) {
        //	return (this.value.compareToIgnoreCase(e.getValue()) == 0) ? this.value.compareToIgnoreCase(e.getValue())
        //			: Integer.compare(this.index, e.getIndex());
        return this.value.compareToIgnoreCase(e.getValue());
    }


    @Override
    public String toString() {
        return "OrderBean [index=" + index + ", value=" + value + "]";
    }
}
