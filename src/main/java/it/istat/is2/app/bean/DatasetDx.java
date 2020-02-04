/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.istat.is2.app.bean;

import java.util.List;
import java.util.Map;
import lombok.Data;

@Data
public class DatasetDx {
    
    List<String> columns;
    List<Map<String, String>> data;
    
}
