<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html>
<body>
<h2>333Hello World!333</h2>
<table>
    <thead>
    <tr>
        <td><fmt:message key="user.id.title"/></td>
        <td><fmt:message key="user.name.title"/></td>
        <td><fmt:message key="user.login.title"/></td>
        <td><fmt:message key="user.password.title"/></td>
    </tr>
    </thead>

    <tbody>
    <%--@elvariable id="usersList" type="java.util.List<com.rebok3J.model.impl.User>"--%>
    <c:forEach items="${usersList}" var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.userName}</td>
            <td>${user.userNickname}</td>
            <td>${user.password}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>


