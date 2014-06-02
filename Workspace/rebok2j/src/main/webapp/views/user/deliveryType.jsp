<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- <style>
.globalDiv {
	background: black;
}

.blockDiv {
	position: relative;
}

.innerDiv {
	height: 33.33%;
	width: 33.33%;
	float: left;
	position: relative;
	background: aqua;
}

.text,.dropDown,.globalDiv,.innerSet {
	font-family: Arial, sans-serif;
	font-size: 12pt;
}

.dropDown {
	width: 350px;
	height: 50%;
	width: 60%;
	background: #FFE680;
}

.legend {
	color: green;
	align: left;
}
</style>

<script type="text/javascript">
	function onChange(select) {
		var selectedOption = select.options[select.selectedIndex];
		if (selectedOption.label == 'Add new one') {
			// window.location.href = "/welcome";
			var form = document.getElementById("addNewDelivery");
			form.action = "/addNewSelectOption";
			form.submit();
		}
	}
</script> -->

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
