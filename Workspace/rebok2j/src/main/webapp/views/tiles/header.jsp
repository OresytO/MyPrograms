<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

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
    <a class="btn btn-small btn-primary" href="/login" id="getContentLogin"> <spring:message code="label.loginOrRegistration" /></a>
    <a class="btn btn-small btn-primary" href="/logout" id="getContentLogout"> <spring:message code="label.logout" /></a>
</div>