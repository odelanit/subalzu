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
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/metismenu/metisMenu.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="/profile" class="nav-link"><i data-feather="user"></i>&nbsp;<c:out value="${pageContext.request.remoteUser}"/> 정보보기</a>
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
<%--                            <li>--%>
<%--                                <a href="/product-orders">상품별 주문 목록</a>--%>
<%--                            </li>--%>
<%--                            <li>--%>
<%--                                <a href="/returns">반품 내역</a>--%>
<%--                            </li>--%>
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
                                <a href="/store">입/출고 관리</a>
                            </li>
                            <li>
                                <a href="/store-history">입/출고 내역</a>
                            </li>
                            <li>
                                <a href="/store-status">재고 현황</a>
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
                                <li class="breadcrumb-item">매입처 잔액 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">매입처 잔액 상세내역</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">매입처 잔액 상세 내역</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form>
                                    <table class="table form-table table-bordered">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                            <label class="btn btn-outline-primary active">
                                                                <input type="radio" name="options" id="option1" checked> 전체
                                                            </label>
                                                            <label class="btn btn-outline-primary">
                                                                <input type="radio" name="options" id="option2"> 전일
                                                            </label>
                                                            <label class="btn btn-outline-primary">
                                                                <input type="radio" name="options" id="option3"> 당일
                                                            </label>
                                                            <label class="btn btn-outline-primary">
                                                                <input type="radio" name="options" id="option4"> 한달
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <input type="text" id="range-datepicker" class="form-control" placeholder="2019-01-01 to 2019-12-31">
                                                    </div>
                                                </div>
                                            </td>
                                            <td style="width: 40%;">
                                                <button class="btn btn-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="col-form-label col-lg-2">즉시 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline">
                                                    <select class="form-control w-20">
                                                        <option>구분</option>
                                                    </select>
                                                    <select class="form-control w-20 ml-2">
                                                        <option>처리방식</option>
                                                    </select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>

                                </form>
                                <div class="my-4 text-center">
                                    <h4>
                                        <strong>${supplier.name}</strong>
                                        <span class="text-primary">현재 잔액</span>
                                        <span>0원</span>
                                    </h4>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-lg-6">
                                        <button type="button" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#outcome-modal">출금 처리</button>
                                        <button type="button" class="btn btn-sm btn-secondary" data-toggle="modal" data-target="#direct-modal">직접 수정</button>
                                    </div>
                                    <div class="col-lg-6 text-lg-right">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fa fa-file-excel"></i> Excel 다운로드
                                        </button>
                                    </div>
                                </div>
                                <table class="table">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>일시</th>
                                        <th>구분</th>
                                        <th>거래 방식</th>
                                        <th>거래 금액</th>
                                        <th>총 잔액</th>
                                        <th>비고</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${balances}" var="balance">
                                        <tr>
                                            <td>${balance.id}</td>
                                            <td>${balance.createdAt.format(localDateTimeFormat)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${balance.type == 'withdraw'}">
                                                        출금
                                                    </c:when>
                                                    <c:when test="${balance.type == 'correction'}">
                                                        수정
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${balance.method == 'withdraw'}">
                                                        직접 출금
                                                    </c:when>
                                                    <c:when test="${balance.method == 'subtraction'}">
                                                        금액 차감
                                                    </c:when>
                                                    <c:when test="${balance.method == 'addition'}">
                                                        금액 추가
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${balance.funds}원</td>
                                            <td></td>
                                            <td>${balance.memo}</td>
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
<div class="modal fade" id="outcome-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title">출금 처리</h5>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body p-4">
                <form:form modelAttribute="form" id="form1" action="/balance/add">
                    <form:hidden path="supplier" />
                    <form:hidden path="type" value="withdraw" />
                    <form:hidden path="method" value="withdraw" />
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">
                            <label>${supplier.name}</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                            <label>0</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">출금 금액</label>
                        <div class="col-8 text-right">
                            <form:input class="form-control form-control-sm" type="number" path="funds" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">출금 후 잔액</label>
                        <div class="col-8 text-right">
                            <label>0</label>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">비고</label>
                        <div class="col-8 text-right">
                            <form:textarea class="form-control form-control-sm" path="memo" />
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                <button class="btn btn-primary" form="form1">적용</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="direct-modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">직접 수정</h5>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body p-4">
                <form:form modelAttribute="form" id="form2" action="/balance/add">
                    <form:hidden path="supplier" />
                    <form:hidden path="type" value="correction" />
                    <div class="form-group row">
                        <label class="col-form-label col-4">구분</label>
                        <div class="col-8 text-right">
                            <div class="custom-control custom-radio custom-control-inline">
                                <form:radiobutton id="subtraction" checked="true"
                                                  value="subtraction" path="method"
                                                  class="custom-control-input"/>
                                <label class="custom-control-label"
                                       for="subtraction">금액 차감</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <form:radiobutton id="addition"
                                                  value="addition" path="method"
                                                  class="custom-control-input"/>
                                <label class="custom-control-label"
                                       for="addition">금액 추가</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">
                            <label>${supplier.name}</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                            <label>0</label>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 금액</label>
                        <div class="col-8 text-right">
                            <form:input class="form-control form-control-sm" type="number" path="funds" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 후 잔액</label>
                        <div class="col-8 text-right">
                            <label>0</label>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">비고</label>
                        <div class="col-8 text-right">
                            <form:textarea class="form-control form-control-sm" path="memo" />
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                <button class="btn btn-primary" form="form2">적용</button>
            </div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $('#form1, #form2').submit(function (e) {
        e.preventDefault();
        var funds = $(this).find('input[name="funds"]').val();
        if (funds > 0) {
            $.ajax({
                type: 'POST',
                url: $(this).attr('action'),
                data: $(this).serialize(),
                success: function(data) {
                    $('#outcome-modal').modal('hide');
                    window.location.reload();
                }
            })
        }
    })
</script>
</body>
</html>