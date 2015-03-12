package com.rebok3J.dao;

import java.util.List;

/**
 * Created by OrestO on 3/12/2015.
 */
public interface Dao<T>
{
  T findById(Long id);

  List<T> loadAll() throws IllegalAccessException, InstantiationException;
}
