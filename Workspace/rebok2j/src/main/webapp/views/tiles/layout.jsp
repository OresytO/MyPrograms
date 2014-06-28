<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page session="false" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/rebok2j.css" />" />
  <script type="text/javascript" src="<c:url value="/resources/js/rebok2j.js" />"></script>

  <title><tiles:insertAttribute name="title" ignore="true" /></title>

</head>

<body>

<div class="wrapper">

  <div class="header">
    <tiles:insertAttribute name="header" />
  </div>
  <!-- .header-->

  <div class="middle">

    <div class="container">
      <div class="body">
        <tiles:insertAttribute name="body" />
      </div>
      <!-- .content -->
    </div>
    <!-- .container-->

    <div class="menu">
      <tiles:insertAttribute name="menu" />
    </div>
    <!-- .left-sidebar -->

  </div>
  <!-- .middle-->

</div>
<!-- .wrapper -->

<div class="footer">
  <tiles:insertAttribute name="footer" />
</div>
<!-- .footer -->

</body>
</html>
