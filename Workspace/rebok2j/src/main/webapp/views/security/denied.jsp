<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Insert title here</title>
</head>
<body>
<strong><spring:message code="label.denied" /></strong>
<fieldset>
  <legend style="color: green" align="left">
    <strong><spring:message code="label.login" /></strong>
  </legend>
  <form id="loginForm" class="login-form" action="j_spring_security_check" method="post" style="text-align: left">
    <label class="control-label" for="j_username"> <spring:message code="label.userName" />
    </label> <input id="j_username" name="j_username" size="20" maxlength="50" type="text" /> <br> <label
    for="j_password"
    > <spring:message code="label.password" />
  </label> <input id="j_password" name="j_password" size="20" maxlength="50" type="password" /> <br> <input
    class="btn btn-primary" type="submit" value="<spring:message code="label.enter"/>"
    />
  </form>
</fieldset>
<form action="">
  <a class="btn btn-link" href="registration" id="registration"> <spring:message code="label.registration" />
  </a>
</form>
</body>
</html>