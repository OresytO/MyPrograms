package com.rebok3J.dao.impl;

import com.rebok3J.model.CommonQueryHolder;
import com.rebok3J.model.UserQueryHolder;
import org.springframework.stereotype.Repository;

import com.rebok3J.dao.DaoAbstract;
import com.rebok3J.dao.UserDao;
import com.rebok3J.model.impl.User;

import javax.persistence.TypedQuery;
import java.util.List;

/**
 * Created by OrestO on 3/12/2015.
 */

@Repository
public class UserDaoImpl extends DaoAbstract<User> implements UserDao
{

}
