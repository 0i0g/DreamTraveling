<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" scope="page" value="${initParam.web_name}"/>

<%@include file="/includes/header.jsp" %>

<!-- top navbar -->
<%@include file="/includes/navbar.jsp" %>
<!-- end top navbar -->
<!-- body -->
<!-- container -->
<div class="container">
    <!-- search -->
    <section class="search-tour mb-5">
        <form class="form-inline justify-content-end mb-5" action="LoadHome" method="POST">
            <div class="form-group mr-2">
                <input type="text" class="date-dropper-check-in-out form-control" data-dd-roundtrip="my-trip" placeholder="From" name="fromDate" data-dd-default-date="">
            </div>
            <span class="mr-2">-</span>
            <div class="form-group mr-2">
                <input type="text" class="date-dropper-check-in-out form-control" data-dd-roundtrip="my-trip" placeholder="To" name="toDate" data-dd-default-date="">
            </div>
            <div class="form-group mr-2">
                <input type="text" class="form-control" name="name" placeholder="Name">
            </div>
            <button type="submit" class="btn btn-primary">Search</button>
            <div class="form-group justify-content-end w-100 mt-5 pr-5">
                <label class="mr-5">Price:</label>
                <input type="hidden" class="range-slider" value="23" name="priceRange"/>
            </div>
        </form>
    </section>
    <!-- end search -->
    <!-- list card -->
    <section class="list-card mb-5">
        <div class="row row-cols-3">
            <c:forEach var="tour" items="${requestScope.list_tour}">
                <!-- card -->
                <div class="col mb-4">
                    <div class="card">
                        <img src="${tour.value.image}" alt="${tour.value.name}">
                        <div class="card-body">
                            <h5 class="card-title">${tour.value.name}</h5>
                            <div class="small mb-4"><span>${tour.value.fromDate}</span> - <span>${tour.value.toDate}</span></div>
                            <p>${tour.value.review}</p>
                            <button class="btn btn-success w-100 mt-3">Book This Tour</button>
                        </div>
                        <div class="card-footer">
                            <div class="row row-cols-2">
                                <div class="col">
                                    <small>Amount: <span>${tour.value.quantity}</span></small>
                                </div>
                                <div class="col text-right">
                                    <small class="numberCommas">${tour.value.price}<span>đ</span></small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end card -->
            </c:forEach>
        </div>
    </section>
    <c:if test="${not empty requestScope.total_page}">
        <!-- pagination -->
        <nav aria-label="Tours mb-5">
            <ul class="pagination justify-content-end">
                <c:forEach var="page" begin="1" end="${requestScope.total_page}" step="1">
                    <form action="LoadHome" method="POST">
                        <c:if test="${page eq requestScope.page}">
                            <div class="page-item active">
                                <button class="page-link" type="button">${page}</button>
                            </div>
                        </c:if>
                        <c:if test="${page ne requestScope.page}">
                            <div class="page-item">
                                <button class="page-link" type="submit">${page}</button>
                            </div>
                        </c:if>
                    </form>
                </c:forEach>
            </ul>
        </nav>
        <!-- end pagination -->
    </c:if>
    <!-- end list cart -->
</div>
<!-- end container -->
<!-- end body -->

<%@include file="/includes/footer.jsp" %>