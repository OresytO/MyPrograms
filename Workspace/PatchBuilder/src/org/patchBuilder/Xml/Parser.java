package org.patchBuilder.Xml;

import java.util.List;
import java.util.Map;

public interface Parser {
    Map<Integer, List<String>> parse(String path, List<String> tags);
}
