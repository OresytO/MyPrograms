/**
 * 
 */
package holdingYourObjects;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import staticPack.TextFile;

/**
 * @author orecto
 * 
 */
/*
 * Create a Map<String,ArrayList<Integer>>. Use net.mindview.TextFile to open a
 * text file and read it in a word at a time (use "\\W+" as the second argument
 * to the TextFile constructor). Count the words as you read them in, and for
 * each word in the file, record in the ArrayList<Integer> the word count
 * associated with that word�this is, in effect, the location in the file where
 * that word was found.
 */
public class Exercise25 {
	public static void main(String[] args) {
		Map<String, ArrayList<Integer>> map = new TreeMap<String, ArrayList<Integer>>();
		List<String> listOfWords = new ArrayList<String>(new TextFile(
				"Superpuper.txt", "\\W+"));
		System.out.println("We read next words: " + listOfWords);
		Iterator<String> it = listOfWords.iterator();
		int count = 0;

		while (it.hasNext()) {
			String s = it.next();
			count++;
			if (!map.keySet().contains(s)) {
				ArrayList<Integer> list = new ArrayList<Integer>();
				list.add(count);
				map.put(s, list);
			} else 
				map.get(s).add(count);
		}
		System.out.println("Location of words in the file: " + map);
	}
}
