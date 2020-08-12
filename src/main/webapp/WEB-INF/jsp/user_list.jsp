<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title>Pando Subalzu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <meta name="_csrf" content="${_csrf.token}"/>

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/metismenu/metisMenu.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/app.css" rel="stylesheet" type="text/css"/>
</head>
<body class="left-side-menu-dark">
<!-- Begin page -->
<div id="wrapper">

    <!-- Topbar Start -->
    <div class="navbar navbar-expand navbar-custom">
        <ul class="navbar-nav menu-left mb-0">
            <li class="">
                <button class="button-menu-mobile open-left disable-btn">
                    <i class="fa fa-bars menu-icon"></i>
                    <i data-feather="x" class="close-icon"></i>
                </button>
            </li>
        </ul>

        <ul class="navbar-nav mb-0 d-none d-xl-flex">
            <li class="nav-item">
                <a href="/orders/create" class="nav-link">신규주문 등록</a>
            </li>
            <li class="nav-item">
                <a href="/products/create" class="nav-link">상품 등록</a>
            </li>
            <li class="nav-item">
                <a href="/shops/create" class="nav-link">거래처 등록</a>
            </li>
        </ul>

        <ul class="navbar-nav ml-auto topnav-menu mb-0">
            <li class="nav-item d-none d-lg-block">
                <a href="javascript:;" class="nav-link"><i class="fa fa-user"></i>&nbsp;<c:out
                        value="${pageContext.request.remoteUser}"/></a>
            </li>
            <li class="nav-item d-none d-lg-block">
                <a href="javascript:;" class="nav-link"
                   onclick="document.getElementById('logout-form').submit();">로그아웃<i class="fa fa-sign-out"></i></a>
            </li>
            <form:form class="d-none" action="/logout" method="post" id="logout-form">
            </form:form>
        </ul>
    </div>
    <!-- end Topbar -->

    <!-- ========== Left Sidebar Start ========== -->
    <jsp:include page="sidebar.jsp" />
    <!-- Left Sidebar End -->

    <!-- ============================================================== -->
    <!-- Start Page Content here -->
    <!-- ============================================================== -->

    <div class="content-page">
        <div class="content">

            <!-- Start Content-->
            <div class="container-fluid">
                <div class="row page-title">
                    <div class="col-md-12">
                        <nav aria-label="breadcrumb" class="float-right mt-1">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/">홈</a></li>
                                <li class="breadcrumb-item active" aria-current="page">직원 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">직원관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="mb-5">
                                    <table class="table table-sm table-bordered form-table">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th class="text-center">키워드 검색</th>
                                            <td>
                                                <form:form class="form-inline" id="search-form" modelAttribute="form" method="get">
                                                    <form:select class="form-control w-25 form-control-sm ml-1 mr-2" path="field">
                                                        <form:option value="fullName" >담당자</form:option>
                                                        <form:option value="shopName">담당 거래처</form:option>
                                                    </form:select>
                                                    <form:input path="keyword" class="form-control w-50 form-control-sm" placeholder="검색어를 입력해주세요." />
                                                    <form:hidden path="page" id="page_number" />
                                                </form:form>
                                            </td>
                                            <td>
                                                <button class="btn btn-primary" form="search-form">검색</button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div>
                                    <div class="row align-items-center mb-3">
                                        <div class="col-lg-6">
                                            <span class="h6">전체 ${userPage.totalElements}건</span>
                                        </div>
                                        <div class="col-lg-6 text-right">
                                            <a class="btn btn-primary btn-sm" href="/users/create">
                                                <i class="fa fa-plus"></i> 직원 등록
                                            </a>
                                        </div>
                                    </div>
                                    <table class="table text-center table-hover" id="user-table">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>생성일</th>
                                            <th>담당자</th>
                                            <th>담당거래처</th>
                                            <th>아이디</th>
                                            <th>비고</th>
                                            <th style="width: 150px;">담당자 삭제</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="user" items="${users}">
                                            <tr onclick="window.location.href='/users/${user.username}'">
                                                <th>${user.id}</th>
                                                <td>${user.createdAt.format(localDateTimeFormat)}</td>
                                                <td>${user.fullName}</td>
                                                <td>
                                                    <c:if test="${user.deliverShops.size() > 0}">
                                                        <c:choose>
                                                            <c:when test="${user.deliverShops.size() == 1}">
                                                                <c:forEach var="shop" items="${user.deliverShops}" end="0">
                                                                    <c:out value="${shop.name}" />
                                                                </c:forEach>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach var="shop" items="${user.deliverShops}" end="0">
                                                                    <c:out value="${shop.name}" /> 외 ${user.deliverShops.size() - 1}건
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                </td>
                                                <td>${user.username}</td>
                                                <td>${user.bio}</td>
                                                <td>
                                                    <a href="/users/${user.username}/delete" class="btn btn-sm btn-outline-danger">
                                                        <i class="fa fa-trash"></i> 삭제
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                        <c:if test="${userPage.totalPages > 1}">
                                            <tfoot>
                                            <tr>
                                                <td colspan="7">
                                                    <nav>
                                                        <ul class="pagination justify-content-center">
                                                            <c:choose>
                                                                <c:when test="${userPage.hasPrevious()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link" data-page="${currentPage - 1}" href="javascript:;">
                                                                            &laquo;
                                                                        </a>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li class="page-item disabled">
                                                                        <a class="page-link" href="#">
                                                                            &laquo;
                                                                        </a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:forEach var="i" begin="1" end="${userPage.totalPages}">
                                                                <li class="page-item <c:if test="${i == currentPage}">active</c:if>"><a href="javascript:;" class="page-link" data-page="${i}">${i}</a></li>
                                                            </c:forEach>
                                                            <c:choose>
                                                                <c:when test="${userPage.hasNext()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link" data-page="${currentPage + 1}" href="javascript:;">
                                                                            &raquo;
                                                                        </a>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li class="page-item disabled">
                                                                        <a class="page-link" href="#">
                                                                            &raquo;
                                                                        </a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </ul>
                                                    </nav>
                                                </td>
                                            </tr>
                                            </tfoot>
                                        </c:if>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- container-fluid -->

        </div> <!-- content -->


        <!-- Footer Start -->
        <footer class="footer">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        2020 &copy; Pando. All Rights Reserved.
                    </div>
                </div>
            </div>
        </footer>
        <!-- end Footer -->

    </div>

    <!-- ============================================================== -->
    <!-- End Page content -->
    <!-- ============================================================== -->


</div>
<!-- END wrapper -->

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $(document).ready(function() {
        $(document).on('click', '.page-link', function () {
            var pageNo = $(this).data('page');
            if (pageNo) {
                $('#page_number').val(pageNo);
                $('#search-form').submit();
            }
        })
    })
</script>
</body>
</html>