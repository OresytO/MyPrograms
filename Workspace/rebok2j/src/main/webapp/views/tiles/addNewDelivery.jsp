<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<style>
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
</script>

<div class="globalDiv">
    <form id="addNewDelivery" method="post" style="text-align: left">
        <fieldset>
            <legend class="legend">
                <strong><spring:message code="label.addNewDelivery" /> <sec:authentication property="name" /></strong>
            </legend>
            <tiles:insertAttribute name="base.addNewDelivery.body" />
        </fieldset>
        ${returnUrl}
    </form>
</div>
