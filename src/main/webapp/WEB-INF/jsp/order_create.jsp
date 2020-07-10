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
    <link href="${contextPath}/resources/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${contextPath}/resources/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${contextPath}/resources/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css"
          rel="stylesheet" type="text/css"/>
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
                            <li>
                                <a href="/product-orders">상품별 주문 목록</a>
                            </li>
                            <li>
                                <a href="/returns">반품 내역</a>
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
                                <div class="card-header">
                                    <h5 class="mb-0">주문 정보</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <spring:bind path="shop">
                                            <div class="col-lg-6">
                                                <div class="form-group row required">
                                                    <label class="col-form-label col-lg-4">거래처 선택</label>
                                                    <div class="col-lg-8">
                                                        <form:select path="shop" class="form-control ${status.error ? 'is-invalid' : ''}">
                                                            <option value="0">거래처명을 입력해주세요.</option>
                                                            <form:options items="${shops}" itemValue="id" itemLabel="name" />
                                                        </form:select>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="shop" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="row">
                                        <spring:bind path="deliveryType">
                                            <div class="col-lg-6">
                                                <div class="form-group row align-items-center">
                                                    <label class="col-form-label col-lg-4">배송유형</label>
                                                    <div class="col-lg-8">
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <form:radiobutton id="customRadioInline1" path="deliveryType" value="direct"
                                                                              class="custom-control-input" />
                                                            <label class="custom-control-label"
                                                                   for="customRadioInline1">직배송</label>
                                                        </div>
                                                        <div class="custom-control custom-radio custom-control-inline">
                                                            <form:radiobutton id="customRadioInline2" path="deliveryType" value="parcel"
                                                                              class="custom-control-input" />
                                                            <label class="custom-control-label" for="customRadioInline2">택배
                                                                배송</label>
                                                        </div>
                                                        <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                            <form:errors path="deliveryType" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="requestDate">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">배송요청일</label>
                                                    <div class="col-lg-8">
                                                        <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="requestDate" id="request-date" />
                                                        <div class="invalid-feedback">
                                                            <form:errors path="requestDate" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="row">
                                        <spring:bind path="deliverer">
                                            <div class="col-md-6">
                                                <div class="form-group required row">
                                                    <label class="col-form-label col-md-4">배송 담당자</label>
                                                    <div class="col-md-8 align-self-center">
                                                        <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="deliverer">
                                                            <option value="0">-- 선택 --</option>
                                                            <form:options items="${deliverers}" itemValue="id" itemLabel="fullName" />
                                                        </form:select>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="deliverer" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="salesMan">
                                            <div class="col-md-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-md-4">영업 담당자</label>
                                                    <div class="col-md-8">
                                                        <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="salesMan">
                                                            <option value="0">-- 선택 --</option>
                                                            <form:options items="${salesMans}" itemValue="id" itemLabel="fullName" />
                                                        </form:select>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="salesMan" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <spring:bind path="requestMemo">
                                        <div class="form-group row">
                                            <label class="col-form-label col-md-2">요청사항</label>
                                            <div class="col-md-10">
                                                <form:textarea path="requestMemo" class="form-control ${status.error ? 'is-invalid' : ''}" rows="3" />
                                                <div class="invalid-feedback">
                                                    <form:errors path="requestMemo" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <spring:bind path="memo">
                                        <div class="form-group row">
                                            <label class="col-form-label col-md-2">메모</label>
                                            <div class="col-md-10">
                                                <form:textarea path="memo" class="form-control" rows="3" />
                                                <div class="invalid-feedback">
                                                    <form:errors path="memo" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        상품 목록
                                        <button data-toggle="modal" data-target="#selectProductsModal" type="button" class="btn btn-sm btn-outline-primary float-right">상품추가</button>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="orderProducts">
                                        <c:if test="${status.error}">
                                            <div class="alert alert-danger">
                                                <form:errors path="orderProducts" />
                                            </div>
                                        </c:if>
                                    </spring:bind>
                                    <div id="productList">

                                    </div>
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
<div class="modal fade" id="selectProductsModal">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title">
                    직배송 상품 검색 및 선택
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-7">
                        <p class="text-primary">* 해당 거래처에서 자주 주문한 상품 순입니다.</p>
                        <div>
                            <table class="table" id="products">
                                <thead class="thead-light">
                                <tr>
                                    <th>상품명</th>
                                    <th>재고량</th>
                                    <th>매입 단가</th>
                                    <th>판매 단가</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div id="cart_form">

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
<script src="${contextPath}/resources/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${contextPath}/resources/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="${contextPath}/resources/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="${contextPath}/resources/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
<script src="${contextPath}/resources/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="${contextPath}/resources/datatables.net-buttons-bs4/js/buttons.bootstrap4.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<template id="cartItem">
    <div>
        <div>
            <h5 class="title"></h5>
            <span class="unit"></span> / <span class="country"></span>
        </div>
        <div class="d-flex pb-2 mb-2 border-bottom">
            <input type="hidden" class="product-id" name="productIds[]" />
            <select class="form-control form-control-sm w-50" name="priceGroups[]">
                <option value="0">--단가 그룹 선택--</option>
                <c:forEach items="${priceGroups}" var="priceGroup">
                    <option value="${priceGroup.id}">${priceGroup.name}</option>
                </c:forEach>
            </select>
            <input class="form-control form-control-sm w-25" type="number" value="0" name="productCounts[]" />
            <input class="form-control form-control-sm w-25" type="number" value="0" name="productBuyPrices[]" />
        </div>
    </div>
</template>
<script>
    $('#request-date').datepicker({
        dateFormat: 'yy-mm-dd'
    });
    $(document).ready(function () {
        var token = $("meta[name='_csrf']").attr("content");

        var productTable = $('#products').DataTable({
            serverSide: true,
            ajax: {
                url: '/data/products',
                contentType: 'application/json',
                headers: {"X-CSRF-TOKEN": token},
                type: 'POST',
                data: function(d) {
                    return JSON.stringify(d);
                },
            },
            columns: [
                {data: 'name'},
                {data: null, searchable: false, orderable: false, defaultContent: ''},
                {data: 'buyPrice'},
                {data: 'sellPrice'},
            ]
        });

        $(document).on('shown.bs.modal', '#selectProductsModal', function () {
            productTable.columns.adjust();
        });

        $('#products tbody').on('click', 'tr', function () {
            var data = productTable.row( this ).data();
            console.log(data);

            var template = document.querySelector('#cartItem');

            var clone = template.content.cloneNode(true);
            clone.querySelector('.product-id').value = data.id;
            clone.querySelector('.title').textContent = data.name;
            clone.querySelector('.unit').textContent = data.unit;
            clone.querySelector('.country').textContent = data.country;
            var cartForm = document.querySelector('#cart_form');
            cartForm.appendChild(clone);
        });

        $('#cartItemsSave').on('click', function () {
            var cartItems = $('#cart_form');
            $('#selectProductsModal').modal('toggle');
            cartItems.appendTo('#productList');
        });

        $('#order_form').on('submit', function (e) {
            e.preventDefault();
            var form = $(this);
            $.ajax({
                type: 'POST',
                url: '/orders/create',
                data: form.serialize(),
                success: function (data) {
                    // window.location.href = '/orders';
                    console.log('OK');
                }
            })
        })
    })
</script>
</body>
</html>