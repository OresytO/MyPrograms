<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ page session="false"%>

<div>
    <span style="float: right"> <a href="?lang=en">en</a> | <a href="?lang=ua">ua</a>
    </span> <em><strong> <font size="5">Гість</font></strong></em> <em><strong> <font size="5"><spring:message
                    code="label.guest"
                /></font>
    </strong></em>
</div>
<div>
    <a class="btn btn-small btn-primary" href="login" id="getContentLogin">loginOrRegistration"</a>
    <%-- <a class="btn btn-small btn-primary"
		href="<c:url value="/j_spring_security_logout"/>">label.logout</a> --%>
    <a class="btn btn-small btn-primary" href="logout" id="getContentLogou">label.logout"</a>
</div>