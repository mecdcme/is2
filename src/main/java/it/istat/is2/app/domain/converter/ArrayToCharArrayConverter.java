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
package it.istat.is2.app.domain.converter;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;

@Converter
public class ArrayToCharArrayConverter implements AttributeConverter<char[][], String> {
    final static Logger logger = Logger.getLogger(ArrayToCharArrayConverter.class);

    @Override
    public String convertToDatabaseColumn( char[][] data) {
        String value = null;

        if (data != null) {
            JSONArray allDataArray = new JSONArray();

            for (int index = 0; index < data.length; index++) {

                allDataArray.put(data[index] != null ? String.valueOf(data[index]) : "");
            }

            value = allDataArray.toString();
        }

        return value;
    }

    @Override
    public  char[][]  convertToEntityAttribute(String data) {
         char[][]  listValue = null;
         try {
            if (data != null) {
            	
                JSONArray jsonArray = new JSONArray(data);
                listValue=new char[jsonArray.length()][];
                for (int i = 0; i < jsonArray.length(); i++) {
                    listValue[i]=jsonArray.get(i).toString().toCharArray();
                }
            }
        } catch (JSONException e) {

            logger.error(e);
            logger.error(data);
        }
        return listValue;
    }

}
