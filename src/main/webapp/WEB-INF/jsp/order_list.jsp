<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/metismenu/metisMenu.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/app.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/libs/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="javascript:;" class="nav-link"><i class="fa fa-user"></i>&nbsp;<c:out value="${pageContext.request.remoteUser}"/> 정보보기</a>
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
    <div class="left-side-menu">
        <div class="side-menu-logo">
            <a href="/">
                <img src="${contextPath}/resources/images/logo_dark.svg" alt="logo" height="40" class="logo-icon" />
                <img src="${contextPath}/resources/images/logo_pando_dark.svg" alt="logo" height="40" class="logo-full" />
            </a>
        </div>
        <div class="sidebar-content">
            <!--- Sidemenu -->
            <div id="sidebar-menu" class="slimscroll-menu">
                <div class="media user-profile mt-2 mb-2">
                    <div class="media-body">
                        <a href="/company">
                            <h4 class="pro-user-name mt-0 mb-0">${currentCompany.vendorName}</h4>
                            <span class="pro-user-desc">기업정보보기</span>
                        </a>
                    </div>
                </div>
                <ul class="metismenu" id="menu-bar">
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 주문 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
                                <a href="/orders">주문 목록</a>
                            </li>
<%--                            <li>--%>
<%--                                <a href="/product-orders">상품별 주문 목록</a>--%>
<%--                            </li>--%>
<%--                            <li>--%>
<%--                                <a href="/returns">반품 내역</a>--%>
<%--                            </li>--%>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 매입 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/shipping">발주 관리</a>
                            </li>
                            <li>
                                <a href="/suppliers">매입처 관리</a>
                            </li>
                            <li>
                                <a href="/balance">매입처 잔액 관리</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 상품 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/products">상품 관리</a>
                            </li>
                            <li>
                                <a href="/categories">카테고리 설정</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 단가 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/price-groups">단가 그룹 관리</a>
                            </li>
                            <li>
                                <a href="/special-prices">특 단가 관리</a>
                            </li>
                            <li>
                                <a href="/prices">상품 단가 일괄 적용</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 재고 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/stock">입/출고 관리</a>
                            </li>
                            <li>
                                <a href="/stock-history">입/출고 내역</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 거래처 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/shops">거래처 목록</a>
                            </li>
                            <li>
                                <a href="/credits">외상잔액/예치금 관리</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 서비스 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/notices">공지사항</a>
                            </li>
                            <li>
                                <a href="/users">직원 관리</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- End Sidebar -->

            <div class="clearfix"></div>
        </div>
        <!-- Sidebar -left -->

    </div>
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
                                <li class="breadcrumb-item active" aria-current="page">주문 목록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">주문 목록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="form" method="get">
                                    <table class="table table-bordered form-table">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간 구분</th>
                                            <td>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton value="createdAt" path="dateType" id="customRadioInline1" class="custom-control-input" />
                                                    <label class="custom-control-label" for="customRadioInline1">주문 일시</label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton value="requestDate" path="dateType" id="customRadioInline2" class="custom-control-input" />
                                                    <label class="custom-control-label" for="customRadioInline2">배송 요정일</label>
                                                </div>
                                            </td>
                                            <td rowspan="3">
                                                <button class="btn btn-outline-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
                                                    <div class="btn-group btn-group-sm btn-group-toggle mr-4" data-toggle="buttons">
                                                        <label class="btn btn-outline-primary active">
                                                            <input type="radio" value="-1" /> 전체
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <input type="radio" value="1" /> 전일
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <input type="radio" value="0" /> 당일
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <input type="radio" value="30" /> 한달
                                                        </label>
                                                    </div>
                                                    <form:input path="dateFrom" class="form-control form-control-sm" placeholder="" />
                                                    <span class="px-2">-</span>
                                                    <form:input path="dateTo" class="form-control form-control-sm" placeholder="" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:select class="form-control form-control-sm mr-2" path="field">
                                                        <form:option value="shopName" label="거래처명" />
                                                        <form:option value="orderCode" label="주문번호" />
                                                    </form:select>
                                                    <form:input class="form-control form-control-sm" path="keyword" placeholder="검색어를 입력해주세요" />
                                                    <form:hidden path="page" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="row" id="instantSearch">
                                                    <div class="col">
                                                        <form:select path="deliveryType" class="form-control form-control-sm">
                                                            <form:option value="" label="배송유형" />
                                                            <form:option value="direct" label="직배송" />
                                                            <form:option value="parcel" label="택배배송" />
                                                        </form:select>
                                                    </div>
                                                    <div class="col">
                                                        <form:select class="form-control form-control-sm" path="orderStatus">
                                                            <form:option value="" label="주문상태" />
                                                            <form:option value="completed" label="주문완료" />
                                                            <form:option value="modified" label="주문변경" />
                                                            <form:option value="canceled" label="주문취소" />
                                                            <form:option value="return_received" label="반품접수" />
                                                            <form:option value="return_completed" label="반품완료" />
                                                        </form:select>
                                                    </div>
                                                    <div class="col">
                                                        <form:select class="form-control form-control-sm" path="releaseStatus">
                                                            <form:option value="" label="출고상태" />
                                                            <form:option value="progress" label="출고전" />
                                                            <form:option value="completed" label="출고완료" />
                                                            <form:option value="rejected" label="출고거절" />
                                                        </form:select>
                                                    </div>
                                                    <div class="col">
                                                        <form:select class="form-control form-control-sm" path="deliverer">
                                                            <form:option value="" label="배송 담당자" />
                                                            <form:options items="${deliverers}" itemValue="id" itemLabel="fullName" />
                                                        </form:select>
                                                    </div>
                                                    <div class="col">
                                                        <form:select class="form-control form-control-sm" path="salesman">
                                                            <form:option value="" label="영업 담당자" />
                                                            <form:options items="${salesMans}" itemValue="id" itemLabel="fullName" />
                                                        </form:select>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <hr>
                                <div class="row align-items-center mb-3">
                                    <div class="col-md-6">
                                        <a href="javascript:;" class="btn btn-outline-primary btn-sm">
                                            <i class="fa fa-scroll"></i> 거래명세표
                                        </a>
                                        <a href="javascript:;" class="btn btn-outline-secondary btn-sm">
                                            <i class="fa fa-print"></i> 출고지시서
                                        </a>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <a href="/orders/create" class="btn btn-outline-primary btn-sm">
                                            <i class="fa fa-plus"></i> 신규주문 등록
                                        </a>
                                    </div>
                                </div>
                                <hr>
                                <div class="row align-items-center mb-4">
                                    <div class="col-6">
                                        <span>전체 ${orderPage.totalElements}건</span>
