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

    @Pointcut("execution(* org.orest.transport.repo.*.find*(..))")
    private void findAll() {
    }

    @Pointcut("execution(* org.orest.transport.repo.*.add*(..))")
    private void addAll() {
    }

    @Pointcut("execution(* org.orest.transport.repo.*.remove*(..))")
    private void removeAll() {
    }

    @Before("addAll()")
    public void logginingBeforeAdd() {
        log.info("logginingBeforeAdd");
    }

    @Before("removeAll()")
    public void logginingBeforeRemove() {
        log.info("logginingBeforeRemove");
    }

    @AfterReturning(pointcut = "addAll()", returning = "retVal")
    public void logginingAfterAdd(Object retVal) {
        log.debug("logginingAfterAdd 111");
    }

    @AfterReturning(pointcut = "removeAll()", returning = "retVal")
    public void logginingAfterRemove(Object retVal) {
        log.info("logginingAfterRemove 111");
    }

    @AfterReturning(pointcut = "findAll()", returning = "retVal")
    public void logginingAfterFind(Object retVal) {
        log.info("logginingAfterFind " + retVal.toString());
    }
}
