package com.rebok3J.model;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.SqlResultSetMapping;

import com.rebok3J.web.forms.elements.SelectDTO;

/**
 * @author OrestO
 * @since 3/30/2015
 */

@SqlResultSetMapping(
    name = "resultForSelect",
    classes = {
        @ConstructorResult(
            targetClass = SelectDTO.class,
            columns = {
                @ColumnResult(name = "personId"),
                @ColumnResult(name = "birthDate")
            })
    })
public class AbstractModel
{

}
