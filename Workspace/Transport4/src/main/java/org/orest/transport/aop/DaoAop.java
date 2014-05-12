package org.orest.transport.aop;

import org.apache.log4j.Logger;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class DaoAop {

    public static Logger log = Logger.getLogger(DaoAop.class.getName());

    @Pointcut("execution(* org.orest.transport.repo.Dao.findAllStops())")
    private void addAll() {
    }

    @Pointcut("execution(* org.orest.transport.repo.*remove*(..))")
    private void removeAll() {
    }

    @Before("addAll()")
    public void logginingBeforeAdd() {
        System.out.println("logginingBeforeAdd");
        log.info("logginingBeforeAdd");
    }

    @Before("removeAll()")
    public void logginingBeforeRemove() {
        System.out.println("logginingBeforeRemove");
        log.info("logginingBeforeRemove");
    }

    @AfterReturning(pointcut = "addAll()", returning = "retVal")
    public void logginingAfterAdd(Object retVal) {
        System.out.println("logginingAfterAdd " + retVal.getClass().getSimpleName());
        log.info("logginingAfterAdd " + retVal.getClass().getSimpleName());
    }

    @AfterReturning(pointcut = "removeAll()", returning = "retVal")
    public void logginingAfterRemove(Object retVal) {
        System.out.println("logginingAfterRemove " + retVal.getClass().getSimpleName());
        log.info("logginingAfterRemove " + retVal.getClass().getSimpleName());
    }
}
