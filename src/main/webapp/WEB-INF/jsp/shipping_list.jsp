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
    <link href="${contextPath}/resources/toastr-2.1.4/toastr.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>
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
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 주문 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/orders">주문 목록</a>
                            </li>
                            <li>
                                <a href="/order_products">상품별 주문 목록</a>
                            </li>
                            <li>
                                <a href="/return_orders">반품 내역</a>
                            </li>
                        </ul>
                    </li>
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 매입 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item">매입관리</li>
                                <li class="breadcrumb-item active" aria-current="page">발주 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">발주 관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="form" method="get">
                                    <table class="table form-table table-bordered">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:input path="dateFrom" class="form-control form-control-sm mr-2" />
                                                    <form:input path="dateTo" class="form-control form-control-sm" />
                                                </div>
                                            </td>
                                            <td rowspan="2" style="vertical-align: middle">
                                                <button class="btn btn-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:select path="field" class="form-control form-control-sm w-20 mr-2">
                                                        <form:option value="supplier_name" label="매입처" />
                                                    </form:select>
                                                    <form:input path="keyword" class="form-control form-control-sm" placeholder="검색어를 입력해주세요" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="d-flex">
                                                    <div class="w-20 mr-2">
                                                        <select class="form-control form-control-sm">
                                                            <option value="">발주 상태</option>
                                                        </select>
                                                    </div>
                                                    <div class="w-20 mr-2">
                                                        <select class="form-control form-control-sm">
                                                            <option value="">입고 상태</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row mb-3">
                                    <div class="col-md-6">
<%--                                        <a href="/shipping/print" class="btn btn-sm btn-outline-secondary">--%>
<%--                                            <i class="fa fa-print"></i> 발주서 출력--%>
<%--                                        </a>--%>
                                    </div>
                                    <div class="col-md-6 text-md-right mt-md-0 mt-2">
                                        <a href="/shipping/create" class="btn btn-sm btn-outline-primary">
                                            <i class="fa fa-plus"></i> 신규 발주 등록
                                        </a>
                                    </div>
                                </div>
                                <table class="table table-middle text-center table-hover" id="orders">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="selectAll">
                                        </th>
                                        <th>#</th>
                                        <th>발주번호</th>
                                        <th>매입처</th>
                                        <th>발주일시</th>
                                        <th>총 발주수량</th>
                                        <th>발주금액</th>
                                        <th>발주상태</th>
                                        <th>입고상태</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr data-id="${order.id}">
                                            <td>
                                                <input type="checkbox" value="${order.id}">
                                            </td>
                                            <td>${order.id}</td>
                                            <td>${order.orderCode}</td>
                                            <td>${order.supplier.name}</td>
                                            <td>${order.createdAt.format(localDateTimeFormat)}</td>
                                            <td>${order.supplyOrderProducts.size()}</td>
                                            <td>${order.totalAmount}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.shippingStatus == 'standby'}">
                                                        <button type="button" class="btn btn-sm btn-outline-primary complete">발주완료</button>
                                                    </c:when>
                                                    <c:when test="${order.shippingStatus == 'completed'}">
                                                        발주 완료
                                                    </c:when>
                                                    <c:when test="${order.shippingStatus == 'canceled'}">
                                                        발주 취소
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.inputStatus == 'standby'}">
                                                        입고 대기
                                                    </c:when>
                                                    <c:when test="${order.inputStatus == 'canceled'}">
                                                        입고 완료
                                                    </c:when>
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
</div>
<!-- END wrapper -->
<div id="overlay">
    <div class="cv-spinner">
        <div class="lds-default">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    var token = $("meta[name='_csrf']").attr("content");

    $('#dateFrom, #dateTo').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $('.complete').on('click', function() {
        var orderId = $(this).closest('tr').data('id');
        $.ajax({
            type: 'POST',
            url: '/shipping/order_complete',
            contentType: 'application/json',
            accept: 'text/plain',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: JSON.stringify({
                id: orderId.toString()
            }),
            beforeSend: function() {
                $("#overlay").fadeIn(300);
            },
            success: function(data) {
                toastr.success(data.message);
                window.location.reload();
            }
        }).done(function () {
            setTimeout(function(){
                $("#overlay").fadeOut(300);
            }, 500);
        });
    });

    $('#selectAll').on('change', function (e) {
        $('#orders tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
    });

    $('#orders tbody tr td:not(:first-child)').on('click', function () {
        window.location.href = '/shipping/' + $(this).closest('tr').data('id');
    });

    $('#orders tbody tr td:first-child').on('click', function (e) {
        var checkboxElement = $(this).find('input[type="checkbox"]');
        checkboxElement.prop('checked', !checkboxElement.prop('checked'));
    });

    $('#orders tbody tr td input[type="checkbox"]').on('change', function (e) {
        var checkboxElement = $(this);
        checkboxElement.prop('checked', !checkboxElement.prop('checked'));
    });
</script>
</body>
</html>