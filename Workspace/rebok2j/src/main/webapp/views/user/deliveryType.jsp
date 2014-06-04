<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="innerDiv">
    <fieldset>
        <legend class="legend">
            <strong><spring:message code="label.deliveryType" /></strong>
        </legend>
        <select class="dropDown" name="deliveryType" onchange="javascript:onChange(this);">
            <c:forEach var="user" items="${users}">
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
