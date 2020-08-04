/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.graph.bean;

import lombok.Data;

@Data
public class Point {

    private String x;
    private String y;

    public Point(String x, String y) {
        this.x = x;
        this.y = y;
    }

}
