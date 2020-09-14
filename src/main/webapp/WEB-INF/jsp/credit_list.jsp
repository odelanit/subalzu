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
                <div class="row page-title">
                    <div class="col-md-12">
                        <nav aria-label="breadcrumb" class="float-right mt-1">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/">홈</a></li>
                                <li class="breadcrumb-item active" aria-current="page">외상잔액/예치금 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">외상잔액/예치금 관리</h4>
                    </div>
                </div>
                <c:if test="${error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>
                <div class="row">
                    <div class="col-md-12">
                        <div class="row mb-2">
                            <div class="col">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-right">
                                                <span class="text-muted text-uppercase font-weight-bold">총 이전 잔액</span>
                                                <h3 class="mb-0 text-primary"><fmt:formatNumber type="number" value="${sumPrevBalance}" />원</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-right">
                                                <span class="text-muted text-uppercase font-weight-bold">총 매출 금액</span>
                                                <h3 class="mb-0 text-success"><fmt:formatNumber type="number" value="${sumTotalSales}" /> 원</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-right">
                                                <span class="text-muted text-uppercase font-weight-bold">총 입금 금액</span>
                                                <h3 class="mb-0 text-secondary"><fmt:formatNumber type="number" value="${sumInputAmount}" />원</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-right">
                                                <span class="text-muted text-uppercase font-weight-bold">수정 금액</span>
                                                <h3 class="mb-0 text-warning"><fmt:formatNumber type="number" value="${sumUpdateAmount}" /> 원</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-right">
                                                <span class="text-muted text-uppercase font-weight-bold">총 잔액</span>
                                                <h3 class="mb-0 text-danger"><fmt:formatNumber type="number" value="${sumAmount}" />원</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="form" method="get">
                                    <table class="table table-bordered form-table mb-4">
                                        <colgroup>
                                            <col style="width: 100px;">
                                            <col style="width: 650px;">
                                            <col>
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="d-flex">
                                                    <form:select path="field" cssClass="custom-select custom-select-sm w-30 mr-2">
                                                        <form:option value="name" label="거래처명" />
                                                    </form:select>
                                                    <form:input path="keyword" cssClass="form-control form-control-sm" />
                                                    <form:hidden path="page" />
                                                </div>
                                            </td>
                                            <td rowspan="2">
                                                <button class="btn btn-outline-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td>
                                                <div class="d-flex" id="imSearch">
                                                    <form:select path="dealStatus" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="거래 상태" />
                                                        <form:option value="true" label="거래중" />
                                                        <form:option value="false" label="거래중지" />
                                                    </form:select>
                                                    <form:select path="paymentMethod" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="결제수단" />
                                                        <form:option value="credit" label="외상잔액" />
                                                        <form:option value="prepaid" label="예치금" />
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row align-items-center mb-3">
                                    <div class="col-6">
                                        전체 ${shopPage.totalElements}건
                                    </div>
                                    <div class="col-6 text-right">
                                        <a href="/credits/download_excel" class="btn btn-sm btn-outline-excel">
                                            <i class="fa fa-file-excel"></i> Excel 다운로드
                                        </a>
                                    </div>
                                </div>
                                <table class="table text-center table-hover table-middle" id="shops">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>결제수단</th>
                                        <th>거래처</th>
                                        <th>이전 잔액</th>
                                        <th>매출 금액</th>
                                        <th>입금 금액</th>
                                        <th>수정 금액</th>
                                        <th>잔액</th>
                                        <th>담당자</th>
                                        <th>최종 거래일</th>
                                    </tr>
                                    </thead>
                                    <c:forEach items="${shops}" var="shop">
                                        <tr data-id="${shop.id}">
                                            <td>${shop.id}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${shop.paymentMethod == 'credit'}">외상잔액</c:when>
                                                    <c:when test="${shop.paymentMethod == 'prepaid'}">예치금</c:when>
                                                </c:choose>
                                            </td>
                                            <td>${shop.name}</td>
                                            <td><fmt:formatNumber type="number" value="${shop.prevTotalBalance}" />원</td>
                                            <td><fmt:formatNumber type="number" value="${shop.totalSales}" />원</td>
                                            <td><fmt:formatNumber type="number" value="${shop.totalInput}" />원</td>
                                            <td><fmt:formatNumber type="number" value="${shop.totalUpdate}" />원</td>
                                            <td><fmt:formatNumber type="number" value="${shop.totalBalance}" />원</td>
                                            <td>${shop.shopOwner.fullName}</td>
                                            <td>${shop.dealtAt.format(localDateTimeFormat)}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <c:if test="${shopPage.totalPages > 1}">
                                        <tfoot>
                                        <tr>
                                            <td colspan="10">
                                                <nav>
                                                    <ul class="pagination justify-content-center">
                                                        <c:choose>
                                                            <c:when test="${shopPage.hasPrevious()}">
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
                                                        <c:forEach var="i" begin="1" end="${shopPage.totalPages}">
                                                            <li class="page-item <c:if test="${i == currentPage}">active</c:if>"><a href="javascript:;" class="page-link" data-page="${i}">${i}</a></li>
                                                        </c:forEach>
                                                        <c:choose>
                                                            <c:when test="${shopPage.hasNext()}">
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
        var token = $("meta[name='_csrf']").attr("content");
        $('#imSearch').on('change', function() {
            $('#form').submit();
        });

        $('#shops tbody tr').on('click', function() {
            window.location.href = '/credits/' + $(this).data('id');
        });

        $('.page-link').on('click', function() {
            var pageNo = $(this).data('page');
            if (pageNo) {
                $('#page').val(pageNo);
                $('#form').submit();
            }
        })
    });
</script>
</body>
</html>