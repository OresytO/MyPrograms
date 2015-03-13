package com.rebok3J.dao.impl;

import org.springframework.stereotype.Repository;

import com.rebok3J.dao.DaoAbstract;
import com.rebok3J.dao.UserDao;
import com.rebok3J.model.impl.UserImpl;

/**
 * Created by OrestO on 3/12/2015.
 */

@Repository
public class UserDaoImpl extends DaoAbstract<UserImpl> implements UserDao
{
}
