package org.rebok2j.service;

public interface RebokService<K> {

    K fillElement(String queryName) throws InstantiationException, IllegalAccessException;

}
