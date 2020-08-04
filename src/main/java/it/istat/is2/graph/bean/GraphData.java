/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.graph.bean;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class GraphData {

    private Map<String, List<String>> filter;
    private Map<String, List<String>> xAxis;
    private Map<String, List<String>> yAxis;

    public GraphData(Map<String, List<String>> filter, Map<String, List<String>> xAxis, Map<String, List<String>> yAxis) {
        this.filter = filter;
        this.xAxis = xAxis;
        this.yAxis = yAxis;
    }
}
