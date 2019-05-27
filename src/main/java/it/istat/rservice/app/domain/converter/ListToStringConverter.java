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
package it.istat.rservice.app.domain.converter;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@Converter
public class ListToStringConverter implements AttributeConverter<List<String>, String> {
	final static Logger logger = Logger.getLogger(ListToStringConverter.class);

	@Override
	public String convertToDatabaseColumn(List<String> data) {
		String value = "";
		JSONObject obj = new JSONObject();
		JSONArray allDataArray = new JSONArray();

		JSONObject eachData = null;
		try {

			for (int index = 0; index < data.size(); index++) {
				eachData = new JSONObject();

				eachData.put("r", new Integer(index));

				eachData.put("v", data.get(index) != null ? data.get(index) : "");

				allDataArray.put(eachData);
			}

			obj.put("valori", allDataArray);

			value = obj.toString();
		} catch (JSONException e) {

			logger.error(e);
		}
		return value;
	}

	@Override
	public List<String> convertToEntityAttribute(String data) {
		List<String> listValue = new ArrayList<String>();
		try {
			JSONObject jsonObj = new JSONObject(data);
			JSONArray jsonArray = (JSONArray) jsonObj.get("valori");
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject obj = jsonArray.getJSONObject(i);
				listValue.add(obj.getString("v"));
			}
		} catch (JSONException e) {

			logger.error(e);
		}
		return listValue;
	}

}
