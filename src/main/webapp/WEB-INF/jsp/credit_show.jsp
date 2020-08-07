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
                            <li class="mm-active">
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
                                <li class="breadcrumb-item"><a href="/credits/">외상잔액 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">외상잔액 상세내역</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">외상잔액/예치금 상세내역</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="row mb-3">
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3">
                                            <div class="media-body">
                                            <span class="text-muted text-uppercase font-weight-bold">현재 잔액</span>
                                                <h2 class="mb-0">${shop.name}</h2>
                                            </div>
                                            <div class="align-self-center">
                                                <span class="h3 text-danger">${totalBalance} 원</span>
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
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
<%--                                                    <div class="btn-group btn-group-sm btn-group-toggle mr-4" data-toggle="buttons">--%>
<%--                                                        <label class="btn btn-outline-primary active">--%>
<%--                                                            <input type="radio" value="-1" /> 전체--%>
<%--                                                        </label>--%>
<%--                                                        <label class="btn btn-outline-primary">--%>
<%--                                                            <input type="radio" value="1" /> 전월--%>
<%--                                                        </label>--%>
<%--                                                        <label class="btn btn-outline-primary">--%>
<%--                                                            <input type="radio" value="0" /> 금월--%>
<%--                                                        </label>--%>
<%--                                                        <label class="btn btn-outline-primary">--%>
<%--                                                            <input type="radio" value="30" /> 당일--%>
<%--                                                        </label>--%>
<%--                                                    </div>--%>
                                                    <div class="input-group input-group-sm w-25">
                                                        <form:input path="dateFrom" class="form-control" placeholder="" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <span class="px-2">-</span>
                                                    <div class="input-group input-group-sm w-25">
                                                        <form:input path="dateTo" class="form-control w-25 form-control-sm" placeholder="" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
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
                                                    <form:select path="transactionType" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="구분" />
                                                        <form:option value="input" label="입금" />
                                                        <form:option value="sale" label="매출" />
                                                        <form:option value="update" label="수정" />
                                                    </form:select>
                                                    <form:select path="processingMethod" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="처리방식" />
                                                        <form:option value="credit_minus" label="외상거래" />
                                                        <form:option value="prepaid_minus" label="예치금" />
                                                        <form:option value="manual_minus" label="직접입금" />
                                                        <form:option value="fund_minus" label="금액차감" />
                                                        <form:option value="fund_plus" label="금액추가" />
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row align-items-center mb-3">
                                    <div class="col-6">
                                        <span>전체 ${transactionPage.totalElements}건</span>
                                        <button class="btn btn-sm btn-primary ml-3" data-toggle="modal" data-target="#inputModal">입금 처리</button>
                                        <button class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#manualModal">직접 수정</button>
                                    </div>
                                    <div class="col-6 text-right">
                                        <a href="/credits/${shop.id}/download_excel" class="btn btn-sm btn-outline-excel">
                                            <i class="fa fa-file-excel"></i> Excel 다운로드
                                        </a>
                                    </div>
                                </div>
                                <table class="table text-center table-hover table-middle" id="transactions">
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
                                    <c:forEach items="${transactions}" var="transaction">
                                        <tr data-id="${transaction.id}">
                                            <td>${transaction.id}</td>
                                            <td>
                                                ${transaction.createdAt.format(localDateTimeFormat)}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${transaction.transactionType == 'order'}">입금</c:when>
                                                    <c:when test="${transaction.transactionType == 'update'}">수정</c:when>
                                                    <c:when test="${transaction.transactionType == 'output'}">매출</c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${transaction.processingMethod == 'manual_minus'}">
                                                        직접 입금
                                                    </c:when>
                                                    <c:when test="${transaction.processingMethod == 'fund_minus'}">
                                                        금액 차감
                                                    </c:when>
                                                    <c:when test="${transaction.processingMethod == 'fund_plus'}">
                                                        금액 추가
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${transaction.funds}원</td>
                                            <td>${transaction.totalFunds}원</td>
                                            <td>${transaction.description}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                                <div class="form-group text-center">
                                    <a href="/credits/" class="btn btn-secondary">이전 목록으로</a>
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
<div class="modal fade" id="inputModal">
    <div class="modal-dialog-centered modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">
                    입금 처리
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form:form method="post" modelAttribute="transactionForm1" action="/credits/store">
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">
                            ${shop.name}
                            <form:hidden path="shop" />
                            <form:hidden path="transactionType" />
                                <form:hidden path="processingMethod" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                                ${shop.totalBalance} 원
                            <form:hidden path="prevTotal" value="${shop.totalBalance}" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">입금 금액</label>
                        <div class="col-8 text-right">
                            <form:input type="number" class="form-control text-right form-control-sm" path="funds" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">입금 후 잔액</label>
                        <div class="col-8 text-right text-danger">
                            <span class="totalAmount">${shop.totalBalance}</span> 원
                            <form:hidden path="totalFunds" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">비고</label>
                        <div class="col-8">
                            <form:textarea path="description" class="form-control-sm form-control" rows="3" />
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-primary" form="transactionForm1">적용</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="manualModal">
    <div class="modal-dialog-centered modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-secondary">
                <div class="modal-title text-light">
                    직접 수정
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form:form method="post" modelAttribute="transactionForm2" action="/credits/store">
                    <div class="form-group row">
                        <label class="col-form-label col-4">구분</label>
                        <div class="col-8 text-right">
                            <div class="custom-control custom-control-inline custom-radio">
                                <form:radiobutton class="custom-control-input" path="processingMethod" value="fund_minus" id="transactionType1" />
                                <label class="custom-control-label" for="transactionType1">금액 차감</label>
                            </div>
                            <div class="custom-control custom-control-inline custom-radio">
                                <form:radiobutton class="custom-control-input" path="processingMethod" value="fund_plus" id="transactionType2" />
                                <label class="custom-control-label" for="transactionType2">금액 추가</label>
                            </div>
                        </div>
                        <form:hidden path="prevTotal" value="${shop.totalBalance}" />
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">
                                ${shop.name}
                                    <form:hidden path="shop" />
                                    <form:hidden path="transactionType" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                                ${shop.totalBalance} 원
                            <input type="hidden" name="prevTotal" value="${shop.totalBalance}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 금액</label>
                        <div class="col-8 text-right">
                            <form:input type="number" class="form-control text-right form-control-sm" path="funds" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 후 잔액</label>
                        <div class="col-8 text-right text-danger">
                            <span class="totalBalance">${shop.totalBalance}</span> 원
                            <form:hidden path="totalFunds" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">비고</label>
                        <div class="col-8">
                            <form:textarea path="description" class="form-control-sm form-control" rows="3" />
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-primary" form="transactionForm2">적용</button>
            </div>
        </div>
    </div>
