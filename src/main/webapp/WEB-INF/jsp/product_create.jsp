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
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/metismenu/metisMenu.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/dropzone-5.7.0/dropzone.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="/profile" class="nav-link"><i data-feather="user"></i>&nbsp;<c:out
                        value="${pageContext.request.remoteUser}"/> 정보보기</a>
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
                    <li>
                        <a href="javascript:;">
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
                    <li class="mm-active">
                        <a href="javascript:;">
                            <i class="fa fa-folder"></i>
                            <span> 상품 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item active" aria-current="page">상품 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">상품 등록</h4>
                    </div>
                </div>
                <form:form method="post" modelAttribute="productForm">
                    <div class="row">
                        <div class="col">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">기본 정보</h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <tbody class="thead-light">
                                        <spring:bind path="erpCode">
                                            <tr>
                                                <th>상품 코드</th>
                                                <td colspan="3">
                                                    <form:input path="erpCode"
                                                                cssClass="form-control w-50 ${status.error ? 'is-invalid': ''}"
                                                                placeholder="상품코드를 입력하세요."/>
                                                    <small class="form-text">기존에 쓰시는 ERP 상품 코드(단축코드)를 입력하세요. 없으면 입력하지
                                                        않아도 됩니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="erpCode"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="name">
                                            <tr>
                                                <th class="required"><span>상품명</span></th>
                                                <td colspan="3">
                                                    <form:input path="name"
                                                                cssClass="form-control w-50 ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="상품명을 입력하세요."/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="name"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="category">
                                            <tr>
                                                <th>카테고리</th>
                                                <td colspan="3">
                                                    <div class="d-flex">
                                                        <form:select path="category"
                                                                     cssClass="form-control w-25 mr-2 ${status.error ? 'is-invalid' : ''}">
                                                            <option value="">1차 카테고리</option>
                                                            <form:options items="${categories}" itemValue="id"
                                                                          itemLabel="name"/>
                                                        </form:select>
                                                        <form:select path="subCategory"
                                                                     cssClass="form-control w-25 ${status.error ? 'is-invalid' : ''}">
                                                            <option value="">2차 카테고리</option>
                                                            <c:if test="${productForm.category != null}">
                                                                <form:options items="${productForm.category.children}" itemValue="id" itemLabel="name" />
                                                            </c:if>
                                                        </form:select>
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="category"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <tr>
                                            <spring:bind path="makerName">
                                                <th>제조사</th>
                                                <td>
                                                    <form:input path="makerName"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="예: 농심"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="makerName"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="country">
                                                <th>원산지</th>
                                                <td>
                                                    <form:input path="country"
                                                                cssClass="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="예: 국내산"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="country"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="standard">
                                                <th>판매규격</th>
                                                <td>
                                                    <form:input path="standard"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="예: 250g * 30"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="standard"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="unit">
                                                <th>판매단위</th>
                                                <td>
                                                    <form:input path="unit"
                                                                cssClass="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="예: BOX/EA"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="unit"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="tax">
                                                <th class="required"><span>과세구분</span></th>
                                                <td>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="tax"
                                                                          value="1" id="tax-radio1"/>
                                                        <label class="custom-control-label" for="tax-radio1">과세</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="tax"
                                                                          value="0" id="tax-radio2"/>
                                                        <label class="custom-control-label" for="tax-radio2">면세</label>
                                                    </div>
                                                    <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                        <form:errors path="tax"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="deliveryType">
                                                <th class="required"><span>배송유형</span></th>
                                                <td>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="deliveryType"
                                                                          value="0" id="delivery_type1"/>
                                                        <label class="custom-control-label"
                                                               for="delivery_type1">전체</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="deliveryType"
                                                                          value="1" id="delivery_type2"/>
                                                        <label class="custom-control-label"
                                                               for="delivery_type2">직배송</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="deliveryType"
                                                                          value="2" id="delivery_type3"/>
                                                        <label class="custom-control-label"
                                                               for="delivery_type3">택배배송</label>
                                                    </div>
                                                    <div class="invalid-feedback ${status.error ? 'd-block': ''}">
                                                        <form:errors path="deliveryType"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="shippingMethod">
                                                <th class="required"><span>발주유형</span></th>
                                                <td>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input"
                                                                          path="shippingMethod"
                                                                          value="manual" id="shipping1"/>
                                                        <label class="custom-control-label" for="shipping1">수동
                                                            발주</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input"
                                                                          path="shippingMethod"
                                                                          value="automatic" id="shipping2"/>
                                                        <label class="custom-control-label" for="shipping2">자동
                                                            발주</label>
                                                    </div>
                                                    <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                        <form:errors path="shippingMethod"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="useDecimal">
                                                <th>수량 소수점 사용</th>
                                                <td>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="useDecimal"
                                                                          value="false" id="use_decimal1"/>
                                                        <label class="custom-control-label"
                                                               for="use_decimal1">미사용</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="useDecimal"
                                                                          value="true" id="use_decimal2"/>
                                                        <label class="custom-control-label"
                                                               for="use_decimal2">사용</label>
                                                    </div>
                                                    <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                        <form:errors path="useDecimal"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <th>상품이미지</th>
                                            <td colspan="3">
                                                <div class="dropzone" id="productImage">
                                                    <img src="<c:if test="${productForm.imageUrl != null}">${productForm.imageUrl}</c:if>"
                                                         id="img-preview" class="img-preview" alt=""/>
                                                </div>
                                                <form:hidden class="form-control" path="imageUrl" id="imageUrl"/>
                                            </td>
                                        </tr>
                                        <spring:bind path="message">
                                            <tr>
                                                <th>상품 메세지(구매 시 전달사항)</th>
                                                <td colspan="3">
                                                    <form:input path="message"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"/>
                                                    <small class="form-text">거래처 주문 화면의 해당 상품 목록에 내용이 보여집니다. (공백 포함. 최대
                                                        50자 입력 가능)</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="message"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">매입 정보</h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <tbody class="thead-light">
                                        <spring:bind path="supplier">
                                            <tr>
                                                <th>대표 매입처</th>
                                                <td>
                                                    <form:select
                                                            class="form-control ${status.error ? 'is-invalid' : ''}"
                                                            path="supplier">
                                                        <option value="">선택하세요.</option>
                                                        <form:options items="${suppliers}" itemValue="id"
                                                                      itemLabel="name"/>
                                                    </form:select>
                                                    <small class="form-text">신규 매입처 등록은 매입처 관리에서 추가할수 있습니다.<br>
                                                        <a href="/suppliers/create" class="text-primary"> 매입처 등록
                                                            바로가기</a></small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="supplier"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="buyPrice">
                                            <tr>
                                                <th>매입 단가</th>
                                                <td>
                                                    <div class="input-group">
                                                        <form:input path="buyPrice" type="number"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                    placeholder="매입단가"/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">원</span>
                                                        </div>
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="buyPrice"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">단가 정보</h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <tbody class="thead-light">
                                        <spring:bind path="directPrice">
                                            <tr>
                                                <th class="required"><span>직배송 단가</span></th>
                                                <td>
                                                    <div class="input-group">
                                                        <form:input path="directPrice" type="number"
                                                                    class="form-control price-group ${status.error ? 'is-invalid' : ''}"
                                                                    placeholder="직배송 단가" readonly="true"/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">원</span>
                                                        </div>
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="directPrice"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="parcelPrice">
                                            <tr>
                                                <th class="required"><span>택배송 단가</span></th>
                                                <td>
                                                    <div class="input-group">
                                                        <form:input path="parcelPrice" type="number"
                                                                    class="form-control price-group ${status.error ? 'is-invalid' : ''}"
                                                                    placeholder="택배배송 단가" readonly="true"/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">원</span>
                                                        </div>
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="parcelPrice"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <c:forEach items="${priceGroups}" var="priceGroup">
                                            <tr>
                                                <th>${priceGroup.name}</th>
                                                <td>
                                                    <div class="input-group">
                                                        <input class="price-group form-control" type="text" value="${productForm.buyPrice}" readonly>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">원</span>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="form-group text-center">
                                        <a href="/products" class="btn btn-outline-secondary">목록으로</a>
                                        <button class="btn btn-primary">등록하기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form:form>
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
<script src="${contextPath}/resources/dropzone-5.7.0/dropzone.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    Dropzone.autoDiscover = false;
    new Dropzone('#productImage', {
        url: '/upload',
        paramName: 'upload',
        acceptedFiles: 'image/*',
        addRemoveLinks: true,
        maxfilesexceeded: function (file) {
            this.removeAllFiles();
            this.addFile(file);
        },
        success: function (file, response) {
            $('#imageUrl').val(response.url);
            $('#img-preview').attr('src', response.url);
        },
        removedfile: function (file) {
            $('#img-preview').attr('src', '');
            var _ref;
            return (_ref = file.previewElement) != null ? _ref.parentNode.removeChild(file.previewElement) : void 0;
        },
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });

    $(document).ready(function() {
        $('#category').change(function () {
            $.ajax({
                url: '/categories/sub_categories',
                data: {
                    id: $(this).val(),
                },
                success: function(data) {
                    var subcategories = data.listdata;
                    $('#subCategory').html('<option value="">2차 카테고리</option>');
                    subcategories.forEach(function(subcategory, index) {
                        var html = '<option value=' + subcategory.id + '>' + subcategory.name + '</option>';
                        $('#subCategory').append(html);
                    });
                }
            })
        });

        $('#buyPrice').keyup(function () {
            $('.price-group').val($(this).val());
        })
    })
</script>
</body>
</html>