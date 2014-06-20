<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<div class="globalDiv">
    <form id="addNewDelivery" method="post" style="text-align: left">
        <fieldset>
            <legend class="legend">
                <strong><spring:message code="label.addNewDelivery" /> <sec:authentication property="name" /></strong>
            </legend>
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

            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.placeOfReceiving" /></strong>
                        </legend>
                        <select class="dropDown" name="placeOfReceiving" onchange="javascript:onChange(this);">
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
                            <strong><spring:message code="label.placeOfDeparture" /></strong>
                        </legend>
                        <select class="dropDown" name="placeOfDeparture" onchange="javascript:onChange(this);">
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

            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.weight" /></strong>
                        </legend>
                        <select class="dropDown" name="weight" onchange="javascript:onChange(this);">
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
                            <strong><spring:message code="label.size" /></strong>
                        </legend>
                        <select class="dropDown" name="size" onchange="javascript:onChange(this);">
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

            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.departurDate" /></strong>
                        </legend>
                        <select class="dropDown" name="departurDate" onchange="javascript:onChange(this);">
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
                            <strong><spring:message code="label.receiveDate" /></strong>
                        </legend>
                        <select class="dropDown" name="receiveDate" onchange="javascript:onChange(this);">
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

        </fieldset>

        <input type="submit" name="_eventId_next" value="next" /> <br /> <input type="submit" name="_eventId_prev" value="prev" /> Try clicking this to go back <br /> <input
            type="submit" name="_eventId_startOver" value="startOver" />
    </form>
</div>
