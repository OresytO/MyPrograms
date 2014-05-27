<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>first JSP</h2>
<h3>Enter Personal Details ${user.userNickname}</h3>
<form action="" method="post">
    <input type="text" /> <br /> <input type="submit" name="_eventId_next" value="next" /> <br /> <input
        type="submit" name="_eventId_get" value="get" />
</form>
<select name="year">
    <c:forEach var="user" items="${users}">
        <option value="${user.id}">${user.userNickname}</option>
    </c:forEach>
</select>
<fieldset>
    <legend style="color: green" align="left">
        <strong><spring:message code="label.addNewDelivery" /></strong>
    </legend>
    <form id="addNewDelivery" action="" method="post" style="text-align: left">
        <fieldset>
            <legend style="color: green" align="left">
                <strong><spring:message code="label.deliveryType" /></strong>
            </legend>
            <select id="deliveryType">
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}">${user.userNickname}</option>
                </c:forEach>
            </select>
        </fieldset>
        <fieldset>
            <legend style="color: green" align="left">
                <strong><spring:message code="label.departurDate" /></strong>
            </legend>
            <select id="departurDate">
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}">${user.userNickname}</option>
                </c:forEach>
            </select>
        </fieldset>
        <fieldset>
            <legend style="color: green" align="left">
                <strong><spring:message code="label.receiveDate" /></strong>
            </legend>
            <select id="receiveDate">
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}">${user.userNickname}</option>
                </c:forEach>
            </select>
        </fieldset>
        <br>
        <fieldset>
            <legend style="color: green" align="left">
                <strong><spring:message code="label.placeOfDeparture" /></strong>
            </legend>
            <select id="placeOfDeparture">
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}">${user.userNickname}</option>
                </c:forEach>
            </select>
        </fieldset>
        <fieldset>
            <legend style="color: green" align="left">
                <strong><spring:message code="label.courierCompany" /></strong>
            </legend>
            <select id="courierCompany">
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}">${user.userNickname}</option>
                </c:forEach>
            </select>
        </fieldset>
        <fieldset>
            <legend style="color: green" align="left">
                <strong><spring:message code="label.contactPerson" /></strong>
            </legend>
            <select id="contactPerson">
                <c:forEach var="user" items="${users}">
                    <option value="${user.id}">${user.userNickname}</option>
                </c:forEach>
            </select>
        </fieldset>
        <br> <label for="weight"> <spring:message code="label.weight" />
        </label><br> <select id="weight">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <br> <label for="size"> <spring:message code="label.size" />
        </label><br> <select id="size">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <br> <input type="submit" value="<spring:message code="label.enter"/>" />
    </form>
</fieldset>
