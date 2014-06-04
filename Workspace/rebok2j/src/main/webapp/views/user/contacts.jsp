<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="blockDiv">
    <div class="innerDiv">
        <fieldset>
            <legend class="legend">
                <strong><spring:message code="label.courierCompany" /></strong>
            </legend>
            <select class="dropDown" name="courierCompany" onchange="javascript:onChange(this);">
                <c:forEach var="user" items="${users.map}">
                    <c:if test="user.value">
                        <option selected="selected" value="${user.key.id}">${user.key.userNickname}</option>
                    </c:if>
                    <option value="${user.key.id}">${user.key.userNickname}</option>
                </c:forEach>
                <option value="addNewOne">
                    <spring:message code="label.addNewOne" />
                </option>
            </select>
        </fieldset>
    </div>
    <div class="innerDiv">
        <fieldset>
            <legend class="legend">
                <strong><spring:message code="label.contactPerson" /></strong>
            </legend>
            <select class="dropDown" name="contactPerson" onchange="javascript:onChange(this);">
                <c:forEach var="user" items="${users.map}">
                    <c:if test="user.value">
                        <option selected="selected" value="${user.key.id}">${user.key.userNickname}</option>
                    </c:if>
                    <option value="${user.key.id}">${user.key.userNickname}</option>
                </c:forEach>
                <option value="addNewOne">
                    <spring:message code="label.addNewOne" />
                </option>
            </select>
        </fieldset>
    </div>
</div>

