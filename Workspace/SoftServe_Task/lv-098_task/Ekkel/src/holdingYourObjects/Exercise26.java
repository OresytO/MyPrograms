/**
 * 
 */
package holdingYourObjects;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import staticPack.TextFile;

/**
 * @author orecto
 * 
 */
/*
 * Take the resulting Map from the previous exercise and re-create the order of
 * the words as they appeared in the original file
 */
public class Exercise26 {
	public static void main(String[] args) {
		Map<String, ArrayList<Integer>> mapOfPosition = new TreeMap<String, ArrayList<Integer>>();
		Map<Integer, String> mapOfOrder = new TreeMap<Integer, String>();
		List<String> listOfWords = new ArrayList<String>(new TextFile(
				"Superpuper.txt", "\\W+"));
		System.out.println("We read next words: " + listOfWords);
		Iterator<String> it = listOfWords.iterator();
		int count = 0;

		while (it.hasNext()) {
			String s = it.next();
			count++;
			if (!mapOfPosition.keySet().contains(s)) {
				ArrayList<Integer> list = new ArrayList<Integer>();
				list.add(count);
				mapOfPosition.put(s, list);
			} else
				mapOfPosition.get(s).add(count);
			mapOfOrder.put(count, s);
		}
		System.out.println("Location of words in the file: " + mapOfPosition);
		System.out.println("Order of words:\t\t" + mapOfOrder);
		System.out.println("Input order of words:\t" + mapOfOrder.values());
	}
}
