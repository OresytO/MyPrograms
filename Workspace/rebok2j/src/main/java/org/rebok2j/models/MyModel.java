package org.rebok2j.models;

import java.util.Map;

/**
 * Created by OrestO
 * on 6/23/2014.
 */
/*It is simple interface to return a model build via Adapter
* in concrete implementation of this interface you just need
* to add to your concrete model elements you need as for me
* it is very simple to use this type of solution*/
public interface MyModel {
    public Map<String, Object> getModel();
}
