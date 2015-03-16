<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html>
<body>
<h2>222Hello World!222</h2>
<table>
    <thead>
    <tr>
        <td>id</td>
        <td>name</td>
        <td>login</td>
        <td>password</td>
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
<c:if test="${pageContext.request.userPrincipal.name != null}">
    <h2>Welcome : ${pageContext.request.userPrincipal.name}
        | <a href="<c:url value="/logout" />" > Logout</a></h2>
</c:if>
</body>
</html>
