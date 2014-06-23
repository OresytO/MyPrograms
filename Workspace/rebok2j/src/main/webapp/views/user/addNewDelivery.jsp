<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<c:set var="val"><spring:message code="label.addNewOne"/></c:set>

<div class="globalDiv">
    <form id="addNewDelivery" method="post" style="text-align: left">
        <fieldset>
            <legend class="legend">
                <strong><spring:message code="label.addNewDelivery"/> <sec:authentication property="name"/></strong>
            </legend>
            <div class="innerDiv">
                <fieldset>
                    <legend class="legend">
                        <strong><spring:message code="label.deliveryType"/></strong>
                    </legend>
                    <select class="dropDown" name="deliveryType" onchange="javascript:onChange(this, '${val}')" >
                        <c:forEach var="deliveryType" items="${deliveryTypeDropDown.map}">
                            <c:if test="deliveryType.value">
                                <option selected="selected"
                                        value="${deliveryType.key.id}">${deliveryType.key.deliveryType}</option>
                            </c:if>
                            <option value="${deliveryType.key.id}">${deliveryType.key.deliveryType}</option>
                        </c:forEach>
                        <option value="addNewOne">
                            <spring:message code="label.addNewOne"/>
                        </option>
                    </select>
                </fieldset>
            </div>

            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.placeOfReceiving"/></strong>
                        </legend>
                        <select class="dropDown" name="placeOfReceiving" onchange="javascript:onChange(this, '${val}');">
                            <c:forEach var="location" items="${locationDropDown.map}">
                                <c:if test="location.value">
                                    <option selected="selected"
                                            value="${location.key.id}">${location.key.locationName}</option>
                                </c:if>
                                <option value="${location.key.id}">${location.key.locationName}</option>
                            </c:forEach>
                            <option value="addNewOne">
                                <spring:message code="label.addNewOne"/>
                            </option>
                        </select>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.placeOfDeparture"/></strong>
                        </legend>
                        <select class="dropDown" name="placeOfReceiving" onchange="javascript:onChange(this, '${val}');">
                            <c:forEach var="location" items="${locationDropDown.map}">
                                <c:if test="location.value">
                                    <option selected="selected"
                                            value="${location.key.id}">${location.key.locationName}</option>
                                </c:if>
                                <option value="${location.key.id}">${location.key.locationName}</option>
                            </c:forEach>
                            <option value="addNewOne">
                                <spring:message code="label.addNewOne"/>
                            </option>
                        </select>
                    </fieldset>
                </div>
            </div>

            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.weight"/></strong>
                        </legend>
                        <input class="dropDown" name="weight" type="text"/>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.size"/></strong>
                        </legend>
                        <input class="dropDown" name="size" type="text"/>
                    </fieldset>
                </div>
            </div>

            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.departurDate"/></strong>
                        </legend>
                        <input class="dropDown" name="departurDate" type="date"/>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.receiveDate"/></strong>
                        </legend>
                        <input class="dropDown" name="receiveDate" type="date"/>
                    </fieldset>
                </div>
            </div>

            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.courierCompany"/></strong>
                        </legend>
                        <select class="dropDown" name="courierCompany" onchange="javascript:onChange(this, <spring:message code="label.addNewOne" />);">
                            <c:forEach var="courierCompany" items="${courierCompanyDropDown.map}">
                                <c:if test="courierCompany.value">
                                    <option selected="selected"
                                            value="${courierCompany.key.id}">${courierCompany.key.companyName} ${courierCompany.key.warehouseCode}</option>
                                </c:if>
                                <option value="${courierCompany.key.id}">${courierCompany.key.companyName} ${courierCompany.key.warehouseCode}</option>
                            </c:forEach>
                            <option value="addNewOne">
                                <spring:message code="label.addNewOne"/>
                            </option>
                        </select>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.contactPerson"/></strong>
                        </legend>
                        <input class="dropDown" name="contactPerson" type="text"/>
                    </fieldset>
                </div>
            </div>

        </fieldset>

        <input type="submit" name="_eventId_next" value="next"/> <br/> <input type="submit" name="_eventId_prev"
                                                                              value="prev"/> Try clicking this to go
        back <br/> <input
            type="submit" name="_eventId_startOver" value="startOver"/>
    </form>
</div>
