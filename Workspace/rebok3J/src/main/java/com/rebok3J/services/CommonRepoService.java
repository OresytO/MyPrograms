package com.rebok3J.services;

import java.util.List;

import org.springframework.stereotype.Service;

/**
 * @author OrestO
 * @since 3/29/2015
 */

@Service
public interface CommonRepoService<T>
{
  T findById(Long id);

  List<T> loadAll() throws InstantiationException, IllegalAccessException;

}
