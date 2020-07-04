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
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
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
                    <i data-feather="menu" class="menu-icon"></i>
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
                <a href="/clients/create" class="nav-link">거래처 등록</a>
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
        <div class="media user-profile mt-2 mb-2">
            <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-sm rounded-circle mr-2"
                 alt="Pando"/>
            <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-xs rounded-circle mr-2"
                 alt="Pando"/>

            <div class="media-body">
                <a href="/company">
                    <h6 class="pro-user-name mt-0 mb-0">Nik Patel</h6>
                    <span class="pro-user-desc">기업정보보기</span>
                </a>
            </div>
        </div>
        <div class="sidebar-content">
            <!--- Sidemenu -->
            <div id="sidebar-menu" class="slimscroll-menu">
                <ul class="metismenu" id="menu-bar">
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
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
                            <li>
                                <a href="/order-setting">주문 설정</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
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
                            <i data-feather="list"></i>
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
                            <i data-feather="list"></i>
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
                            <i data-feather="list"></i>
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
                            <li>
                                <a href="#">구역 관리</a>
                            </li>
                        </ul>
                    </li>
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
                            <span> 거래처 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
                                <a href="/clients">거래처 목록</a>
                            </li>
                            <li>
                                <a href="/credits">외상잔액/예치금 관리</a>
                            </li>
                            <li>
                                <a href="/payment-methods">결제수단 관리</a>
                            </li>
                            <li>
                                <a href="/credit-limit">외상잔액 한도 관리</a>
                            </li>
                            <li>
                                <a href="/estimate-sheets">견적서 관리</a>
                            </li>
                            <li>
                                <a href="#">간편 가입 신청 목록</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
                            <span> 브랜드 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="#">Inbox</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
                            <span> 원장 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="#">Inbox</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
                            <span> 통계 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="#">Inbox</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
                            <span> 회계 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="#">Inbox</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
                            <span> 서비스 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/notifications">공지사항</a>
                            </li>
                            <li>
                                <a href="#">고객문의</a>
                            </li>
                            <li>
                                <a href="#">자주하는 질문 FAQ</a>
                            </li>
                            <li>
                                <a href="/users">직원 관리</a>
                            </li>
                            <li>
                                <a href="#">문자 관리</a>
                            </li>
                            <li>
                                <a href="#">문자 발송 내역</a>
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
                                <li class="breadcrumb-item"><a href="/clients">거래처 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">거래처 등록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">거래처 등록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <%--@elvariable id="clientForm" type="com.pando.subalzu.model.Client"--%>
                        <form:form modelAttribute="clientForm" method="post">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="header-title">
                                        거래처 정보
                                        <span class="font-size-12 float-right"><span class="text-danger">*</span>필수 입력사항입니다.</span>
                                    </h5>
                                    <hr>
                                    <div class="form-group row">
                                        <label class="col-form-label col-2">거래처 코드</label>
                                        <div class="col-10">
                                            <input class="form-control" type="text" placeholder="거래처 코드를 입력하세요.">
                                            <span class="form-text">기존에 쓰시는 ERP거래처 코드(단축코드)를 입력하세요. 없으면 입력하지 않아도 됩니다.</span>
                                        </div>
                                    </div>
                                    <div class="form-group row required">
                                        <label class="col-form-label col-2">거래처명</label>
                                        <div class="col-10">
                                            <input class="form-control" type="text" placeholder="거래처명">
                                        </div>
                                    </div>
                                    <div class="form-group row required">
                                        <label class="col-form-label col-2">거래처 업종</label>
                                        <div class="col-10">
                                            <select class="form-control">
                                                <option value="">--선택--</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-2">브랜드 선택</label>
                                        <div class="col-10">
                                            <select class="form-control">
                                                <option value="">--선택--</option>
                                            </select>
                                            <span class="form-text">해당하는 브랜드가 있을 시, 선택해 주세요.</span>
                                        </div>
                                    </div>
                                    <div class="form-group row required align-items-center">
                                        <label class="col-form-label col-2">배송지</label>
                                        <div class="col-10">
                                            <div class="input-group">
                                                <input class="form-control" type="text" readonly>
                                                <div class="input-group-append">
                                                    <button class="btn btn-outline-primary">주소 검색</button>
                                                </div>
                                            </div>
                                            <input class="form-control mt-2" readonly type="text" placeholder="주소를 입력해주세요.">
                                            <input class="form-control mt-2" type="text" placeholder="상세주소를 입력해주세요.">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-2">배송 유형</label>
                                        <div class="col-10">
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="delivery_type" id="delivery_type1">
                                                <label class="custom-control-label" for="delivery_type1">전체</label>
                                            </div>
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="delivery_type" id="delivery_type2">
                                                <label class="custom-control-label" for="delivery_type2">직배송</label>
                                            </div>
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="delivery_type" id="delivery_type3">
                                                <label class="custom-control-label" for="delivery_type3">택배배송</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-2">FAX 번호</label>
                                        <div class="col-10">
                                            <input type="text" class="form-control" placeholder="FAX번호를 입력해주세요.">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-2">이메일</label>
                                        <div class="col-10">
                                            <input type="email" class="form-control" placeholder="abc@naver.com">
                                            <span class="form-text">거래처의 이메일 정보를 입력해두시면, 이메일로 거래명세표 등을 발송할수 있습니다.</span>
                                        </div>
                                    </div>
                                    <div class="form-group row required">
                                        <label class="col-form-label col-2">거래처 연락처(아이디)</label>
                                        <div class="col-10">
                                            <input class="form-control" type="text" placeholder="전화번호 또는 휴대폰 번호">
                                            <span class="form-text">거래처 연락처가 아이디로 생성됩니다.</span>
                                        </div>
                                    </div>
                                    <div class="form-group row required">
                                        <label class="col-form-label col-2">거래처 아이디/비밀번호</label>
                                        <div class="col-10">
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
                                                <span class="form-text">최초 로그인을 위한 임시 비밀번호입니다.</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row required">
                                        <label class="col-form-label col-2">거래처 담당자/휴대전화 번호</label>
                                        <div class="col-10">
                                            <div class="d-flex">
                                                <label style="width: 150px;">담당자 명</label>
                                                <input class="form-control" type="text" placeholder="담당자명을 입력해 주세요.">
                                            </div>
                                            <div class="d-flex mt-2">
                                                <label style="width: 150px;">휴대전화 번호</label>
                                                <input class="form-control" type="tel" placeholder="숫자만 입력해주세요.">
                                            </div>
                                            <span class="form-text">거래처 담당자 휴대전화 번호로 아이디와 비밀번호가 자동 발송됩니다.</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mt-4">
                                <div class="card-body">
                                    <h5 class="header-title">
                                        배송/영업 담당자 정보
                                        <span class="font-size-12 float-right"><span class="text-danger">*</span>필수 입력사항입니다.</span>
                                    </h5>
                                    <hr>
                                    <div class="form-group row required">
                                        <label class="col-form-label col-lg-2">배송 담당자</label>
                                        <div class="col-lg-10">
                                            <select class="form-control">
                                                <option value="">-- 선택 --</option>
                                            </select>
                                            <span class="form-text">선택한 담당자에게 배송관련 문자를 전송합니다.</span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">휴대전화 번호</label>
                                        <div class="col-lg-10">
                                            <input type="tel" class="form-control" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group row required">
                                        <label class="col-form-label col-lg-2">영업 담당자</label>
                                        <div class="col-lg-10">
                                            <select class="form-control">
                                                <option value="">-- 선택 --</option>
                                            </select>
                                            <span class="form-text">선택한 담당자에게 배송관련 문자를 전송합니다.</span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">휴대전화 번호</label>
                                        <div class="col-lg-10">
                                            <input type="tel" class="form-control" readonly>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mt-4">
                                <div class="card-body">
                                    <h5 class="header-title">
                                        단가 그룹
                                        <span class="font-size-12 float-right">거래처에서 선택된 단가속성의 금액으로 물건을 주문할수 있습니다.</span>
                                    </h5>
                                    <hr>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">단가 그룹 선택</label>
                                        <div class="col-lg-10">
                                            <select class="form-control">
                                                <option value="">-- 선택 --</option>
                                            </select>
                                            <span class="form-text">* 단가 그룹은 단가 관리 > [단가 그룹 관리]에서 등록할수 있습니다.</span>
                                            <span class="form-text">* 단가 그룹의 금액은 상품관리 페이지에서 상품별로 입력해주셔야 합니다.</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mt-4">
                                <div class="card-body">
                                    <h5 class="header-title">
                                        할인/할증율 등급
                                        <span class="font-size-12 float-right">거래처에서 등급별 할인된 가격으로 상품 구매가 가능합니다.</span>
                                    </h5>
                                    <hr>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">할인/할증율 등급 선택</label>
                                        <div class="col-lg-10">
                                            <select class="form-control">
                                                <option value="">-- 선택 --</option>
                                            </select>
                                            <span class="form-text">* 등록 거래처 목록 > [할인율 등급 관리]에서 할인율 등급을 등록할수 있습니다.</span>
                                            <span class="form-text">* 단가 그룹을 선택한 경우 단가 그룹 금액에 할인/할증율이 적용됩니다.</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mt-4">
                                <div class="card-body">
                                    <h5 class="header-title">
                                        결제수단 설정
                                        <span class="font-size-12 float-right">거래처에서 주문시, 설정된 결제수단으로 결제할수 있습니다.</span>
                                    </h5>
                                    <hr>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">결제수단</label>
                                        <div class="col-lg-10">
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="payment_method" id="payment_method1">
                                                <label class="custom-control-label" for="payment_method1">외상 거래</label>
                                            </div>
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="payment_method" id="payment_method2">
                                                <label class="custom-control-label" for="payment_method2">예치금</label>
                                            </div>
                                            <span class="form-text">
                                                * '외상거래'와 '예치금'은 둘 중 하나만 사용 선택 가능합니다. (신용카드는 중복 선택 가능)
                                            </span>
                                            <span class="form-text">
                                                * 외상거래의 잔액 결제, 예치금 충전은 거래처가 가상계좌 또는 신용카드로 결제후 청산됩니다.
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mt-4">
                                <div class="card-body">
                                    <h5 class="header-title">
                                        외상잔액 한도 설정
                                    </h5>
                                    <hr>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">외상잔액 한도 설정 여부</label>
                                        <div class="col-lg-10">
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="limit_setting" id="limit_setting1">
                                                <label class="custom-control-label" for="limit_setting1">비설정</label>
                                            </div>
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="limit_setting" id="limit_setting2">
                                                <label class="custom-control-label" for="limit_setting2">설정</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">외상잔액 한도 금액</label>
                                        <div class="col-lg-10">
                                            <div class="input-group">
                                                <input type="number" class="form-control">
                                                <div class="input-group-append">
                                                    <span class="input-group-text">원</span>
                                                </div>
                                            </div>
                                            <span class="form-text">거래처에서 외상잔액 한도 초과시, 더 이상 주문이 불가능합니다.</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mt-4">
                                <div class="card-body">
                                    <h5 class="header-title">
                                        수입물품 유통이력 정보
                                        <span class="font-size-12 float-right"></span>
                                    </h5>
                                    <hr>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">사업자 등록증 보유 유무</label>
                                        <div class="col-lg-10">
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="certificate" id="certificate1">
                                                <label class="custom-control-label" for="certificate1">유</label>
                                            </div>
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input class="custom-control-input" type="radio" name="certificate" id="certificate2">
                                                <label class="custom-control-label" for="certificate2">무</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">양수자 유형</label>
                                        <div class="col-lg-10">
                                            <select class="form-control">
                                                <option value="">유통업자</option>
                                            </select>
                                        </div>
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
                        2019 &copy; Pando. All Rights Reserved.
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

<script src="${contextPath}/resources/js/vendor.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>

</body>
</html>