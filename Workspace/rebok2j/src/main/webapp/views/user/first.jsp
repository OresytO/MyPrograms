<%@ page language="java" contentType="text/html; charset=UTF8" pageEncoding="UTF8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<style>
.globalSet {
	background: black;
}

.innerDiv {
	height: 33.33%;
	width: 33.33%;
	float: left;
	position: relative;
	background: aqua;
}

.text,.dropDown,.globalSet,.innerSet {
	font-family: Arial, sans-serif;
	font-size: 12pt;
}

.dropDown {
	width: 350px;
	background: #FFE680;
}

.legend {
	color: green;
	align: left;
}
</style>

<h2>first JSP</h2>
<h3>Enter Personal Details ${user.userNickname}</h3>
<form action="" method="post">
    <input type="text" /> <br /> <input type="submit" name="_eventId_next" value="next" /> <br />
    <!-- <input
        type="submit" name="_eventId_get" value="get" /> -->
</form>
<div class="globalSet">
    <fieldset>
        <legend class="legend">
            <strong><spring:message code="label.addNewDelivery" /></strong>
        </legend>
        <form id="addNewDelivery" action="" method="post" style="text-align: left">
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
        </form>
    </fieldset>
</div>
