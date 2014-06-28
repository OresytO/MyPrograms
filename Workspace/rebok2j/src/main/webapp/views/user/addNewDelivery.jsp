<%@ page import="org.rebok2j.utils.WebConstants" %>
<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<c:set var="addNewOneLabel"><spring:message code="label.addNewOne" /></c:set>
<c:set var="allDeliveryType" value="<%=WebConstants.ALL_DELIVERY_TYPES%>" />
<c:set var="allLocation" value="<%=WebConstants.ALL_LOCATIONS%>" />
<c:set var="allCourierCompany" value="<%=WebConstants.ALL_COURIER_COMPANIES%>" />

<%

%>

<div class="globalDiv">
  <form id="addNewDelivery" method="post" style="text-align: left">
    <fieldset>
      <legend class="legend">
        <strong><spring:message code="label.addNewDelivery" /> <sec:authentication property="name" /></strong>
      </legend>

      <div class="blockDiv">
        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.type" /></strong>
            </legend>
            <select class="dropDown" name="type" onchange="onChange(this, '${addNewOneLabel}')">
              <c:forEach var="type" items="${requestScope[allDeliveryType]}">
                <c:if test="type.type">
                  <option selected="selected" value="${type.id}">${type.type}</option>
                </c:if>
                <option value="${type.id}">${type.type}</option>
              </c:forEach>
              <option value="addNewOne"><spring:message code="label.addNewOne" /></option>
            </select>
          </fieldset>
        </div>
        <%--.innerDiv--%>

        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.placeOfReceiving" /></strong>
            </legend>
            <select class="dropDown" name="placeOfReceiving" onchange="onChange(this, '${addNewOneLabel}');">
              <c:forEach var="placeOfReceiving" items="${requestScope[allLocation]}">
                <c:if test="placeOfReceiving.value">
                  <option selected="selected" value="${placeOfReceiving.id}">${placeOfReceiving.locationName}</option>
                </c:if>
                <option value="${placeOfReceiving.id}">${placeOfReceiving.locationName}</option>
              </c:forEach>
              <option value="addNewOne"><spring:message code="label.addNewOne" /></option>
            </select>
          </fieldset>
        </div>
        <%--.innerDiv--%>

        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.placeOfDeparture" /></strong>
            </legend>
            <select class="dropDown" name="placeOfDeparture" onchange="onChange(this, '${addNewOneLabel}');">
              <c:forEach var="placeOfDeparture" items="${requestScope[allLocation]}">
                <c:if test="placeOfDeparture.value">
                  <option selected="selected" value="${placeOfDeparture.id}">${placeOfDeparture.locationName}</option>
                </c:if>
                <option value="${placeOfDeparture.id}">${placeOfDeparture.locationName}</option>
              </c:forEach>
              <option value="addNewOne"><spring:message code="label.addNewOne" /></option>
            </select>
          </fieldset>
        </div>
        <%--.innerDiv--%>
      </div>
      <%--.blockDiv--%>

      <div class="blockDiv">
        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.weight" /></strong>
            </legend>
            <input class="dropDown" name="weight" type="text" />
          </fieldset>
        </div>
        <%--.innerDiv--%>

        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.size" /></strong>
            </legend>
            <input class="dropDown" name="size" type="text" />
          </fieldset>
        </div>
        <%--.innerDiv--%>

        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.departurDate" /></strong>
            </legend>
            <input class="dropDown" name="departurDate" type="date" />
          </fieldset>
        </div>
        <%--.innerDiv--%>
      </div>
      <%--.blockDiv--%>

      <div class="blockDiv">
        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.receiveDate" /></strong>
            </legend>
            <input class="dropDown" name="receiveDate" type="date" />
          </fieldset>
        </div>
        <%--.innerDiv--%>

        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.courierCompany" /></strong>
            </legend>
            <select class="dropDown" name="courierCompany"
                    onchange="onChange(this, <spring:message code="label.addNewOne" />);">
              <c:forEach var="courierCompany" items="${requestScope[allCourierCompany]}">
                <c:if test="courierCompany.value">
                  <option selected="selected" value="${courierCompany.id}">${courierCompany.companyName} ${courierCompany.warehouseCode}</option>
                </c:if>
                <option value="${courierCompany.id}">${courierCompany.companyName} ${courierCompany.warehouseCode}</option>
              </c:forEach>
              <option value="addNewOne"><spring:message code="label.addNewOne" /></option>
            </select>
          </fieldset>
        </div>
        <%--.innerDiv--%>

        <div class="innerDiv">
          <fieldset>
            <legend class="legend">
              <strong><spring:message code="label.contactPerson" /></strong>
            </legend>
            <input class="dropDown" name="contactPerson" type="text" />
          </fieldset>
        </div>
        <%--.innerDiv--%>
      </div>
      <%--.blockDiv--%>

    </fieldset>

    <input type="submit" name="_eventId_next" value="next" />
    <br />
    <input type="submit" name="_eventId_prev" value="prev" />
    Try clicking this to go back
    <br />
    <input type="submit" name="_eventId_startOver" value="startOver" />
  </form>
</div>
