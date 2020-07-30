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
                                <div class="card-body">
                                    <h5 class="card-title">
                                        거래처 정보
                                        <span class="font-size-12 float-right"><span class="text-danger">*</span>필수 입력사항입니다.</span>
                                    </h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <colgroup>
                                            <col style="width: 15%;">
                                            <col style="width: 35%;">
                                            <col style="width: 15%;">
                                            <col style="width: 35%;">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <spring:bind path="erpCode">
                                            <tr>
                                                <th>거래처 코드</th>
                                                <td colspan="3">
                                                    <form:input class="form-control w-75 ${status.error ? 'is-invalid' : ''}" path="erpCode" placeholder="거래처 코드를 입력하세요." />
                                                    <small class="form-text">기존에 쓰시는 ERP거래처 코드(단축코드)를 입력하세요. 없으면 입력하지 않아도 됩니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="erpCode" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <tr>
                                            <spring:bind path="name">
                                                <th class="required"><span>거래처명</span></th>
                                                <td>
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="name" placeholder="거래처명" />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="name" />
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="business">
                                                <th class="required"><span>거래처 업종</span></th>
                                                <td>
                                                    <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="business">
                                                        <option value="">--선택--</option>
                                                        <form:options items="${businesses}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="business" />
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <th class="required"><span>배송지</span></th>
                                            <td colspan="3">
                                                <spring:bind path="zipCode">
                                                    <div class="input-group w-75">
                                                        <form:input path="zipCode" id="business_addr_zip" readonly="true" class="form-control ${status.error ? 'is-invalid' : ''}" />
                                                        <div class="input-group-append">
                                                            <button type="button" class="btn btn-outline-primary" id="zip_search">주소 검색</button>
                                                        </div>
                                                    </div>
                                                </spring:bind>
                                                <spring:bind path="addressLine1">
                                                    <form:input path="addressLine1" id="business_address1" readonly="true" class="form-control w-75 ${status.error ? 'is-invalid' : ''} mt-2" placeholder="주소를 입력해주세요." />
                                                </spring:bind>
                                                <spring:bind path="addressLine2">
                                                    <form:input path="addressLine2" id="business_address2" class="form-control w-75 ${status.error ? 'is-invalid' : ''} mt-2" placeholder="상세주소를 입력해주세요." />
                                                </spring:bind>
                                            </td>
                                        </tr>
                                        <spring:bind path="deliveryType">
                                            <tr>
                                                <th class="required"><span>배송 유형</span></th>
                                                <td colspan="3">
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="deliveryType" value="0" id="delivery_type1" />
                                                        <label class="custom-control-label" for="delivery_type1">전체</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="deliveryType" value="1" id="delivery_type2" />
                                                        <label class="custom-control-label" for="delivery_type2">직배송</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="deliveryType" value="2" id="delivery_type3" />
                                                        <label class="custom-control-label" for="delivery_type3">택배배송</label>
                                                    </div>
                                                    <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                        <form:errors path="deliveryType" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <tr>
                                            <spring:bind path="fax">
                                                <th>FAX 번호</th>
                                                <td>
                                                    <form:input path="fax" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="FAX번호를 입력해주세요." />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="fax" />
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="email">
                                                <th>이메일</th>
                                                <td>
                                                    <form:input path="email" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="abc@naver.com" />
                                                    <small class="form-text">거래처의 이메일 정보를 입력해두시면, 이메일로 거래명세표 등을 발송할수 있습니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="email" />
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="ownerUsername">
                                                <th class="required"><span>거래처 연락처(아이디)</span></th>
                                                <td>
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="ownerUsername" id="shopTel" placeholder="전화번호 또는 휴대폰 번호" />
                                                    <small class="form-text text-primary">거래처 연락처가 아이디로 생성됩니다.</small>
                                                    <small id="chk_msg" style="display:none;"></small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="ownerUsername" />
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <th class="required"><span>거래처 아이디/비밀번호</span></th>
                                            <td>
                                                <div class="d-flex">
                                                    <label style="width: 150px;">아이디</label>
                                                    <input class="form-control" type="text" readonly id="user_account">
                                                </div>
                                                <div class="d-flex mt-2">
                                                    <label style="width: 150px;">임시 비밀번호</label>
                                                    <input class="form-control" type="text" readonly id="user_password">
                                                </div>
                                                <div class="d-flex">
                                                    <small class="form-text">최초 로그인을 위한 임시 비밀번호입니다.</small>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th class="required"><span>거래처 담당자/휴대전화 번호</span></th>
                                            <td colspan="3">
                                                <spring:bind path="ownerFullname">
                                                    <div class="d-flex">
                                                        <label style="width: 150px;">담당자 명</label>
                                                        <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="ownerFullname" placeholder="담당자명을 입력해 주세요." />
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="ownerFullname" />
                                                    </div>
                                                </spring:bind>
                                                <spring:bind path="ownerPhone">
                                                    <div class="d-flex mt-2">
                                                        <label style="width: 150px;">휴대전화 번호</label>
                                                        <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="ownerPhone" placeholder="숫자만 입력해주세요." />
                                                    </div>
                                                    <small class="form-text">거래처 담당자 휴대전화 번호로 아이디와 비밀번호가 자동 발송됩니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="ownerPhone" />
                                                    </div>
                                                </spring:bind>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">
                                        배송/영업 담당자 정보
                                        <span class="font-size-12 float-right"><span class="text-danger">*</span>필수 입력사항입니다.</span>
                                    </h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <colgroup>
                                            <col style="width: 15%;">
                                            <col style="width: 35%;">
                                            <col style="width: 15%;">
                                            <col style="width: 35%;">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <spring:bind path="deliverer">
                                                <th class="required"><span>배송 담당자</span></th>
                                                <td>
                                                    <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="deliverer" id="select_deliverer">
                                                        <option value="">-- 선택 --</option>
                                                        <c:forEach items="${deliverers}" var="deliverer">
                                                            <option value="${deliverer.id}" data-phone="${deliverer.phone}" <c:if test="${shopForm.deliverer.id == deliverer.id}">selected</c:if>>${deliverer.fullName}</option>
                                                        </c:forEach>
                                                    </form:select>
                                                    <small class="form-text">선택한 담당자에게 배송관련 문자를 전송합니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="deliverer" />
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <th>휴대전화 번호</th>
                                            <td>
                                                <input id="delivery_phone" type="tel" class="form-control" value="${shopForm.deliverer.phone}" readonly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <spring:bind path="salesman">
                                                <th>영업 담당자</th>
                                                <td>
                                                    <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="salesman" id="select_salesman">
                                                        <option value="">-- 선택 --</option>
                                                        <c:forEach items="${salesMans}" var="salesman">
                                                            <option value="${salesman.id}" data-phone="${salesman.phone}" <c:if test="${shopForm.salesman.id == salesman.id}">selected</c:if>>${salesman.fullName}</option>
                                                        </c:forEach>
                                                    </form:select>
                                                    <small class="form-text">선택한 담당자에게 배송관련 문자를 전송합니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="salesman" />
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <th>휴대전화 번호</th>
                                            <td>
                                                <input id="salesman_phone" type="tel" class="form-control" readonly value="${shopForm.salesman.phone}">
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">
                                        단가 그룹
                                        <span class="font-size-12 float-right">거래처에서 선택된 단가속성의 금액으로 물건을 주문할수 있습니다.</span>
                                    </h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <colgroup>
                                            <col style="width: 15%;">
                                            <col style="width: 85%;">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <spring:bind path="priceGroup">
                                            <tr>
                                                <th>단가 그룹 선택</th>
                                                <td>
                                                    <form:select class="form-control ${status.error ? 'is-invalid' : ''}" path="priceGroup">
                                                        <option value="">-- 선택 --</option>
                                                        <form:options items="${priceGroups}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                    <small class="form-text">* 단가 그룹은 단가 관리 > [단가 그룹 관리]에서 등록할수 있습니다.</small>
                                                    <small class="form-text">* 단가 그룹의 금액은 상품관리 페이지에서 상품별로 입력해주셔야 합니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="priceGroup" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">
                                        할인/할증율 등급
                                        <span class="font-size-12 float-right">거래처에서 등급별 할인된 가격으로 상품 구매가 가능합니다.</span>
                                    </h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <colgroup>
                                            <col style="width: 15%;">
                                            <col style="width: 85%;">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <spring:bind path="shopGrade">
                                            <tr>
                                                <th>할인/할증율 등급 선택</th>
                                                <td>
                                                    <form:select class="form-control" path="shopGrade">
                                                        <option value="">-- 선택 --</option>
                                                        <form:options items="${shopGrades}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                    <small class="form-text">* 등록 거래처 목록 > [할인율 등급 관리]에서 할인율 등급을 등록할수 있습니다.</small>
                                                    <small class="form-text">* 단가 그룹을 선택한 경우 단가 그룹 금액에 할인/할증율이 적용됩니다.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="shopGrade" />
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">
                                        결제수단 설정
                                        <span class="font-size-12 float-right">거래처에서 주문시, 설정된 결제수단으로 결제할수 있습니다.</span>
                                    </h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <colgroup>
                                            <col style="width: 15%;">
                                            <col style="width: 85%;">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <spring:bind path="paymentMethod">
                                            <tr>
                                                <th>결제수단</th>
                                                <td>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" value="credit" path="paymentMethod" id="payment_method1" />
                                                        <label class="custom-control-label" for="payment_method1">외상 거래</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" value="prepaid" path="paymentMethod" id="payment_method2" />
                                                        <label class="custom-control-label" for="payment_method2">예치금</label>
                                                    </div>
                                                    <small class="form-text">
                                                        * '외상거래'와 '예치금'은 둘 중 하나만 사용 선택 가능합니다.
                                                    </small>
                                                    <small class="form-text">
                                                        * 외상거래의 잔액 결제, 예치금 충전은 거래처가 가상계좌 또는 신용카드로 결제후 청산됩니다.
                                                    </small>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <div class="collapse ${shopForm.paymentMethod == 'credit' ? 'show' : ''}" id="credit_setting">
                                        <h5 class="card-title">
                                            외상잔액 한도 설정
                                        </h5>
                                        <table class="table table-bordered form-table mb-5">
                                            <colgroup>
                                                <col style="width: 15%;">
                                                <col style="width: 85%;">
                                            </colgroup>
                                            <tbody class="thead-light">
                                            <spring:bind path="isCreditBalanceLimit">
                                                <tr>
                                                    <th>외상잔액 한도 설정 여부</th>
                                                    <td>
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
                                                    </td>
                                                </tr>
                                            </spring:bind>
                                            <spring:bind path="creditBalanceLimit">
                                                <tr class="${shopForm.isCreditBalanceLimit ? '' : 'd-none'}" id="credit_balance_form_group">
                                                    <th>외상잔액 한도 금액</th>
                                                    <td>
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
                                                    </td>
                                                </tr>
                                            </spring:bind>
                                            </tbody>
                                        </table>
                                    </div>
                                    <h5 class="card-title">
                                        수입물품 유통이력 정보
                                        <span class="font-size-12 float-right"></span>
                                    </h5>
                                    <table class="table table-bordered form-table mb-5">
                                        <colgroup>
                                            <col style="width: 15%;">
                                            <col style="width: 35%;">
                                            <col style="width: 15%;">
                                            <col style="width: 35%;">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <spring:bind path="businessLicense">
                                                <th>사업자 등록증 보유 유무</th>
                                                <td>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="businessLicense" value="true" id="certificate1" />
                                                        <label class="custom-control-label" for="certificate1">유</label>
                                                    </div>
                                                    <div class="custom-control custom-control-inline custom-radio">
                                                        <form:radiobutton class="custom-control-input" path="businessLicense" value="false" id="certificate2" />
                                                        <label class="custom-control-label" for="certificate2">무</label>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="assigneeType">
                                                <th>양수자 유형</th>
                                                <td>
                                                    <form:select class="form-control" path="assigneeType">
                                                        <form:options items="${assigneeTypes}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div class="form-group text-center">
                                        <a href="/shops" class="btn btn-secondary">목록으로</a>
                                        <button class="btn btn-primary">등록하기</button>
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
<!-- END wrapper -->
<div class="modal fade" id="success_message">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-light">거래처 등록 완료</h5>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body p-5">
                <h4 class="text-center mb-5">거래처 등록이 완료되었습니다.</h4>
                <table class="table table-bordered">
                    <colgroup>
                        <col style="width: 35%">
                        <col>
                    </colgroup>
                    <tbody class="thead-light">
                    <tr>
                        <th>거래처명</th>
                        <td>${shopForm.name}</td>
                    </tr>
                    <tr>
                        <th>거래처 연락처(아이디)</th>
                        <td>${shopForm.shopOwner.username}</td>
                    </tr>
                    <tr>
                        <th>임시 비밀번호</th>
                        <td>${shopForm.shopOwner.username}</td>
                    </tr>
                    <tr>
                        <th>거래처 담당자</th>
                        <td>${shopForm.ownerFullname}</td>
                    </tr>
                    <tr>
                        <th>담당자 휴대전화 번호</th>
                        <td>${shopForm.ownerPhone}</td>
                    </tr>
                    </tbody>
                </table>
                <p class="text-primary">* [확인]을 누르시면, 거래처 담당자 휴대전화로 아이디와 임시 비밀번호가 발송됩니다.</p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
                <button class="btn btn-primary" onclick="window.location.href='/shops'">확인</button>
            </div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    $("#zip_search, #zip_search2").click(function(e){

        var zipcode = "business_addr_zip";
        var addr1 = "business_address1";
        var addr2 = "business_address2";

        //본점 소재지의 경우
        // if($(this).attr("addr_type") == "2"){
        //     zipcode = "hq_addr_zip";
        //     addr1 = "hq_address1";
        //     addr2 = "hq_address2";
        // }

        var width = 500;	//팝업의 너비
        var height = 600;	//팝업의 높이

        new daum.Postcode({
            width: width,
            height: height,
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                if(data.postcode1 == ""){
                    document.getElementById(zipcode).value = data.zonecode;
                }
                else{
                    document.getElementById(zipcode).value = data.postcode1+"-"+data.postcode2;
                }

                if(data.userSelectedType == "R"){
                    document.getElementById(addr1).value = fullAddr;
                }
                else{
                    document.getElementById(addr1).value = data.jibunAddress;
                }
            }
        }).open({
            left: (window.screen.width / 2) - (width / 2),
            top: (window.screen.height / 2) - (height / 2)
        });
    });

    $('input[name="isCreditBalanceLimit"]').on('change', function() {
        if ($(this).val() === 'true') {
            $('#credit_balance_form_group').removeClass('d-none');
        } else {
            $('#credit_balance_form_group').addClass('d-none');
        }
    });

    $('input[name="paymentMethod"]').change(function () {
        if ($(this).val() === 'credit') {
            $('#credit_setting').collapse('show');
        } else {
            $('#credit_setting').collapse('hide');
        }
    })

    //거래처 연락처 입력 시 자동 ID,PW 생성
    $("#shopTel").keyup(function(){
        var user_account = $("#user_account");
        var user_password = $("#user_password");
        var token = $("meta[name='_csrf']").attr("content");

        $(this).val($(this).val().replace(/[^-0-9]/gi,''));

        var shop_tel = $(this).val().replace(/-/g, "");

        if(shop_tel.length >= 8){
            //결제내역 정보 추출
            $.ajax({
                type: 'POST',
                url: '/customers/check_username',
                headers: {
                    'X-CSRF-TOKEN': token
                },
                data: {
                    username: $(this).val(),
                },
                success: function(data) {
                    $("#chk_msg").hide();
                    $("#chk_msg").text("");
                    user_account.val(shop_tel);
                    user_password.val(shop_tel);
                },
                error: function (xhr, statusCode, error) {
                    $("#chk_msg").show();
                    $("#chk_msg").css("color","red");
                    $("#chk_msg").text("* 이미 등록된 거래처입니다.");
                    user_account.val("");
                    user_password.val("");
                }
            });
        }
        else{
            user_account.val("");
            user_password.val("");
        }
    });

    $('#select_deliverer').change(function () {
        var phone = $(this).find(':selected').data('phone');
        $('#delivery_phone').val(phone);
    });

    $('#select_salesman').change(function () {
        var phone = $(this).find(':selected').data('phone');
        $('#salesman_phone').val(phone);
    });

    $(document).ready(function () {
        <c:if test="${success == true}">
        $('#success_message').modal();
        </c:if>
    })
</script>
</body>
</html>