</div>

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
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/libs/flatpickr/flatpickr.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>

    $(document).ready(function() {
        var token = $("meta[name='_csrf']").attr("content");

        $('#dateFrom, #dateTo').datepicker({
            dateFormat: 'yy-mm-dd'
        })
        $('#imSearch').on('change', function() {
            $('#form').submit();
        });

        $('#transactionForm1 input[name="amount"]').on('keyup', function () {
            var amount = $(this).val();
            var prevTotal = $('#transactionForm1 input[name="prevTotal"]').val();
            if (parseInt(amount) > 0) {
                var totalAmount = parseInt(prevTotal) - parseInt(amount);
                $('#transactionForm1 input[name="totalAmount"]').val(totalAmount);
                $('#transactionForm1 .totalAmount').text(totalAmount);
            }
        });

        $('#transactionForm2 input[name="amount"]').on('keyup', function () {
            var amount = $(this).val();
            var prevTotal = $('#transactionForm2 input[name="prevTotal"]').val();
            var method = $('#transactionForm2 input[name="processingMethod"]:checked').val();
            console.log(method);
            if (parseInt(amount) > 0) {
                if (method === 'fund_plus') {
                    var totalAmount = parseInt(prevTotal) + parseInt(amount);
                } else {
                    var totalAmount = parseInt(prevTotal) - parseInt(amount);
                }
                $('#transactionForm2 input[name="totalAmount"]').val(totalAmount);
                $('#transactionForm2 .totalBalance').text(totalAmount);
            }
        });

        $('#transactionForm2 input[name="processingMethod"]').on('change', function () {
            var method = $('#transactionForm2 input[name="processingMethod"]:checked').val();
            var amount = $('#transactionForm2 input[name="amount"]').val();
            var prevTotal = $('#transactionForm2 input[name="prevTotal"]').val();
            console.log(method);
            if (parseInt(amount) > 0) {
                if (method === 'fund_plus') {
                    var totalAmount = parseInt(prevTotal) + parseInt(amount);
                } else {
                    var totalAmount = parseInt(prevTotal) - parseInt(amount);
                }
                $('#transactionForm2 input[name="totalAmount"]').val(totalAmount);
                $('#transactionForm2 .totalBalance').text(totalAmount);
            }
        });

        $('#transactionForm1, #transactionForm2').submit(function (e) {
            e.preventDefault();
            var amount = $(this).find('input[name="amount"]').val();
            if (parseInt(amount) > 0) {
                $.ajax({
                    type: 'POST',
                    url: $(this).attr('action'),
                    data: $(this).serialize(),
                    beforeSend: function() {
                        $("#overlay").fadeIn(300);
                    },
                    success: function(data) {
                        toastr.success(data.message);
                        window.location.reload();
                    }
                }).done(function () {
                    setTimeout(function() {
                        $("#overlay").fadeOut(300);
                    }, 500);
                });
            } else {
                toastr.error('입금 금액은 0보다 커야 합니다.');
            }
        });
    });
</script>
</body>
</html>