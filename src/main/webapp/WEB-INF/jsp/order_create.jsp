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
                <a href="/profile" class="nav-link"><i data-feather="user"></i>&nbsp;<c:out
                        value="${pageContext.request.remoteUser}"/> 정보보기</a>
            </li>
            <li class="nav-item d-none d-lg-block">
                <a href="javascript:;" class="nav-link"
                   onclick="document.getElementById('logout-form').submit();">로그아웃</a>
            </li>
            <li class="d-none d-sm-block">
                <div class="app-search">
                    <form>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search...">
                            <span data-feather="search"></span>
                        </div>
                    </form>
                </div>
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
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-sm rounded-circle mr-2"
                         alt="Pando"/>
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-xs rounded-circle mr-2"
                         alt="Pando"/>

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
                                                    <div class="input-group w-50">
                                                        <input id="shop_name" type="text" value="${orderForm.shop.name}"
                                                               class="form-control ${status.error ? 'is-invalid' : ''}"/>
                                                        <div class="input-group-append">
                                                            <button type="button" id="shop_select"
                                                                    class="btn btn-outline-primary">거래처 선택
                                                            </button>
                                                        </div>
                                                    </div>
                                                    <form:hidden path="shop"/>
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
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                path="requestDate" id="request-date"/>
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
                                            <button type="button" id="add_products"
                                                    class="btn btn-sm btn-outline-primary float-right">상품추가
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
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
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
                <h5 class="modal-title text-light">거래처 검색</h5>
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
                    <table class="table table-sm text-center table-hover" id="shopTable">
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
            <div class="modal-header">
                <div class="modal-title">
                    상품 검색 및 선택
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="row mb-3">
                            <div class="col-6 text-primary">
                                <small>*해당 거래처에서 자주 주문한 상품 순입니다.</small>
                            </div>
                            <div class="col-6 text-right">전체 ${products.size()}건</div>
                        </div>
                        <div class="list-wrap" style="height:460px; overflow: auto;">
                            <table id="goodsTable" class="table table-hover text-center table-sm">
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
                                    <th>매입 단가</th>
                                    <th>판매 단가</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${products}" var="product">
                                    <tr data-id="${product.id}">
                                        <td>${product.name}</td>
                                        <td>${product.qty}</td>
                                        <td>${product.buyPrice}</td>
                                        <td>${product.sellPrice}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="row mb-3">
                            <div class="col-6">선택상품 목록<span class="cor_primary" id="goodsSelectCountText">(전체 0건)</span></div>
                            <div class="col-6 text-right"><a class="btn btn-sm btn-outline-primary" role="button">초기화</a></div>
                        </div>
                        <div id="goods_select_wrap">
                            <div style="height:420px; overflow: auto;">
                                <ul class="list-group" id="shopping_cart">

                                </ul>
                            </div>
                            <div class="bg-light p-4">
                                <div id="goods_sum" class="row">
                                    <div id="pop_goods_sum_tit" class="col-6">합계금액</div>
                                    <div id="totalResult" class="col-6">0원</div>
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
    $('#request-date').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    function setShopName(shop_id, shop_name) {
        $('#shop_name').val(shop_name);
        $('#shop').val(shop_id);
        $('#shopSelectModal').modal('hide');
    }

    //거래처 목록 검색
    function getShopList() {
        var brand_count = parseInt($("#joinForm").find("input[name='brand_count']").val());

        var search_text = $("#shopFrm").find("input[name='search_text']");
        var formData = "search_text=" + search_text.val();


        $.ajax({
            type: 'POST',
            url: '/shops/get_shops',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: {
                'keyword': search_text.val()
            },
            success: function (data) {
                var add_data = "";

                if (data.shops != null) {
                    $.each(data.shops, function (key, shop) {
                        var shop_id = decodeURIComponent(shop.id).replace(/\+/g, " ");
                        var shop_name = decodeURIComponent(shop.name).replace(/\+/g, " ");
                        var shop_tel = decodeURIComponent(shop.owner.phone).replace(/\+/g, " ").trim();
                        var delivery_vendor_user_name = decodeURIComponent(shop.deliverer.fullName).replace(/\+/g, " ").trim();
                        // var shop_type = decodeURIComponent(shop["shop_type"]).replace(/\+/g, " ").trim();

                        var tr_class = "";

                        add_data += "<tr " + tr_class + " onclick=\"javascript:setShopName(" + shop_id + ",'" + shop_name + "')\">"
                            + "<td>" + shop_id + "</td> "
                            + "<td>" + shop_name + "</td> "
                            + "<td>" + shop_tel + "</td> "
                            + "<td>" + delivery_vendor_user_name + "</td> "
                            + "<td class='text-center'><a class='btn btn-sm text-success strong' href='#'>선택</a></td> "
                            + "</tr> ";

                    });

                    $("#shopTable tbody").html(add_data);
                }
            }
        });
    }

    function updateTotal() {
        var totalPrice = 0;
        $('#shopping_cart li').each(function(index) {
            var price = $(this).find('.price').val();
            var qty = $(this).find('.qty').val();
            totalPrice += parseInt(price) * parseInt(qty);
        })
        $('#totalResult').html(totalPrice + '원');
    }


    $('#shop_select').click(function () {
        $("#shopFrm").find("input[name='search_text']").val("");
        getShopList();
        $('#shopSelectModal').modal();
    });

    $('#shopping_cart').on('click', '.close', function () {
        var itemId = $(this).closest('li').data('id');
        var element = $(this);
        $.ajax({
            type: 'POST',
            url: '/cart/delete',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: {
                id: itemId
            },
            success: function(data) {
                element.closest('li').remove();
                updateTotal();
            }
        })
    });

    $('#shopping_cart').on('click', '.minus', function () {
        var itemId = $(this).closest('li').data('id');
        var itemElement = $(this).closest('li');
        $.ajax({
            type: 'POST',
            url: '/cart/update',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: {
                id: itemId,
                action: 'minus',
            },
            success: function(data) {
                itemElement.find('.qty').val(data.item.qty);
                updateTotal();
            }
        })
    });

    $('#shopping_cart').on('click', '.plus', function () {
        var itemElement = $(this).closest('li');
        var itemId = $(this).closest('li').data('id');

        $.ajax({
            type: 'POST',
            url: '/cart/update',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: {
                id: itemId,
                action: 'plus',
            },
            success: function(data) {
                itemElement.find('.qty').val(data.item.qty);
                updateTotal();
            }
        })
    });

    $('#shopping_cart').on('change', '.price', function () {
        var itemId = $(this).closest('li').data('id');
        var itemElement = $(this).closest('li');
        $.ajax({
            type: 'POST',
            url: '/cart/update_price',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: {
                id: itemId,
                price: $(this).val()
            },
            success: function(data) {
                itemElement.find('.price').val(data.item.price);
                updateTotal();
            }
        })
    });

    $('#shopping_cart').on('change', '.qty', function () {
        var itemId = $(this).closest('li').data('id');
        var itemElement = $(this).closest('li');
        $.ajax({
            type: 'POST',
            url: '/cart/update_qty',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: {
                id: itemId,
                qty: $(this).val()
            },
            success: function(data) {
                itemElement.find('.qty').val(data.item.qty);
                updateTotal();
            }
        })
    });

    $('#add_products').on('click', function () {
        $.ajax({
            url: '/cart/all',
            success: function(data) {
                if (data.items.length > 0) {
                    $('#shopping_cart').html('');
                    data.items.forEach(function (item, index) {
                        var html =
                            '<li class="list-group-item" data-id='+ item.id + '>\n' +
                            '    <button class="close">&times;</button>\n' +
                            '    <h6>' + item.product.name + '</h6>\n' +
                            '    <p><span class="unit">' + item.product.unit +  '</span> / <span class="country"> ' + item.product.country +'</span> </p>\n' +
                            '    <div class="form-inline">\n' +
                            '        <select class="form-control form-control-sm mr-1" style="width: 35%">\n' +
                            '            <option value="">단가 그룹</option>\n' +
                            '        </select>\n' +
                            '        <div class="input-group input-group-sm mr-1">\n' +
                            '            <div class="input-group-prepend">\n' +
                            '                <button class="btn btn-secondary btn-sm minus"><i class="fa fa-minus"></i></button>\n' +
                            '            </div>\n' +
                            '            <input class="form-control text-center qty" style="width: 50px;" value="'+ item.qty + '">\n' +
                            '            <div class="input-group-append">\n' +
                            '                <button class="btn btn-secondary btn-sm plus"><i class="fa fa-plus"></i></button>\n' +
                            '            </div>\n' +
                            '        </div>\n' +
                            '        <div class="input-group input-group-sm" style="width: 35%">\n' +
                            '            <input class="form-control form-control-sm price" type="number" value="'+ item.price + '">\n' +
                            '            <div class="input-group-append">\n' +
                            '                <span class="input-group-text">원</span>\n' +
                            '            </div>\n' +
                            '        </div>\n' +
                            '    </div>\n' +
                            '</li>';
                        $('#shopping_cart').append(html);
                        updateTotal();
                    });
                }
            }
        })
        $('#selectProductsModal').modal('show');
    });

    $('#goodsTable tbody tr').on('click', function() {
        var productId = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: '/cart/store',
            headers: {
                'X-CSRF-TOKEN': token,
            },
            data: {
                product: productId,
                qty: 0,
                price: 0,
            },
            success: function(data) {
                if(data.status === 'created') {
                    var html =
                        '<li class="list-group-item" data-id='+ data.item.id + '>\n' +
                        '    <button class="close">&times;</button>\n' +
                        '    <h6>' + data.item.product.name + '</h6>\n' +
                        '    <p><span class="unit">' + data.item.product.unit +  '</span> / <span class="country"> ' + data.item.product.country +'</span> </p>\n' +
                        '    <div class="form-inline">\n' +
                        '        <select class="form-control form-control-sm mr-1" style="width: 35%">\n' +
                        '            <option value="">단가 그룹</option>\n' +
                        '        </select>\n' +
                        '        <div class="input-group input-group-sm mr-1">\n' +
                        '            <div class="input-group-prepend">\n' +
                        '                <button class="btn btn-secondary btn-sm minus"><i class="fa fa-minus"></i></button>\n' +
                        '            </div>\n' +
                        '            <input class="form-control text-center qty" style="width: 50px;" value="'+ data.item.qty + '">\n' +
                        '            <div class="input-group-append">\n' +
                        '                <button class="btn btn-secondary btn-sm plus"><i class="fa fa-plus"></i></button>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '        <div class="input-group input-group-sm" style="width: 35%">\n' +
                        '            <input class="form-control form-control-sm price" type="number" value="'+ data.item.price + '">\n' +
                        '            <div class="input-group-append">\n' +
                        '                <span class="input-group-text">원</span>\n' +
                        '            </div>\n' +
                        '        </div>\n' +
                        '    </div>\n' +
                        '</li>';
                    $('#shopping_cart').append(html);
                } else {
                    var itemElement = $('#shopping_cart').find('li[data-id="' + data.item.id + '"]');
                    itemElement.find('.price').val(data.item.price);
                    itemElement.find('.qty').val(data.item.qty);
                }
            }
        })
    });

    $('#cartItemsSave').click(function () {
        $('#cartTable tbody').html('');
        $('#shopping_cart li').each(function(index) {
            var productId = $(this).data('id')
            var productName = $(this).find('h6').html();
            var unit = $(this).find('.unit').html();
            var country = $(this).find('.country').html();
            var qty = $(this).find('.qty').val();
            var price = $(this).find('.price').val();
            var html =
                '<tr>' +
                '<td>' + productId + '</td>' +
                '<td>' + productName + '</td>' +
                '<td>' + unit + '</td>' +
                '<td>' + country + '</td>' +
                '<td>' + qty + '</td>' +
                '<td>' + price + '</td>' +
                '<td>' + parseInt(price) * parseInt(qty) + '</td>' +
                '</tr>'
            $('#cartTable tbody').append(html);
        })
        $('#selectProductsModal').modal('hide');
    });
</script>
</body>
</html>