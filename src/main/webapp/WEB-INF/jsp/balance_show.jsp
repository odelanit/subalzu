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

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/toastr-2.1.4/toastr.min.css" rel="stylesheet" type="text/css"/>
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
                                <li class="breadcrumb-item">매입처 잔액 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">매입처 잔액 상세내역</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">매입처 잔액 상세 내역</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row mb-2">
                            <div class="col-lg-4">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3 align-items-center">
                                            <div class="media-body">
                                                <h3 class="mb-0">${supplier.name}</h3>
                                            </div>
                                            <div class="align-self-center">
                                                <span class="d-block text-muted text-right font-weight-bold">현재 잔액</span>
                                                <span class="h3 text-danger"><fmt:formatNumber type="number" value="${supplier.totalFunds}" />원</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="searchForm" method="get">
                                    <table class="table form-table table-bordered">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateFrom" cssClass="form-control" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <span class="mx-2">-</span>
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateTo" cssClass="form-control" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td style="width: 40%;">
                                                <button class="btn btn-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline" id="imSearch">
                                                    <form:select class="form-control form-control-sm w-20 mr-2" path="type">
                                                        <form:option value="" label="구분" />
                                                        <form:option value="output" label="출금" />
                                                        <form:option value="shipping" label="매입" />
                                                        <form:option value="update" label="수정" />
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm w-20" path="method">
                                                        <form:option value="" label="처리방식" />
                                                        <form:option value="manual_order" label="일반 발주" />
                                                        <form:option value="auto_order" label="자동 발주" />
                                                        <form:option value="direct_minus" label="직접 출금" />
                                                        <form:option value="fund_minus" label="금액 차감" />
                                                        <form:option value="fund_plus" label="금액 추가" />
                                                        <form:option value="canceled_order" label="발주 취소" />
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row mb-3 align-items-center">
                                    <div class="col-lg-6">
                                        <span>전체 ${transactionPage.totalElements}건</span>
                                        <button type="button" class="btn btn-sm btn-primary" data-toggle="modal" data-target="#outputModal">출금 처리</button>
                                        <button type="button" class="btn btn-sm btn-secondary" data-toggle="modal" data-target="#manualModal">직접 수정</button>
                                    </div>
                                    <div class="col-lg-6 text-lg-right">
                                        <button class="btn btn-sm btn-outline-primary">
                                            <i class="fa fa-file-excel"></i> Excel 다운로드
                                        </button>
                                    </div>
                                </div>
                                <table class="table table-middle table-hover text-center">
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
                                    <c:forEach items="${transactions}" var="transaction">
                                        <tr>
                                            <td>${transaction.id}</td>
                                            <td>${transaction.createdAt.format(localDateTimeFormat)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${transaction.type == 'output'}">
                                                        출금
                                                    </c:when>
                                                    <c:when test="${transaction.type == 'order'}">
                                                        매입
                                                    </c:when>
                                                    <c:when test="${transaction.type == 'update'}">
                                                        수정
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${transaction.method == 'direct_minus'}">
                                                        직접 출금
                                                    </c:when>
                                                    <c:when test="${transaction.method == 'fund_minus'}">
                                                        금액 차감
                                                    </c:when>
                                                    <c:when test="${transaction.method == 'fund_plus'}">
                                                        금액 추가
                                                    </c:when>
                                                    <c:when test="${transaction.method == 'manual_order'}">
                                                        일반 발주
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatNumber value="${transaction.amount}" type="number" />원</td>
                                            <td><fmt:formatNumber value="${transaction.totalAmount}" type="number" />원</td>
                                            <td>${transaction.description}</td>
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
<div class="modal fade" id="outputModal">
    <div class="modal-dialog-centered modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">
                    출금 처리
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form:form method="post" modelAttribute="form1" action="/balance/add">
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">
                                ${supplier.name}
                            <form:hidden path="supplier" />
                            <form:hidden path="type" />
                            <form:hidden path="method" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                                ${supplier.totalFunds} 원
                            <form:hidden path="prevTotal" value="${supplier.totalFunds}" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">입금 금액</label>
                        <div class="col-8 text-right">
                            <form:input type="number" class="form-control text-right form-control-sm" path="amount" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">입금 후 잔액</label>
                        <div class="col-8 text-right text-danger">
                            <span class="totalAmount">${supplier.totalFunds}</span> 원
                            <form:hidden path="totalAmount" />
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
                <button class="btn btn-primary" form="form1">적용</button>
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
                <form:form method="post" modelAttribute="form2" action="/balance/add">
                    <div class="form-group row">
                        <label class="col-form-label col-4">구분</label>
                        <div class="col-8 text-right">
                            <div class="custom-control custom-control-inline custom-radio">
                                <form:radiobutton class="custom-control-input" path="method" value="fund_minus" id="transactionType1" />
                                <label class="custom-control-label" for="transactionType1">금액 차감</label>
                            </div>
                            <div class="custom-control custom-control-inline custom-radio">
                                <form:radiobutton class="custom-control-input" path="method" value="fund_plus" id="transactionType2" />
                                <label class="custom-control-label" for="transactionType2">금액 추가</label>
                            </div>
                        </div>
                        <form:hidden path="prevTotal" value="${supplier.totalFunds}" />
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">
                                ${supplier.name}
                            <form:hidden path="supplier" />
                            <form:hidden path="type" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                                ${supplier.totalFunds} 원
                            <input type="hidden" name="prevTotal" value="${supplier.totalFunds}">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 금액</label>
                        <div class="col-8 text-right">
                            <form:input type="number" class="form-control text-right form-control-sm" path="amount" />
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 후 잔액</label>
                        <div class="col-8 text-right text-danger">
                            <span class="totalBalance">${supplier.totalFunds}</span> 원
                            <form:hidden path="totalAmount" />
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
                <button class="btn btn-primary" form="form2">적용</button>
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
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $('#dateFrom, #dateTo').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $('#form1 input[name="amount"]').on('keyup', function () {
        var amount = $(this).val();
        var prevTotal = $('#form1 input[name="prevTotal"]').val();
        if (parseInt(amount) > 0) {
            var totalAmount = parseInt(prevTotal) - parseInt(amount);
            $('#form1 input[name="totalAmount"]').val(totalAmount);
            $('#form1 .totalAmount').text(totalAmount);
        }
    });

    $('#form2 input[name="amount"]').on('keyup', function () {
        var amount = $(this).val();
        var prevTotal = $('#form2 input[name="prevTotal"]').val();
        var method = $('#form2 input[name="method"]:checked').val();
        console.log(method);
        if (parseInt(amount) > 0) {
            if (method === 'fund_plus') {
                var totalAmount = parseInt(prevTotal) + parseInt(amount);
            } else {
                var totalAmount = parseInt(prevTotal) - parseInt(amount);
            }
            $('#form2 input[name="totalAmount"]').val(totalAmount);
            $('#form2 .totalBalance').text(totalAmount);
        }
    });

    $('#form2 input[name="method"]').on('change', function () {
        var method = $('#form2 input[name="method"]:checked').val();
        var amount = $('#form2 input[name="amount"]').val();
        var prevTotal = $('#form2 input[name="prevTotal"]').val();
        console.log(method);
        if (parseInt(amount) > 0) {
            if (method === 'fund_plus') {
                var totalAmount = parseInt(prevTotal) + parseInt(amount);
            } else {
                var totalAmount = parseInt(prevTotal) - parseInt(amount);
            }
            $('#form2 input[name="totalAmount"]').val(totalAmount);
            $('#form2 .totalBalance').text(totalAmount);
        }
    });

    $('#form1, #form2').submit(function (e) {
        e.preventDefault();
        var funds = $(this).find('input[name="amount"]').val();
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
    });

    $('#imSearch select').on('change', function() {
        $('#searchForm').submit();
    });
</script>
</body>
</html>