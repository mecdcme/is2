package it.istat.is2.catalogue.relais.utility;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import org.json.JSONArray;
import org.json.JSONObject;

import it.istat.is2.catalogue.relais.bean.OrderBean;

public class RelaisUtility {

	private static final String KEY_SEPARATOR = "@_@";

	public static Map<String, List<String>> getEmptyMapByKey(Stream<String> keys, String prefixKey) {

		final Map<String, List<String>> valuesMap = new LinkedHashMap<String, List<String>>();
		keys.forEach(key -> valuesMap.put(prefixKey + key, new ArrayList<>()));
		return valuesMap;
	}

	public static Map<String, List<Integer>> blockVariablesIndexMapValues(final Map<String, List<String>> mapValues,
			final List<String> fieldsBlock) {

		final int CHUNK_SIZE = 100;

		final Map<String, List<Integer>> mapIndex = Collections.synchronizedMap(new HashMap<>());
		String fieldBlock = fieldsBlock.get(0);
		int sizeList = mapValues.get(fieldBlock).size();
		int partitionSize = (sizeList / CHUNK_SIZE) + ((sizeList % CHUNK_SIZE) == 0 ? 0 : 1);

		IntStream.range(0, partitionSize).parallel().forEach(chunkIndex -> {

			int inf = (chunkIndex * CHUNK_SIZE);
			int sup = (chunkIndex == partitionSize - 1) ? sizeList - 1 : (inf + CHUNK_SIZE - 1);

			final Map<String, List<Integer>> mapValueIndexesI = new HashMap<>();
			IntStream.rangeClosed(inf, sup).forEach(innerIndex -> {
				String keyValues = getKeyValues(innerIndex, mapValues, fieldsBlock);
				mapValueIndexesI.computeIfAbsent(keyValues, v -> new ArrayList<>()).add(innerIndex);

			});

			synchronized (mapIndex) {
				mapValueIndexesI.forEach((k, values) -> {
					mapIndex.computeIfAbsent(k, v -> new ArrayList<>()).addAll(values);

				});

			}

		});

		return mapIndex;
	}

	public static String getKeyValues(final Integer index, final Map<String, List<String>> mapValues,
			final List<String> fieldsBlock) {
		final StringBuffer keyValues = new StringBuffer();

		fieldsBlock.forEach(field -> keyValues.append(mapValues.get(field).get(index)).append(KEY_SEPARATOR));

		keyValues.delete(keyValues.length() - KEY_SEPARATOR.length(), keyValues.length());
		return keyValues.toString();
	}

	public static boolean isNullOrEmpty(final Collection<?> c) {
		return c == null || c.isEmpty();
	}

	public static boolean isNullOrEmpty(final Map<?, ?> m) {
		return m == null || m.isEmpty();
	}

	public static List<String> getFieldsInParams(String jsonString, String fieldName) throws Exception {
		List<String> ret = new ArrayList<>();
		try {
			JSONObject jSONObject = new JSONObject(jsonString);
			JSONArray fields = jSONObject.getJSONArray(fieldName);
			for (int i = 0; i < fields.length(); i++) {
				ret.add(fields.getString(i));
			}

		} catch (Exception e) {

			throw new Exception("Error parsing parameter " + fieldName);
		}

		return ret;

	}

	public static Map<String, List<String>> sortDatasetInMapValues(final Map<String, List<String>> mapValues,
			final List<String> datasetFields, final String fieldSort, final String sortAsc) {

		List<OrderBean> valuesElements = new ArrayList<>();
		for (int i = 0; i < mapValues.get(fieldSort).size(); i++) {
			valuesElements.add(new OrderBean(i, mapValues.get(fieldSort).get(i)));
		}

		Collections.sort(valuesElements);

		datasetFields.stream().forEach(fields -> {
			final List<String> valuesOrdered = new ArrayList<>();
				// indexArraySortedList.forEach(index ->
			// valuesOrdered.add(mapValues.get(fields).get(index)));
			for (OrderBean indexElement : valuesElements) {
				valuesOrdered.add(mapValues.get(fields).get(indexElement.getIndex()));
			}
			mapValues.replace(fields, valuesOrdered);

		});
		valuesElements.clear();
		return mapValues;
	}

	public static void printNElementsInMapValues(final Map<String, List<String>> mapValues, int nValues) {

		List<String> keys = new ArrayList<>(mapValues.keySet());
		keys.forEach(key -> {
			System.out.print(key + ";");

		});
		System.out.println();
		int[] position = new int[] { 0 };
		while (position[0] < nValues) {

			keys.forEach(key -> {
				System.out.print(mapValues.get(key).get(position[0]) + ";");

			});
			position[0]++;
			System.out.println();
		}
	}

}
