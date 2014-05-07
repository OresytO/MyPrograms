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
	<h1>List of All Tramwayes</h1>
	<ul>
		<c:forEach var="tw" items="${tramwayes}">
			<li>number of route № ${tw.routeNumber} has next stops: <c:forEach
					var="stop" items="${tw.stops}">
                    ${stop.name}; 
                </c:forEach>
				<FORM NAME="${tw.id} + tramwayes" METHOD="POST">
					<input type="text" name="Name" /> <input type="HIDDEN"
						name="vechicleId" value="${tw.id}" /> <input type="HIDDEN"
						name="vechicleType" value="tramway" /> <INPUT TYPE="submit"
						VALUE="Add stop">
				</FORM>
			</li>
		</c:forEach>
	</ul>
	<FORM NAME="Adding route" METHOD="GET">
		<input type="text" name="Name" /> <input type="HIDDEN"
			name="vechicleId" value="${tw.id}" /> <input type="HIDDEN"
			name="vechicleType" value="tramway" /> <INPUT TYPE="submit"
			VALUE="Add route">
	</FORM>

</body>
</html>