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
    <h1>List of All Buses</h1>
    <ul>
        <c:forEach var="b" items="${buses}">
            <li>number of route № ${b.routeNumber} has next stops: <c:forEach
                    var="stop" items="${b.stops}">
                    ${stop.name}; 
                </c:forEach></li>
        </c:forEach>
    </ul>
    <h1>List of All Tramwayes</h1>
    <ul>
        <c:forEach var="tw" items="${tramwayes}">
            <li>number of route № ${tw.routeNumber} has next stops: <c:forEach
                    var="stop" items="${tw.stops}">
                    ${stop.name}; 
                </c:forEach></li>
        </c:forEach>
    </ul>
    <h1>List of All Subwayes</h1>
    <ul>
        <c:forEach var="s" items="${subwayes}">
            <li>number of route № ${s.routeNumber} has next stops: <c:forEach
                    var="stop" items="${s.stops}">
                    ${stop.name}; 
                </c:forEach></li>
        </c:forEach>
    </ul>
    <h1>List of All Trolleybuses</h1>
    <ul>
        <c:forEach var="tr" items="${trolleybuses}">
            <li>number of route № ${tr.routeNumber} has next stops: <c:forEach
                    var="stop" items="${tr.stops}">
                    ${stop.name}; 
                </c:forEach></li>
        </c:forEach>
    </ul>
    <FORM NAME="form1" METHOD="POST">
        <INPUT TYPE="HIDDEN" NAME="buttonName"> 
        <INPUT TYPE="BUTTON" VALUE="Add stop to route" ONCLICK="button1()"> 
        <INPUT TYPE="BUTTON" VALUE="Remove stop from route" ONCLICK="button2()">
    </FORM>

    <SCRIPT LANGUAGE="JavaScript">
    <!--
        function button1() {
            document.form1.action = "adding";
            form1.submit();
        }
        function button2() {
            // document.form1.buttonName.value = "button 2"
            document.form1.action="test2";
            form1.submit();
        }
    // -->
    </SCRIPT>
</body>
</html>