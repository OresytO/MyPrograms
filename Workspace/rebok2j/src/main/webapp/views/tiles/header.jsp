<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page session="false"%>

<div>
    <span style="float: right"> <a href="?lang=en">en</a> | <a href="?lang=ua">ua</a>
    </span>
    <sec:authorize access="isAnonymous()">
        <em><strong> <font size="3" color="#FFFFFF"><spring:message code="label.guest" /></font></strong></em>
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
        <em><strong> <font size="3" color="#FFFFFF"><spring:message code="label.welcome" /> <sec:authentication property="name" /> </font></strong></em>
    </sec:authorize>
</div>
<div>
    <a class="btn btn-small btn-primary" href="/login" id="getContentLogin"> <spring:message code="label.loginOrRegistration" />
    </a> <a class="btn btn-small btn-primary" href="/logout" id="getContentLogout"> <spring:message code="label.logout" />
    </a>
</div>