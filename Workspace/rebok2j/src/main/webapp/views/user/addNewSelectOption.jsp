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
    <form id="addNewSelectOption" method="post" style="text-align: left">
        <fieldset>
            <legend class="legend">
                <strong><spring:message code="label.addNewSelectOption" /> <sec:authentication property="name" /></strong>
            </legend>
        </fieldset>

        <input type="submit" name="_eventId_add" value="<spring:message code="label.add" />" formaction="/addNewSelectOption/add" formmethod="post"/> <br /> 
        <input type="submit" name="_eventId_back" value="<spring:message code="label.back" />" formaction="/addNewSelectOption/back" formmethod="post" />
    </form>
</div>
