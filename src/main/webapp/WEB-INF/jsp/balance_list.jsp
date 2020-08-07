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

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="/orders/create" class="nav-link active">신규주문 등록</a>
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
                            <li>
                                <a href="/shipping">발주 관리</a>
                            </li>
                            <li>
                                <a href="/suppliers">매입처 관리</a>
                            </li>
                            <li class="mm-active">
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
                                <li class="breadcrumb-item active" aria-current="page">매입처 잔액 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">매입처 잔액 관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row mb-2">
                            <div class="col">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body text-right">
                                                <span class="text-muted text-uppercase font-weight-bold">총 이전 잔액</span>
                                                <h3 class="mb-0 text-primary">${sumPrevBalance}원</h3>
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
                                                <span class="text-muted text-uppercase font-weight-bold">총 매입 금액</span>
                                                <h3 class="mb-0 text-success">${sumOrderAmount} 원</h3>
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
                                                <span class="text-muted text-uppercase font-weight-bold">총 출금 금액</span>
                                                <h3 class="mb-0 text-secondary">${sumOutputAmount}원</h3>
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
                                                <h3 class="mb-0 text-warning">${sumUpdateAmount} 원</h3>
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
                                                <h3 class="mb-0 text-danger">${sumAmount}원</h3>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <form:form method="get" modelAttribute="form">
                                    <table class="table table-bordered form-table">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
                                                    <div class="btn-group btn-group-sm btn-group-toggle mr-2" data-toggle="buttons">
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="3" label="전체" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="2" label="전월" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="1" label="금월" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="0" label="당일" />
                                                        </label>
                                                    </div>
                                                    <form:input path="dateFrom" class="form-control form-control-sm" placeholder="" />
                                                    <span class="px-2">-</span>
                                                    <form:input path="dateTo" class="form-control form-control-sm" placeholder="" />
                                                </div>
                                            </td>
                                            <td rowspan="2">
                                                <button class="btn btn-outline-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:select cssClass="form-control form-control-sm w-20 mr-2" path="type">
                                                        <form:option value="name" label="거래처명" />
                                                    </form:select>
                                                    <form:input cssClass="form-control form-control-sm" path="keyword" placeholder="검색어를 입력해주세요" />
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row align-items-center mb-3">
                                    <div class="col-6">
                                        <span>전체 ${supplierPage.totalElements}건</span>
                                    </div>
                                    <div class="col-6 text-right">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fa fa-file-excel"></i> Excel 다운로드
                                        </button>
                                    </div>
                                </div>
                                <table class="table table-hover text-center table-sm">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>매입처</th>
                                        <th>이전 잔액</th>
                                        <th>매입 금액</th>
                                        <th>출금 금액</th>
                                        <th>수정 금액</th>
                                        <th>잔액</th>
                                        <th>최종거래일</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${suppliers}" var="supplier">
                                        <tr onclick="window.location.href='/balance/${supplier.id}'">
                                            <td>${supplier.id}</td>
                                            <td>${supplier.name}</td>
                                            <td>${supplier.totalPrevBalance}원</td>
                                            <td>${supplier.totalInputFunds}원</td>
                                            <td>${supplier.totalOutputFunds}원</td>
                                            <td>${supplier.totalUpdateFunds}원</td>
                                            <td>${supplier.totalFunds}원</td>
                                            <td>${supplier.dealtAt.format(localDateTimeFormat)}</td>
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
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $('#dateFrom').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $('#dateTo').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    formatDate = function (date) {
        let month = '' + (date.getMonth() + 1),
            day = '' + date.getDate(),
            year = date.getFullYear();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [year, month, day].join('-');
    };

    $('input[name="period"]').on('change', function() {
        var diff = +$(this).val();
        const date = new Date();
        if (diff === 0) {
            var strDateFrom = formatDate(date);
            $('#dateFrom').val(strDateFrom);
            $('#dateTo').val(strDateFrom);
        } else if (diff === 1) {
            var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
            var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
            $('#dateFrom').val(formatDate(firstDay));
            $('#dateTo').val(formatDate(lastDay));
        } else if (diff === 2) {
            var firstDay = new Date(date.getFullYear(), date.getMonth() - 1, 1);
            var lastDay = new Date(date.getFullYear(), date.getMonth(), 0);
            $('#dateFrom').val(formatDate(firstDay));
            $('#dateTo').val(formatDate(lastDay));
        } else {
            $('#dateFrom').val('2020-01-01');
            $('#dateTo').val(formatDate(date));
        }
    });
</script>
</body>
</html>