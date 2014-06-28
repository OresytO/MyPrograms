<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<div class="globalDiv">
  <form id="addNewSelectOption" method="post" style="text-align: left">
    <fieldset>
      <legend class="legend">
        <strong><spring:message code="label.addNewSelectOption" /> <sec:authentication property="name" /></strong>
      </legend>
      <%-- TO DO need invoke exect form with existing values list and input field for adding new element must be varification on existing --%>
    </fieldset>

    <input type="submit" name="_eventId_add" value="<spring:message code="label.add" />" formaction="/addNewSelectOption/add" formmethod="post" /> <br />
    <input type="submit" name="_eventId_back" value="<spring:message code="label.back" />" formaction="/addNewSelectOption/back" formmethod="post" />
  </form>
</div>
