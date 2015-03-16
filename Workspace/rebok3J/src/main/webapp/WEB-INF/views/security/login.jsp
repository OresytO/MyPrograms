<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<title><spring:message code="label.login" /></title>
<style>

  .login-form {

  }

  .control-label {

  }

  .field {

  }
</style>

<fieldset>
  <legend style="color: green" align="left">
    <strong><fmt:message key="label.login" /></strong>
  </legend>
  <form id="loginForm" class="login-form" action="/login" method="post" style="text-align: left">
    <label class="control-label" for="username"> <fmt:message key="label.userName" /> </label>
    <input id="username" name="username" size="20" maxlength="50" type="text" /> <br>

    <label for="password"> <fmt:message key="label.password" /> </label>
    <input id="password" name="password" size="20" maxlength="50" type="password" /> <br>

    <input class="btn btn-primary" type="submit" value="<fmt:message key='label.enter'/>" />
    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}"/>
  </form>
</fieldset>
