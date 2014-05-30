<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style>
.globalDiv {
	background: black;
}

.blockDiv {
	position: relative;
}

.innerDiv {
	height: 33.33%;
	width: 33.33%;
	float: left;
	position: relative;
	background: aqua;
}

.text,.dropDown,.globalDiv,.innerSet {
	font-family: Arial, sans-serif;
	font-size: 12pt;
}

.dropDown {
	width: 350px;
	height: 50%;
	width: 60%;
	background: #FFE680;
}

.legend {
	color: green;
	align: left;
}
</style>

<h2>first JSP</h2>
<h3>
    Enter Personal Details
    <sec:authentication property="name" />
</h3>
<form action="" method="post">
    <input type="text" /> <br /> <input type="submit" name="_eventId_next" value="next" /> <br />
    <!-- <input
        type="submit" name="_eventId_get" value="get" /> -->
</form>
<div class="globalDiv">
    <fieldset>
        <legend class="legend">
            <strong><spring:message code="label.addNewDelivery" /></strong>
        </legend>
        <form id="addNewDelivery" action="" method="post" style="text-align: left">
            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.deliveryType" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.departurDate" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.receiveDate" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
            </div>
            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.placeOfDeparture" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.courierCompany" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.contactPerson" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
            </div>
            <div class="blockDiv">
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.weight" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
                <div class="innerDiv">
                    <fieldset>
                        <legend class="legend">
                            <strong><spring:message code="label.size" /></strong>
                        </legend>
                        <form:select path="users" class="dropDown">
                            <form:options items="${users}" itemValue="id" itemLabel="userNickname" />
                            <form:option value="addNewOne">
                                <spring:message code="label.addNewOne" />
                            </form:option>
                        </form:select>
                    </fieldset>
                </div>
            </div>
        </form>
    </fieldset>
</div>
