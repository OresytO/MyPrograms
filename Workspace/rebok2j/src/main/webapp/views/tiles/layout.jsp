<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page session="false"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title><tiles:insertAttribute name="title" ignore="true" /></title>
<style>
.wrapper {
	min-width: 1000px;
	max-width: 5000px;
	margin: 0 auto;
	min-height: 100%;
	height: auto !important;
	height: 100%;
}

.header {
	height: 150px;
	background: #FFE680;
}

.middle {
	width: 100%;
	padding: 0 0 100px;
	position: relative;
}

.middle:after {
	display: table;
	clear: both;
	content: '';
}

.container {
	width: 100%;
	float: left;
	overflow: hidden;
}

.body {
	padding: 0 0 0 270px;
}

.menu {
	float: left;
	width: 250px;
	margin-left: -100%;
	position: relative;
	background: #B5E3FF;
}

.footer {
	margin: -100px auto 0;
	min-width: 1000px;
	max-width: 5000px;
	height: 100px;
	background: #BFF08E;
	position: relative;
}
</style>
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
