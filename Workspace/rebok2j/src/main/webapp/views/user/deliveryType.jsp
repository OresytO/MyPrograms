<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="innerDiv">
    <fieldset>
        <legend class="legend">
            <strong><spring:message code="label.deliveryType" /></strong>
        </legend>
        <select class="dropDown" name="deliveryType" onchange="javascript:onChange(this);">
            <c:forEach var="deliveryType" items="${deliveryTypeDropDown.map}">
                <c:if test="deliveryType.value">
                    <option selected="selected" value="${deliveryType.key.id}">${deliveryType.key.deliveryType}</option>
                </c:if>
                <option value="${deliveryType.key.id}">${deliveryType.key.deliveryType}</option>
            </c:forEach>
            <option value="addNewOne">
                <spring:message code="label.addNewOne" />
            </option>
        </select>
    </fieldset>
</div>
