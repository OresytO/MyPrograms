package com.rebok3J.services;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author OrestO
 * @since 3/29/2015
 */

@Service
public interface CommonRepoService<T>
{
  T findById(Long id);

  List<T> loadAll() throws InstantiationException, IllegalAccessException;

  @Transactional
  void save(T entity);

  @Transactional
  T update(T entity);
}
