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
    <link href="${contextPath}/resources/toastr-2.1.4/toastr.min.css" rel="stylesheet" type="text/css"/>
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
    <div class="left-side-menu">
        <div class="side-menu-logo">
            <a href="/">
                <img src="${contextPath}/resources/images/logo_dark.svg" alt="logo" height="40" class="logo-icon"/>
                <img src="${contextPath}/resources/images/logo_pando_dark.svg" alt="logo" height="40"
                     class="logo-full"/>
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
                                <li class="breadcrumb-item"><a href="/orders">주문 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">신규주문 등록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">신규주문 등록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <form:form method="post" modelAttribute="orderForm" id="order_form">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">주문 정보</h5>
                                    <table class="table form-table table-bordered mb-5">
                                        <tbody class="thead-light">
                                        <tr>
                                            <spring:bind path="shop">
                                                <th class="required"><span>거래처 선택</span></th>
                                                <td colspan="3">
<%--                                                    <div class="input-group w-50">--%>
<%--                                                        <input id="shop_name" type="text" value="${orderForm.shop.name}"--%>
<%--                                                               class="form-control ${status.error ? 'is-invalid' : ''}"/>--%>
<%--                                                        <div class="input-group-append">--%>
<%--                                                            <button type="button" id="shop_select"--%>
<%--                                                                    class="btn btn-outline-primary">거래처 선택--%>
<%--                                                            </button>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
<%--                                                    <form:hidden path="shop"/>--%>
                                                    <form:select path="shop" cssClass="form-control w-25">
                                                        <form:option value="" label="-- 거래처 선택 --" />
                                                        <form:options items="${shops}" itemLabel="name" itemValue="id" />
                                                    </form:select>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="shop"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="deliveryType">
                                                <th>배송유형</th>
                                                <td>
                                                    <div class="custom-control custom-radio custom-control-inline">
                                                        <form:radiobutton id="customRadioInline1" path="deliveryType"
                                                                          value="direct"
                                                                          class="custom-control-input"/>
                                                        <label class="custom-control-label"
                                                               for="customRadioInline1">직배송</label>
                                                    </div>
                                                    <div class="custom-control custom-radio custom-control-inline">
                                                        <form:radiobutton id="customRadioInline2" path="deliveryType"
                                                                          value="parcel"
                                                                          class="custom-control-input"/>
                                                        <label class="custom-control-label" for="customRadioInline2">택배
                                                            배송</label>
                                                    </div>
                                                    <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                        <form:errors path="deliveryType"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="requestDate">
                                                <th>배송요청일</th>
                                                <td>
                                                    <div class="input-group">
                                                        <form:input class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                    path="requestDate" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="requestDate"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="deliverer">
                                                <th class="required"><span>배송 담당자</span></th>
                                                <td>
                                                    <form:select
                                                            class="form-control ${status.error ? 'is-invalid' : ''}"
                                                            path="deliverer">
                                                        <option value="0">-- 선택 --</option>
                                                        <form:options items="${deliverers}" itemValue="id"
                                                                      itemLabel="fullName"/>
                                                    </form:select>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="deliverer"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="salesMan">
                                                <th>영업 담당자</th>
                                                <td>
                                                    <form:select
                                                            class="form-control ${status.error ? 'is-invalid' : ''}"
                                                            path="salesMan">
                                                        <option value="0">-- 선택 --</option>
                                                        <form:options items="${salesMans}" itemValue="id"
                                                                      itemLabel="fullName"/>
                                                    </form:select>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="salesMan"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <spring:bind path="requestMemo">
                                            <tr>
                                                <th>요청사항</th>
                                                <td colspan="3">
                                                    <form:textarea path="requestMemo"
                                                                   class="form-control w-75 ${status.error ? 'is-invalid' : ''}"
                                                                   rows="3"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="requestMemo"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="memo">
                                            <tr>
                                                <th>메모</th>
                                                <td colspan="3">
                                                    <form:textarea path="memo" class="form-control w-75" rows="3"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="memo"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">
                                        상품 목록
                                    </h5>
                                    <div class="row mb-2">
                                        <div class="col-6">
                                            <span class="sub_table_title" id="ok_total">
                                                전체 0건
                                            </span>
                                        </div>
                                        <div class="col-6 text-right">
                                            <button type="button" class="btn btn-sm btn-outline-primary float-right" data-toggle="modal" data-target="#selectProductsModal">상품추가
                                            </button>
                                        </div>
                                    </div>
                                    <table id="cartTable" class="table table-sm text-center table-hover mb-5">
                                        <colgroup>
                                            <col width="5%">
                                            <col width="">
                                            <col width="">
                                            <col width="">
                                            <col width="10%">
                                            <col width="10%">
                                            <col width="8%">
                                        </colgroup>
                                        <thead class="thead-light">
                                        <tr>
                                            <th scope="col">no</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">규격<br>(단위)</th>
                                            <th scope="col">제조사<br>(원산지)</th>
                                            <th scope="col">수량</th>
                                            <th scope="col">단가(원)</th>
                                            <th scope="col">합계금액</th>
                                            <th scope="col">삭제</th>
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
                                        <tfoot class="thead-light">

                                        </tfoot>
                                    </table>
                                    <div class="form-group text-center">
                                        <a href="/orders" class="btn btn-dark">목록으로</a>
                                        <button class="btn btn-outline-primary">등록하기</button>
                                    </div>
                                </div>
                            </div>
                        </form:form>
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
<div class="modal fade" id="shopSelectModal">
    <div class="modal-dialog-centered modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">거래처 검색</div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="shopFrm">
                    <div class="form-group row">
                        <label class="col-form-label text-right col-3 font-weight-bold">검색</label>
                        <div class="col-9">
                            <input id="tit01" name="search_text" type="text" value="" title="검색어 입력"
                                   class="form-control form-control-sm" placeholder="검색어를 입력해주세요.">
                            <small class="form-text">* 거래처명, 거래처 연락처, 배송 담당자명을 입력하면 자동으로 검색됩니다.</small>
                        </div>
                    </div>
                </form>
                <div style="height: 430px;">
                    <table class="table table-middle text-center table-hover" id="shopTable">
                        <colgroup>
                            <col width="10%">
                            <col width="">
                            <col width="20%">
                            <col width="15%">
                            <col width="15%">
                            <col width="15%">
                        </colgroup>
                        <thead class="thead-light">
                        <tr>
                            <th>#</th>
                            <th>거래처명</th>
                            <th>거래처 연락처</th>
                            <th>배송 담당자</th>
                            <th>거래처 선택</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="selectProductsModal">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">
                    상품 검색 및 선택
                </div>
                <button type="button" class="close text-right" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="searchForm" method="get">
                    <table class="table form-table table-bordered">
                        <colgroup>
                            <col style="width: 10%">
                            <col style="width: 57%">
                            <col>
                        </colgroup>
                        <tbody class="thead-light">
                        <th>즉시 검색</th>
                        <td>
                            <div class="row">
                                <div class="col-4">
                                    <form:select path="category" cssClass="form-control form-control-sm">
                                        <form:option value="" label="카테고리" />
                                        <form:options items="${categories}" itemValue="id" itemLabel="name" />
                                    </form:select>
                                </div>
                                <div class="col-8">
                                    <form:input path="keyword" cssClass="form-control form-control-sm" placeholder="상품명 또는 상품코드를 입력하세요." />
                                </div>
                            </div>
                        </td>
                        <td>
                            <button class="btn btn-outline-primary">검색</button>
                        </td>
                        </tbody>
                    </table>
                </form:form>
                <div class="row">
                    <div class="col-lg-7">
                        <div class="row mb-3">
                            <div class="col-6 text-primary">
                                <small>*해당 거래처에서 자주 주문한 상품 순입니다.</small>
                            </div>
                            <div class="col-6 text-right">전체 <span id="productsCount"></span>건</div>
                        </div>
                        <div class="list-wrap" style="height:460px; overflow: auto;">
                            <table id="productsTable" class="table table-hover text-center table-sm">
                                <colgroup>
                                    <col width="*">
                                    <col width="10%">
                                    <col width="15%">
                                    <col width="15%">
                                </colgroup>
                                <thead class="thead-light">
                                <tr>
                                    <th>상품명</th>
                                    <th>재고량</th>
                                    <th>매입 단가(원)</th>
                                    <th>판매 단가(원)</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="row mb-3">
                            <div class="col-6">선택상품 목록<span class="cor_primary" id="goodsSelectCountText">(전체 0건)</span></div>
                            <div class="col-6 text-right"><a class="btn btn-sm btn-outline-primary" id="resetCart" href="javascript:;" role="button"><i class="fa fa-undo"></i></a></div>
                        </div>
                        <div id="goods_select_wrap">
                            <div style="height:420px; overflow: auto;">
                                <ul class="list-group" id="shopping_cart">
                                </ul>
                            </div>
                            <div class="bg-light p-4">
                                <div class="row">
                                    <div class="col-6">합계금액</div>
                                    <div class="col-6 text-right"><span id="totalAmount">0</span>원</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button id="cartItemsSave" class="btn btn-primary">저장</button>
            </div>
        </div>
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

    var allProducts = [];

    var cartProducts = [];

    function updateTotal() {
        var totalAmount = 0;
        var sumQty = 0;
        cartProducts.forEach(function(product) {
            totalAmount += product.qty * product.sellPrice;
            sumQty += product.qty;
        });
        $('#totalAmount, .total').html(totalAmount);
        $('.sumQty').html(sumQty);
    }

    $('#requestDate').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    function getProducts() {
        $.ajax({
            type: 'GET',
            url: '/products/data_for_order',
            data: $('#searchForm').serialize(),
            success: function(data) {
                var tableElement = $('#productsTable');
                allProducts = data.products;
                var tbodyHtml = '';
                allProducts.forEach(function (product, index) {
                    var trHtml =
                        '<tr data-id="' + product.id + '">' +
                        '<td>' + product.name + '</td>' +
                        '<td>' + product.qty + '</td>' +
                        '<td>' + product.buyPrice + '</td>' +
                        '<td>' + product.sellPrice + '</td>' +
                        '</tr>';
                    tbodyHtml += trHtml;
                });
                tableElement.find('tbody').html(tbodyHtml);
                $('#productsModal').modal();
            }
        })
    }

    $('#selectProductsModal').on('show.bs.modal', function() {
        getProducts();
    });

    $('#searchForm').on('submit', function(e) {
        e.preventDefault();
        getProducts();
    });

    $('#keyword').on('keyup', function(e) {
        getProducts();
    })

    $('#productsTable tbody').on('click', 'tr', function() {
        var productId = $(this).data('id');
        var orderProduct = allProducts.find(product => product.id === productId);

        if (cartProducts.find(item => item.id === orderProduct.id)) {

        } else {
            orderProduct.qty = 0;
            cartProducts.push(orderProduct);
            var html =
                '<li class="list-group-item" data-id=' + orderProduct.id + '>\n' +
                '    <button class="close">&times;</button>\n' +
                '    <h6>' + orderProduct.name + '</h6>\n' +
                '    <p><span class="unit">' + orderProduct.unit + '</span> / <span class="country"> ' + orderProduct.country + '</span> </p>\n' +
                '    <div class="form-inline">\n' +
                '        <input class="form-control form-control-sm text-center qty mx-2" type="number" style="width: 100px;" value="' + 0 + '">\n' +
                '        <div class="input-group input-group-sm" style="width: 35%">\n' +
                '            <input class="form-control form-control-sm text-right price" type="number" value="' + orderProduct.sellPrice + '">\n' +
                '            <div class="input-group-append">\n' +
                '                <span class="input-group-text">원</span>\n' +
                '            </div>\n' +
                '        </div>\n' +
                '    </div>\n' +
                '</li>';
            $('#shopping_cart').append(html);
            updateTotal();
        }
    });

    $('#cartItemsSave').on('click', function () {
        $('#selectProductsModal').modal('hide');

        var tbodyHtml = '';
        var sumQty = 0;
        var total = 0;
        cartProducts.forEach(function (product, index) {
            sumQty += product.qty;
            total += product.qty * product.sellPrice;
            var trHtml =
                '<tr data-id="' + product.id + '">' +
                '<td>' + product.id + '</td>' +
                '<td>' + product.name + '</td>' +
                '<td>' + product.standard + '</td>' +
                '<td>' + product.makerName + '</td>' +
                '<td><input class="form-control form-control-sm qty" style="width: 100px;" type="number" value="' + product.qty + '" /></td>' +
                '<td><input class="form-control form-control-sm price" style="width: 100px;" type="number" value="' + product.sellPrice + '" /></td>' +
                '<td class="subtotal">' + product.qty * product.sellPrice + '</td>' +
                '<td><button type="button" class="btn btn-outline-danger btn-sm remove">삭제</button></td>' +
                '</tr>';
            tbodyHtml += trHtml;
        });

        var tfootHtml =
            '<tr>' +
            '<th>합계</th>' +
            '<td></td>' +
            '<td></td>' +
            '<td></td>' +
            '<td class="sumQty">' + sumQty + '</td>' +
            '<td></td>' +
            '<td class="total">' + total + '</td>' +
            '</tr>';

        $('#cartTable tbody').html(tbodyHtml);
        $('#cartTable tfoot').html(tfootHtml);
    });

    $('#cartTable tbody').on('click', '.remove', function () {
        var productId = $(this).closest('tr').data('id');
        cartProducts = cartProducts.filter(product => product.id !== productId);
        $(this).closest('tr').remove();
        updateTotal();
    })

    $('#shopping_cart').on('click', 'li .close', function () {
        var productId = $(this).closest('li').data('id');
        cartProducts = cartProducts.filter(item => item.id !== productId);
        $(this).closest('li').remove();
        updateTotal();
    });

    $('#shopping_cart').on('keyup', '.qty', function() {
        var productId = $(this).closest('li').data('id');
        var qty = $(this).val();
        cartProducts.map(product => {
            if (product.id === productId) {
                product.qty = parseFloat(qty);
            }
        });
        updateTotal();
    });

    $('#cartTable').on('keyup', '.qty', function() {
        var productId = $(this).closest('tr').data('id');
        var qty = $(this).val();
        cartProducts.map(product => {
            if (product.id === productId) {
                product.qty = parseFloat(qty);
            }
        });
        var sellPrice = $(this).closest('tr').find('.price').val();
        $(this).closest('tr').find('.subtotal').html(parseFloat(sellPrice) * parseFloat(qty));
        updateTotal();
    });

    $('#cartTable').on('keyup', '.price', function() {
        var productId = $(this).closest('tr').data('id');
        var qty = $(this).closest('tr').find('.qty').val();
        var sellPrice = $(this).closest('tr').find('.price').val();
        cartProducts.map(product => {
            if (product.id === productId) {
                product.sellPrice = parseFloat(sellPrice);
            }
        });
        $(this).closest('tr').find('.subtotal').html(parseFloat(sellPrice) * parseFloat(qty));
        updateTotal();
    });

    $('#resetCart').on('click', function() {
        cartProducts = [];
        $('#shopping_cart').html('');
        updateTotal();
    })

    $('#order_form').on('submit', function (e) {
        e.preventDefault();
        var shopId = $('#shop').val();
        var deliveryType = $('input[name="deliveryType"]:checked').val();
        var requestDate = $('#requestDate').val();
        var delivererId = $('#deliverer').val();
        var salesmanId = $('#salesMan').val();
        var requestMemo = $('#requestMemo').val();
        var memo = $('#memo').text();
        if (!shopId || !delivererId || cartProducts.length === 0) {
            toastr.error('필수 입력 사항들을 입력하세요.');
            return false;
        }
        var order = {
            shop: shopId,
            deliveryType: deliveryType,
            requestDate: requestDate,
            deliverer: delivererId,
            salesman: salesmanId,
            requestMemo: requestMemo,
            memo: memo,
            products: cartProducts
        }
        $.ajax({
            type: 'POST',
            url: '/orders/store',
            contentType: 'application/json',
            accept: 'text/plain',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: JSON.stringify(order),
            beforeSend: function() {
                $("#overlay").fadeIn(300);
            },
            success: function(data) {
                toastr.success(data.message);
                window.location.href = "/orders";
            }
        }).done(function () {
            setTimeout(function(){
                $("#overlay").fadeOut(300);
            },500);
        });
    })

</script>
</body>
</html>