<%--                                        <button class="btn btn-sm btn-outline-primary" >출고 완료</button>--%>
                                    </div>
                                    <div class="col-6 text-right">
                                        <a target="_blank" class="btn btn-sm btn-excel" href="/orders/download/orders.xlsx">
                                            <i class="fa fa-file-excel"></i> 주문내역
                                        </a>
                                    </div>
                                </div>
                                <div>
                                    <table class="table table-hover text-center" id="orders">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>주문일시</th>
                                            <th>배송요청일</th>
                                            <th>주문번호</th>
                                            <th>거래처</th>
                                            <th>배송유형</th>
                                            <th>총 주문수량</th>
                                            <th>결제수단</th>
                                            <th>주문금액</th>
                                            <th>주문상태</th>
                                            <th>출고상태</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${orders}" var="order">
                                            <tr onclick="window.location.href='/orders/${order.id}'">
                                                <td>${order.id}</td>
                                                <td>${order.createdAt.format(localDateTimeFormat)}</td>
                                                <td>${order.requestDate}</td>
                                                <td>${order.orderCode}</td>
                                                <td>${order.shop.name}</td>
                                                <td>${order.deliveryType == "direct" ? "직배송" : "택배 배송" }</td>
                                                <td>${order.orderProducts.size()}</td>
                                                <td>${order.shop.paymentMethod == "credit" ? "외상거래" : "예치금"}</td>
                                                <td>${order.totalAmount}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.orderStatus == 'modified'}">
                                                            주문변경
                                                        </c:when>
                                                        <c:when test="${order.orderStatus == 'completed'}">
                                                            주문완료
                                                        </c:when>
                                                        <c:otherwise>
                                                            주문취소
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.releaseStatus == 'progress'}">
                                                            출고전
                                                        </c:when>
                                                        <c:when test="${order.releaseStatus == 'completed'}">
                                                            출고완료
                                                        </c:when>
                                                        <c:otherwise>
                                                            출고거절
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
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
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/libs/flatpickr/flatpickr.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $('#dateFrom').datepicker({
        dateFormat: 'yy-mm-dd'
    });
    $('#dateTo').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $('#instantSearch select').on('change', function () {
        $('#form').submit();
    })

</script>
</body>
</html>