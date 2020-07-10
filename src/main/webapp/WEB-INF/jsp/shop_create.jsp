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
                <a href="javascript:;" class="nav-link" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
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
                <img src="${contextPath}/resources/images/logo_dark.svg" alt="logo" height="40" class="logo-icon" />
                <img src="${contextPath}/resources/images/logo_pando_dark.svg" alt="logo" height="40" class="logo-full" />
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
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 거래처 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item"><a href="/shops">거래처 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">거래처 등록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">거래처 등록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <form:form modelAttribute="shopForm" method="post">
                            <spring:bind path="id">
                                <form:hidden path="id" />
                            </spring:bind>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        거래처 정보
                                        <span class="font-size-12 float-right"><span class="text-danger">*</span>필수 입력사항입니다.</span>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="erpCode">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">거래처 코드</label>
                                            <div class="col-lg-10">
                                                <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="erpCode" placeholder="거래처 코드를 입력하세요." />
                                                <small class="form-text">기존에 쓰시는 ERP거래처 코드(단축코드)를 입력하세요. 없으면 입력하지 않아도 됩니다.</small>
                                                <div class="invalid-feedback">
                                                    <form:errors path="erpCode" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <div class="row">
                                        <spring:bind path="name">
                                            <div class="col-lg-6">
                                                <div class="form-group row required">
                                                    <label class="col-form-label col-lg-4">거래처명</label>
                                                    <div class="col-lg-8">
                                                        <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="name" placeholder="거래처명" />
                                                        <div class="invalid-feedback">
                                                            <form:errors path="name" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="business">
                                            <div class="col-lg-6">
                                                <div class="form-group row required">
                                                    <label class="col-form-label col-lg-2">거래처 업종</label>
                                                    <div class="col-lg-10">
                                                        <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="business">
                                                            <option value="">--선택--</option>
                                                            <form:options items="${businesses}" itemValue="id" itemLabel="name" />
                                                        </form:select>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="business" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="form-group row required align-items-center">
                                        <label class="col-form-label col-lg-2">배송지</label>
                                        <div class="col-lg-10">
                                            <spring:bind path="zipCode">
                                                <div class="input-group">
                                                    <form:input path="zipCode" class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                    <div class="input-group-append">
                                                        <button class="btn btn-outline-primary">주소 검색</button>
                                                    </div>
                                                </div>
                                            </spring:bind>
                                            <spring:bind path="addressLine1">
                                                <form:input path="addressLine1" class="form-control ${status.error ? 'is-invalid' : ''} mt-2" placeholder="주소를 입력해주세요." />
                                            </spring:bind>
                                            <spring:bind path="addressLine2">
                                                <form:input path="addressLine2" class="form-control ${status.error ? 'is-invalid' : ''} mt-2" placeholder="상세주소를 입력해주세요." />
                                            </spring:bind>
                                        </div>
                                    </div>
                                    <spring:bind path="deliveryTypes">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">배송 유형</label>
                                            <div class="col-lg-10">
                                                <div class="custom-control custom-control-inline custom-checkbox">
                                                    <form:checkbox class="custom-control-input" path="deliveryTypes" value="direct" id="delivery_type2" />
                                                    <label class="custom-control-label" for="delivery_type2">직배송</label>
                                                </div>
                                                <div class="custom-control custom-control-inline custom-checkbox">
                                                    <form:checkbox class="custom-control-input" path="deliveryTypes" value="parcel" id="delivery_type3" />
                                                    <label class="custom-control-label" for="delivery_type3">택배배송</label>
                                                </div>
                                                <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                    <form:errors path="deliveryTypes" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <div class="row">
                                        <spring:bind path="fax">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">FAX 번호</label>
                                                    <div class="col-lg-8">
                                                        <form:input path="fax" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="FAX번호를 입력해주세요." />
                                                        <div class="invalid-feedback">
                                                            <form:errors path="fax" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="email">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">이메일</label>
                                                    <div class="col-lg-8">
                                                        <form:input path="email" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="abc@naver.com" />
                                                        <small class="form-text">거래처의 이메일 정보를 입력해두시면, 이메일로 거래명세표 등을 발송할수 있습니다.</small>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="email" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                    <div class="row">
                                        <spring:bind path="shopTel">
                                            <div class="col-lg-6">
                                                <div class="form-group row required">
                                                    <label class="col-form-label col-lg-4">거래처 연락처(아이디)</label>
                                                    <div class="col-lg-8">
                                                        <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="shopTel" placeholder="전화번호 또는 휴대폰 번호" />
                                                        <small class="form-text">거래처 연락처가 아이디로 생성됩니다.</small>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="shopTel" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <div class="col-lg-6">
                                            <div class="form-group row required">
                                                <label class="col-form-label col-lg-4">거래처 아이디/비밀번호</label>
                                                <div class="col-lg-8">
                                                    <div class="d-flex">
                                                        <label style="width: 150px;">아이디</label>
                                                        <input class="form-control" type="text" readonly>
                                                    </div>
                                                    <div class="d-flex mt-2">
                                                        <label style="width: 150px;">임시 비밀번호</label>
                                                        <input class="form-control" type="password" readonly>
                                                    </div>
                                                    <div class="d-flex">
                                                        <label style="width: 150px;"></label>
                                                        <small class="form-text">최초 로그인을 위한 임시 비밀번호입니다.</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group row required">
                                                <label class="col-form-label col-lg-4">거래처 담당자/휴대전화 번호</label>
                                                <div class="col-lg-8">
                                                    <spring:bind path="contactName">
                                                        <div class="d-flex">
                                                            <label style="width: 150px;">담당자 명</label>
                                                            <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="contactName" placeholder="담당자명을 입력해 주세요." />
                                                        </div>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="contactName" />
                                                        </div>
                                                    </spring:bind>
                                                    <spring:bind path="contactPhone">
                                                        <div class="d-flex mt-2">
                                                            <label style="width: 150px;">휴대전화 번호</label>
                                                            <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="contactPhone" placeholder="숫자만 입력해주세요." />
                                                        </div>
                                                        <small class="form-text">거래처 담당자 휴대전화 번호로 아이디와 비밀번호가 자동 발송됩니다.</small>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="contactPhone" />
                                                        </div>
                                                    </spring:bind>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        배송/영업 담당자 정보
                                        <span class="font-size-12 float-right"><span class="text-danger">*</span>필수 입력사항입니다.</span>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <spring:bind path="deliverer">
                                            <div class="col-lg-6">
                                                <div class="form-group row required">
                                                    <label class="col-form-label col-lg-4">배송 담당자</label>
                                                    <div class="col-lg-8">
                                                        <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="deliverer">
                                                            <option value="">-- 선택 --</option>
                                                            <form:options items="${deliverers}" itemValue="id" itemLabel="fullName" />
                                                        </form:select>
                                                        <small class="form-text">선택한 담당자에게 배송관련 문자를 전송합니다.</small>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="deliverer" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">휴대전화 번호</label>
                                                <div class="col-lg-8">
                                                    <input type="tel" class="form-control" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <spring:bind path="salesMan">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">영업 담당자</label>
                                                    <div class="col-lg-8">
                                                        <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="salesMan">
                                                            <option value="">-- 선택 --</option>
                                                            <form:options items="${salesMans}" itemValue="id" itemLabel="fullName" />
                                                        </form:select>
                                                        <small class="form-text">선택한 담당자에게 배송관련 문자를 전송합니다.</small>
                                                        <div class="invalid-feedback">
                                                            <form:errors path="salesMan" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">휴대전화 번호</label>
                                                <div class="col-lg-8">
                                                    <input type="tel" class="form-control" readonly>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        단가 그룹
                                        <span class="font-size-12 float-right">거래처에서 선택된 단가속성의 금액으로 물건을 주문할수 있습니다.</span>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="priceGroup">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">단가 그룹 선택</label>
                                            <div class="col-lg-10">
                                                <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="priceGroup">
                                                    <option value="">-- 선택 --</option>
                                                    <form:options items="${priceGroups}" itemValue="id" itemLabel="name" />
                                                </form:select>
                                                <small class="form-text">* 단가 그룹은 단가 관리 > [단가 그룹 관리]에서 등록할수 있습니다.</small>
                                                <small class="form-text">* 단가 그룹의 금액은 상품관리 페이지에서 상품별로 입력해주셔야 합니다.</small>
                                                <div class="invalid-feedback">
                                                    <form:errors path="priceGroup" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        할인/할증율 등급
                                        <span class="font-size-12 float-right">거래처에서 등급별 할인된 가격으로 상품 구매가 가능합니다.</span>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="shopGrade">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">할인/할증율 등급 선택</label>
                                            <div class="col-lg-10">
                                                <form:select class="form-control" path="shopGrade">
                                                    <option value="">-- 선택 --</option>
                                                    <form:options items="${shopGrades}" itemValue="id" itemLabel="name" />
                                                </form:select>
                                                <small class="form-text">* 등록 거래처 목록 > [할인율 등급 관리]에서 할인율 등급을 등록할수 있습니다.</small>
                                                <small class="form-text">* 단가 그룹을 선택한 경우 단가 그룹 금액에 할인/할증율이 적용됩니다.</small>
                                                <div class="invalid-feedback">
                                                    <form:errors path="shopGrade" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        결제수단 설정
                                        <span class="font-size-12 float-right">거래처에서 주문시, 설정된 결제수단으로 결제할수 있습니다.</span>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="paymentMethod">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-2">결제수단</label>
                                            <div class="col-lg-10">
                                                <div class="custom-control custom-control-inline custom-radio">
                                                    <form:radiobutton class="custom-control-input" value="credit" path="paymentMethod" id="payment_method1" />
                                                    <label class="custom-control-label" for="payment_method1">외상 거래</label>
                                                </div>
                                                <div class="custom-control custom-control-inline custom-radio">
                                                    <form:radiobutton class="custom-control-input" value="prepaid" path="paymentMethod" id="payment_method2" />
                                                    <label class="custom-control-label" for="payment_method2">예치금</label>
                                                </div>
                                                <small class="form-text">
                                                    * '외상거래'와 '예치금'은 둘 중 하나만 사용 선택 가능합니다. (신용카드는 중복 선택 가능)
                                                </small>
                                                <small class="form-text">
                                                    * 외상거래의 잔액 결제, 예치금 충전은 거래처가 가상계좌 또는 신용카드로 결제후 청산됩니다.
                                                </small>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        외상잔액 한도 설정
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <spring:bind path="isCreditBalanceLimit">
                                        <div class="form-group row align-items-center">
                                            <label class="col-form-label col-lg-2">외상잔액 한도 설정 여부</label>
                                            <div class="col-lg-10">
                                                <div class="custom-control custom-control-inline custom-radio">
                                                    <form:radiobutton class="custom-control-input" path="isCreditBalanceLimit" value="false" id="limit_setting1" />
                                                    <label class="custom-control-label" for="limit_setting1">비설정</label>
                                                </div>
                                                <div class="custom-control custom-control-inline custom-radio">
                                                    <form:radiobutton class="custom-control-input" path="isCreditBalanceLimit" value="true" id="limit_setting2" />
                                                    <label class="custom-control-label" for="limit_setting2">설정</label>
                                                </div>
                                                <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                    <form:errors path="isCreditBalanceLimit" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <spring:bind path="creditBalanceLimit">
                                        <div class="form-group row d-none" id="credit_balance_form_group">
                                            <label class="col-form-label col-lg-2">외상잔액 한도 금액</label>
                                            <div class="col-lg-10">
                                                <div class="input-group">
                                                    <form:input type="number" class="form-control ${status.error ? 'is-invalid' : ''}" path="creditBalanceLimit" />
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">원</span>
                                                    </div>
                                                </div>
                                                <small class="form-text">거래처에서 외상잔액 한도 초과시, 더 이상 주문이 불가능합니다.</small>
                                                <div class="invalid-feedback">
                                                    <form:errors path="creditBalanceLimit" />
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        수입물품 유통이력 정보
                                        <span class="font-size-12 float-right"></span>
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <spring:bind path="businessLicense">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">사업자 등록증 보유 유무</label>
                                                    <div class="col-lg-8">
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="businessLicense" value="true" id="certificate1" />
                                                            <label class="custom-control-label" for="certificate1">유</label>
                                                        </div>
                                                        <div class="custom-control custom-control-inline custom-radio">
                                                            <form:radiobutton class="custom-control-input" path="businessLicense" value="false" id="certificate2" />
                                                            <label class="custom-control-label" for="certificate2">무</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                        <spring:bind path="assigneeType">
                                            <div class="col-lg-6">
                                                <div class="form-group row">
                                                    <label class="col-form-label col-lg-4">양수자 유형</label>
                                                    <div class="col-lg-8">
                                                        <form:select class="form-control" path="assigneeType">
                                                            <form:options items="${assigneeTypes}" itemValue="id" itemLabel="name" />
                                                        </form:select>
                                                    </div>
                                                </div>
                                            </div>
                                        </spring:bind>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <a href="/shops" class="btn btn-secondary">목록으로</a>
                                <button class="btn btn-primary">등록하기</button>
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
<!-- END wrapper -->

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $('input[name="isCreditBalanceLimit"]').on('change', function() {
        if ($(this).val() === 'true') {
            $('#credit_balance_form_group').removeClass('d-none');
        } else {
            $('#credit_balance_form_group').addClass('d-none');
        }
    })
</script>
</body>
</html>