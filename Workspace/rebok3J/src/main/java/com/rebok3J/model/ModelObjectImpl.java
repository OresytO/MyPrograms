package com.rebok3J.model;

import java.io.Serializable;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import javax.persistence.MappedSuperclass;

/**
 *
 *
 * @author OrestO
 * @since 3/31/2015
 */
@MappedSuperclass
public abstract class ModelObjectImpl<T extends ModelObject> implements ModelObject, Comparable<T>, Serializable
{

  public int hashCode(@Nonnull Long id)
  {
    final int prime = 31;
    int result = 1;
    result = prime * result + (int) (id ^ (id >>> 32));
    return result;
  }

  public boolean equals(@Nullable T thisObj, @Nullable T thatObj)
  {
    if (thisObj == thatObj)
      return true;
    if (thatObj == null)
      return false;
    if (thisObj == null)
      return false;
    if (thisObj.getClass() != thatObj.getClass())
      return false;
    return thisObj.getId().equals(thatObj.getId());
  }
}
