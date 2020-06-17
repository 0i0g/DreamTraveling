<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" scope="page" value="Error 401"/>
<%@include file="/includes/header.jsp" %>

<!-- top navbar -->
<%@include file="/includes/navbar.jsp" %>
<!-- end top navbar -->
<!-- body -->
<!-- container -->
<div class="container">
    <h3 class="text-danger">${requestScope.error}</h3>
</div>
<!-- end container -->
<!-- end body -->

<%@include file="/includes/footer.jsp" %>