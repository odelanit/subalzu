<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title>Pando</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

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
                <a href="javascript:;" class="nav-link"><i class="fa fa-user"></i>&nbsp;<c:out value="${pageContext.request.remoteUser}"/></a>
            </li>
            <li class="nav-item d-none d-lg-block">
                <a href="javascript:;" class="nav-link" onclick="document.getElementById('logout-form').submit();">로그아웃<i class="fa fa-sign-out"></i></a>
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
                <div class="row mt-4">
                    <div class="col-lg-6">
                        <h5 class="header-title">판매 진행 현황(한달기준)</h5>
                        <div class="row">
                            <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-center">
                                                <a href="/orders?releaseStatus=progress" class="text-info text-decoration-none">
                                                    <span class="text-muted text-uppercase font-weight-bold">출고전</span>
                                                    <h2 class="mb-0">${countOrderReleaseProgress}</h2>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-center">
                                                <a href="/orders?releaseStatus=completed" class="text-success text-decoration-none">
                                                    <span class="text-muted text-uppercase font-weight-bold">출고완료</span>
                                                    <h2 class="mb-0">${countOrderReleaseCompleted}</h2>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-center">
                                                <a href="/orders?releaseStatus=rejected" class="text-danger text-decoration-none">
                                                    <span class="text-muted text-uppercase font-weight-bold">출고거절</span>
                                                    <h2 class="mb-0">${countOrderReleaseCanceled}</h2>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h5 class="header-title">체크항목</h5>
                        <div class="row">
                            <div class="col-xl-4">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-center">
                                                <a href="/stock_rest?qtyStatus=0" class="text-danger text-decoration-none">
                                                    <span class="text-uppercase font-weight-bold">재고 부족</span>
                                                    <h2 class="mb-0">${countQtyInsufficient}</h2>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <h5 class="header-title">주문현황</h5>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="text-center mb-0">당일</h5>
                            </div>
                            <div class="card-body pt-2">

                                <!-- stat 1 -->
                                <div class="media px-3 py-3 border-bottom">
                                    <div class="media-body">
                                        <h4 class="">주문 ${orders1.size()}건</h4>
                                    </div>
                                    <div>
                                        <span class="h4"><fmt:formatNumber value="${total1}" type="number" />원</span>
                                    </div>
                                </div>

                                <!-- stat 2 -->
                                <div class="media px-3 py-3">
                                    <div class="media-body">
                                        <h4>취소 ${countReturnOrder1}건</h4>
                                    </div>
                                    <div>
                                        <span class="h4"><fmt:formatNumber type="number" value="${sumReturnAmount1}"/>원</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="text-center mb-0">한달</h5>
                            </div>
                            <div class="card-body pt-2">

                                <!-- stat 1 -->
                                <div class="media px-3 py-3 border-bottom">
                                    <div class="media-body">
                                        <h4>주문 ${orders30.size()}건</h4>
                                    </div>
                                    <div>
                                        <span class="h4"><fmt:formatNumber value="${total30}" type="number" /> 원</span>
                                    </div>
                                </div>

                                <!-- stat 2 -->
                                <div class="media px-3 py-3">
                                    <div class="media-body">
                                        <h4>취소 ${countReturnOrder30}건</h4>
                                    </div>
                                    <div>
                                        <span class="h4"><fmt:formatNumber type="number" value="${sumReturnAmount30}" />원</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h5 class="header-title">공지사항 및 문의사항</h5>
                        <div class="card">
                            <div class="card-body p-0">
                                <ul class="nav nav-tabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#notification-tab">공지사항</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="notification-tab">
                                        <div>
                                            <table class="table">
                                                <colgroup>
                                                    <col width="*">
                                                    <col width="30%">
                                                </colgroup>
                                                <tbody>
                                                <c:forEach items="${notices}" var="notice">
                                                    <tr onclick="window.location.href='/notices/${notice.id}'">
                                                        <td>${notice.title}</td>
                                                        <td>${notice.createdAt.format(localDateTimeFormat)}</td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
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

</body>
</html>