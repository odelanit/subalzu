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
                                <a href="/product-orders">상품별 주문 목록</a>
                            </li>
                            <li>
                                <a href="/returns">반품 내역</a>
                            </li>
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
                                <div class="card-header">
                                    <h5 class="mb-0">기본 정보</h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="erpCode">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">상품 코드</label>
                                            <div class="col-lg-10">
                                                <form:input path="erpCode" class="form-control ${status.error ? 'is-invalid': ''}" placeholder="상품코드를 입력하세요." />
                                                <small class="form-text">기존에 쓰시는 ERP 상품 코드(단축코드)를 입력하세요. 없으면 입력하지 않아도 됩니다.</small>
                                                <div class="invalid-feedback">
                                                    <form:errors path="erpCode" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <spring:bind path="name">
                                        <div class="form-group row required">
                                            <label class="col-form-label col-lg-2">상품명</label>
                                            <div class="col-lg-10">
                                                <form:input path="name" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="상품명을 입력하세요." />
                                               <div class="invalid-feedback">
                                                   <form:errors path="name" />
                                               </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <spring:bind path="category">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">카테고리</label>
                                            <div class="col-lg-10">
                                                <form:select path="category" cssClass="form-control ${status.error ? 'is-invalid' : ''}">
                                                    <option value="">선택하세요.</option>
                                                    <form:options items="${categories}" />
                                                </form:select>
                                                <div class="invalid-feedback">
                                                    <form:errors path="category" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <div class="row">
                                        <spring:bind path="makerName">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">제조사</label>
                                                    <div class="col-lg-8">
                                                        <form:input path="makerName" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="예: 농심" />
                                                        <div class="invalid-feedback">
                                                            <form:errors path="makerName" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="country">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">원산지</label>
                                                    <div class="col-lg-8">
                                                        <form:input path="country" cssClass="form-control ${status.error ? 'is-invalid' : ''}" placeholder="예: 국내산" />
                                                        <div class="invalid-feedback">
                                                            <form:errors path="country" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="row">
                                        <spring:bind path="standard">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">판매규격</label>
                                                    <div class="col-lg-8">
                                                        <form:input path="standard" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="예: 250g * 30" />
                                                        <div class="invalid-feedback">
                                                            <form:errors path="standard" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="unit">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">판매단위</label>
                                                    <div class="col-lg-8">
                                                        <form:input path="unit" cssClass="form-control ${status.error ? 'is-invalid' : ''}" placeholder="예: BOX/EA" />
                                                        <div class="invalid-feedback">
                                                            <form:errors path="unit" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="row">
                                        <spring:bind path="tax">
                                            <div class="col-lg-6">
                                                <div class="form-group row align-items-center required">
                                                    <label class="col-form-label col-lg-4">과세구분</label>
                                                    <div class="col-lg-8">
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="tax"
                                                                   value="1" id="tax-radio1" />
                                                            <label class="custom-control-label" for="tax-radio1">과세</label>
                                                        </div>
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="tax"
                                                                   value="0" id="tax-radio2" />
                                                            <label class="custom-control-label" for="tax-radio2">면세</label>
                                                        </div>
                                                        <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                            <form:errors path="tax" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="deliveryTypes">
                                            <div class="col-lg-6">
                                                <div class="form-group row align-items-center required">
                                                    <label class="col-form-label col-lg-4">배송유형</label>
                                                    <div class="col-lg-8">
                                                        <div class="custom-control custom-control-inline custom-checkbox">
                                                            <form:checkbox class="custom-control-input" path="deliveryTypes"
                                                                   value="direct" id="delivery_type1" />
                                                            <label class="custom-control-label" for="delivery_type1">직배송</label>
                                                        </div>
                                                        <div class="custom-control custom-control-inline custom-checkbox">
                                                            <form:checkbox class="custom-control-input" path="deliveryTypes"
                                                                   value="parcel" id="delivery_type2" />
                                                            <label class="custom-control-label" for="delivery_type2">택배배송</label>
                                                        </div>
                                                        <div class="invalid-feedback ${status.error ? 'd-block': ''}">
                                                            <form:errors path="deliveryTypes" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="row">
                                        <spring:bind path="shippingMethod">
                                            <div class="col-lg-6">
                                                <div class="form-group row required align-items-center">
                                                    <label class="col-form-label col-lg-4">발주유형</label>
                                                    <div class="col-lg-8">
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="shippingMethod"
                                                                              value="manual" id="shipping1" />
                                                            <label class="custom-control-label" for="shipping1">수동 발주</label>
                                                        </div>
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="shippingMethod"
                                                                              value="automatic" id="shipping2" />
                                                            <label class="custom-control-label" for="shipping2">자동 발주</label>
                                                        </div>
                                                        <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                            <form:errors path="shippingMethod" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="useDecimal">
                                            <div class="col-lg-6">
                                                <div class="form-group row required align-items-center">
                                                    <label class="col-form-label col-lg-4">수량 소수점 사용</label>
                                                    <div class="col-lg-8">
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="useDecimal"
                                                                   value="false" id="use_decimal1" />
                                                            <label class="custom-control-label" for="use_decimal1">미사용</label>
                                                        </div>
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="useDecimal"
                                                                   value="true" id="use_decimal2" />
                                                            <label class="custom-control-label" for="use_decimal2">사용</label>
                                                        </div>
                                                        <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                            <form:errors path="useDecimal" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">상품이미지</label>
                                        <div class="col-lg-10">
                                            <div class="dropzone" id="productImage">
                                                <img src="" id="img-preview" class="img-preview" alt="" />
                                            </div>
                                            <form:input class="form-control" path="imageUrl" id="imageUrl" />
                                        </div>
                                    </div>
                                    <spring:bind path="message">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">상품 메세지(구매 시 전달사항)</label>
                                            <div class="col-lg-10">
                                                <form:input path="message" class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                <small class="form-text">거래처 주문 화면의 해당 상품 목록에 내용이 보여집니다. (공백 포함. 최대 50자 입력 가능)</small>
                                                <div class="invalid-feedback">
                                                    <form:errors path="message" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">매입 정보</h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="supplier">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">대표 매입처</label>
                                            <div class="col-lg-10">
                                                <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="supplier">
                                                    <option value="">선택하세요.</option>
                                                    <form:options items="${categories}" />
                                                </form:select>
                                                <small class="form-text">신규 매입처 등록은 매입처 관리에서 추가할수 있습니다.<br> <a
                                                        href="/suppliers/create"> 매입처 등록 바로가기</a></small>
                                                <div class="invalid-feedback">
                                                    <form:errors path="supplier" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <spring:bind path="buyPrice">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">매입 단가</label>
                                            <div class="col-lg-10">
                                                <div class="input-group">
                                                    <form:input path="buyPrice" type="number" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="매입단가" />
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                                <div class="invalid-feedback">
                                                    <form:errors path="buyPrice" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="mb-0">단가 정보</h6>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="directPrice">
                                        <div class="form-group row required">
                                            <label class="col-form-label col-lg-2">직배송 단가</label>
                                            <div class="col-lg-10">
                                                <div class="input-group">
                                                    <form:input path="directPrice" type="number" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="직배송 단가" />
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                                <div class="invalid-feedback">
                                                    <form:errors path="directPrice" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <spring:bind path="parcelPrice">
                                        <div class="form-group row required">
                                            <label class="col-form-label col-lg-2">택배송 단가</label>
                                            <div class="col-lg-10">
                                                <div class="input-group">
                                                    <form:input path="parcelPrice" type="number" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="택배배송 단가" />
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                                <div class="invalid-feedback">
                                                    <form:errors path="parcelPrice" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <div class="form-group row">
                                        <div class="col-lg-10 offset-lg-2">
                                            <a href="/products" class="btn btn-outline-secondary">목록으로</a>
                                            <button class="btn btn-primary">등록하기</button>
                                        </div>
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
</script>
</body>
</html>