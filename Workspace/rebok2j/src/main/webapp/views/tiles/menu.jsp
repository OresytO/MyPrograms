<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>


<div id="accordion" align="left">

  <div>
    <p>
      <a class="button" href="/welcome" title="<spring:message code="label.home"/>"><spring:message
        code="label.home" /></a>
    </p>
  </div>
  <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN')">
    <div>
      <p>
        <a class="button" href="/addNewDelivery" title="<spring:message code="label.addNewDelivery"/>"><spring:message
          code="label.addNewDelivery" /></a>
      </p>

      <p>
        <a class="button" href="/editExistingDelivery"
           title="<spring:message code="label.editExistingDelivery"/>"><spring:message
          code="label.editExistingDelivery" /></a>
      </p>

      <p>
        <a class="button" href="/printAuthorization" title="<spring:message code="label.printAuthorization"/>"><spring:message
          code="label.printAuthorization" /></a>
      </p>
    </div>
  </sec:authorize>

  <sec:authorize access="hasRole('ROLE_ADMIN')">
    <div>ADMIN ACCESS</div>
  </sec:authorize>
</div>

<%--<script>
	$("#accordion").accordion({
		collapsible : true
	});
</script>--%>

