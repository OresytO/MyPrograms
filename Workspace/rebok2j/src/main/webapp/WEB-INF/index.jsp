<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transport</title>
</head>
<body>
	<h1>List of All Tramway Routes</h1>
	<ul>
		<c:forEach var="tw" items="${tramwayes}">
			<li>number of route № ${tw.numOfRoute} has next stops: <c:forEach
					var="stop" items="${tw.stops}">
                    ${stop.name}; 
                </c:forEach>
				<FORM NAME="tramwayes${tw.id}" METHOD="POST">
					<input type="text" name="Name" /> 
					<input type="HIDDEN" name="routeId" value="${tw.id}" /> 
					<input type="HIDDEN" name="routeType" value="tramwayRoute" /> 
					<INPUT NAME="AddStop" TYPE="button" VALUE="Add stop" onClick="javascript:button1(this.form);">
					<INPUT NAME="RemoveStop" TYPE="button" VALUE="Remove stop" onClick="javascript:button2(this.form);">
				</FORM>
			</li>
		</c:forEach>
	</ul>
	<FORM NAME="Adding route" METHOD="POST">
		Enter № of route <input type="text" name="numOfRoute" /> 
		<input type="HIDDEN" name="routeType" value="tramwayRoute" /> 
		<INPUT NAME="AddRoute" TYPE="button" VALUE="Add Route" onClick="javascript:button3(this.form);"> 
		<INPUT NAME="RemoveRoute" TYPE="button" VALUE="Remove Route" onClick="javascript:button4(this.form);">
	</FORM>
	<h1>List of All Bus Routes</h1>
	<ul>
		<c:forEach var="tw" items="${buses}">
			<li>number of route № ${tw.numOfRoute} has next stops: <c:forEach
					var="stop" items="${tw.stops}">
                    ${stop.name}; 
                </c:forEach>
				<FORM NAME="bus${tw.id}" METHOD="POST">
					<input type="text" name="Name" /> <input type="HIDDEN"
						name="routeId" value="${tw.id}" /> <input type="HIDDEN"
						name="routeType" value="busRoute" /> <INPUT NAME="AddStop"
						TYPE="button" VALUE="Add stop"
						onClick="javascript:button1(this.form);"><INPUT
						NAME="RemoveStop" TYPE="button" VALUE="Remove stop"
						onClick="javascript:button2(this.form);">
				</FORM>
			</li>
		</c:forEach>
	</ul>
	<FORM NAME="Adding route" METHOD="POST">
		Enter № of route <input type="text" name="numOfRoute" /> <input
			type="HIDDEN" name="routeType" value="busRoute" /> <INPUT
			NAME="AddRoute" TYPE="button" VALUE="Add Route"
			onClick="javascript:button3(this.form);"> <INPUT
			NAME="RemoveRoute" TYPE="button" VALUE="Remove Route"
			onClick="javascript:button4(this.form);">
	</FORM>
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		function button1(form) {
			form.action = "adding";
			form.submit();
		}

		function button2(form) {
			form.action = "removeStop";
			form.submit();
		}

		function button3(form) {
			form.action = "addRoute";
			form.submit();
		}

		function button4(form) {
			form.action = "removeRoute";
			form.submit();
		}
	// -->
	</SCRIPT>
</body>
</html>