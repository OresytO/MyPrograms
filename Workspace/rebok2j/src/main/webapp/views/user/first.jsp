<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>first JSP</h2>
<h3>Enter Personal Details ${user.userNickname}</h3>
<form action="" method="post">
    <input type="text" /> <br /> <input type="submit" name="_eventId_next" value="next" /> <br /> <input
        type="submit" name="_eventId_get" value="get" />
</form>
<select name="year">
    <c:forEach var="user" items="${users}">
        <option value="${user.id}">${user.userNickname}</option>
    </c:forEach>
</select>
<fieldset>
    <legend style="color: green" align="left">
        <strong><spring:message code="label.addNewDelivery" /></strong>
    </legend>
    <form id="addNewDelivery" action="" method="post" style="text-align: left">
        <label for="deliveryType"> <spring:message code="label.deliveryType" />
        </label><br> <select id="deliveryType">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <label for="departurDate"> <spring:message code="label.departurDate" />
        </label><br> <select id="departurDate">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <label for="receiveDate"> <spring:message code="label.receiveDate" />
        </label> <br> <select id="receiveDate">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <label for="placeOfDeparture"> <spring:message code="label.placeOfDeparture" />
        </label><br> <select id="placeOfDeparture">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <br> <label for="courierCompany"> <spring:message code="label.courierCompany" />
        </label><br> <select id="courierCompany">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <br> <label for="contactPerson"> <spring:message code="label.contactPerson" />
        </label><br> <select id="contactPerson">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <br> <label for="weight"> <spring:message code="label.weight" />
        </label><br> <select id="weight">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <br> <label for="size"> <spring:message code="label.size" />
        </label><br> <select id="size">
            <c:forEach var="user" items="${users}">
                <option value="${user.id}">${user.userNickname}</option>
            </c:forEach>
        </select> <br> <input type="submit" value="<spring:message code="label.enter"/>" />
    </form>
</fieldset>
