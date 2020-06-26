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
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">

    <!-- App css -->
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/app.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<!-- Begin page -->
<div id="wrapper">

    <!-- Topbar Start -->
    <div class="navbar navbar-expand flex-column flex-md-row navbar-custom">
        <div class="container-fluid">
            <!-- LOGO -->
            <a href="/" class="navbar-brand mr-0 mr-md-2 logo">
                        <span class="logo-lg">
                            <img src="${contextPath}/resources/images/logo.png" alt="" height="24"/>
                            <span class="d-inline h5 ml-1 text-logo">Pando</span>
                        </span>
                <span class="logo-sm">
                            <img src="${contextPath}/resources/images/logo.png" alt="" height="24">
                        </span>
            </a>

            <ul class="navbar-nav bd-navbar-nav flex-row list-unstyled menu-left mb-0">
                <li class="">
                    <button class="button-menu-mobile open-left disable-btn">
                        <i data-feather="menu" class="menu-icon"></i>
                        <i data-feather="x" class="close-icon"></i>
                    </button>
                </li>
            </ul>

            <ul class="navbar-nav mb-0">
                <li class="nav-item d-none d-lg-block">
                    <a href="/orders/create" class="nav-link">신규주문 등록</a>
                </li>
                <li class="nav-item d-none d-lg-block">
                    <a href="/products/create" class="nav-link">상품 등록</a>
                </li>
                <li class="nav-item d-none d-lg-block">
                    <a href="/clients/create" class="nav-link">거래처 등록</a>
                </li>
            </ul>

            <ul class="navbar-nav flex-row ml-auto d-flex list-unstyled topnav-menu float-right mb-0">
                <li class="nav-item d-none d-lg-block">
                    <a href="/profile" class="nav-link"><i data-feather="user"></i>&nbsp;<c:out value="${pageContext.request.remoteUser}"/> 정보보기</a>
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
                <li class="nav-item d-none d-lg-block">
                    <a href="javascript:;" class="nav-link" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
                </li>
                <form class="d-none" action="/logout" method="post" id="logout-form">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                </form>
            </ul>
        </div>

    </div>
    <!-- end Topbar -->

    <!-- ========== Left Sidebar Start ========== -->
    <div class="left-side-menu">
        <div class="media user-profile mt-2 mb-2">
            <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-sm rounded-circle mr-2" alt="Pando"/>
            <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-xs rounded-circle mr-2" alt="Pando"/>

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
                    <li class="mm-active">
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
                    <li>
                        <a href="javascript: void(0);">
                            <i data-feather="list"></i>
                            <span> 거래처 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
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
                                <a href="/employees">직원 관리</a>
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
                                <li class="breadcrumb-item">매입처 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">신규 매입처 등록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">신규 매입처 등록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">

                        <div class="card">
                            <div class="card-body">
                                <h5 class="header-title">기본 정보</h5>
                                <hr>
                                <form>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">매입처 코드</label>
                                                <div class="col-lg-8">
                                                    <input class="form-control" type="text" placeholder="매입처코드를 입력하세요">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group row required">
                                                <label class="col-form-label col-lg-4">매입처 명</label>
                                                <div class="col-lg-8">
                                                    <input class="form-control" type="text" placeholder="매입처명을 입력하세요.">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">사업자등록번호</label>
                                                <div class="col-lg-8">
                                                    <input class="form-control" type="text" placeholder="사업자등록번호를 입력해주세요.">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">대표자 명</label>
                                                <div class="col-lg-8">
                                                    <input class="form-control" type="text" placeholder="대표자 명을 입력하세요.">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">대표 전화번호</label>
                                                <div class="col-lg-8">
                                                    <input type="text" class="form-control" placeholder="대표 전화번호를 입력해주세요.">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">업종/업태</label>
                                                <div class="col-lg-8">
                                                    <div class="d-flex">
                                                        <input type="text" class="form-control" placeholder="업종">
                                                        <input type="text" class="form-control ml-2" placeholder="업태">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">FAX 번호</label>
                                                <div class="col-lg-8">
                                                    <input type="text" class="form-control" placeholder="FAX 번호를 입력해주세요.">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">이메일</label>
                                                <div class="col-lg-8">
                                                    <input type="email" class="form-control" placeholder="abc@naver.com">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row align-items-center">
                                        <label class="col-form-label col-lg-2">사업장 소재지</label>
                                        <div class="col-lg-10">
                                            <div class="input-group">
                                                <input class="form-control" type="text" readonly>
                                                <div class="input-group-append">
                                                    <button type="button" class="btn btn-outline-primary">주소검색</button>
                                                </div>
                                            </div>
                                            <input class="form-control mt-2" type="text" readonly placeholder="주소를 선택해주세요.">
                                            <input class="form-control mt-2" type="text" placeholder="상세 주소를 입력해주세요.">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card mt-4">
                            <div class="card-body">
                                <h5 class="header-title">매입처 계정 정보</h5>
                                <hr>
                                <form>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">담당자</label>
                                                <div class="col-lg-8">
                                                    <input class="form-control" type="text" placeholder="담당자">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group row">
                                                <label class="col-form-label col-lg-4">담당자 휴대폰</label>
                                                <div class="col-lg-8">
                                                    <input class="form-control" type="text" placeholder="숫자만 입력해주세요.">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">아이디</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control" placeholder="4자 이상 영문 또는 숫자만 사용 가능">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">임시 비밀번호</label>
                                        <div class="col-lg-10">
                                            <input type="password" class="form-control" placeholder="6자 이상 영문, 숫자 조합">
                                            <span class="form-text text-primary">매입처 최초 로그인을 위한 임시 비밀번호를 설정해 주세요.</span>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">임시 비밀번호 확인</label>
                                        <div class="col-lg-10">
                                            <input type="password" class="form-control" placeholder="비밀번호를 다시 입력해주세요.">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">비고</label>
                                        <div class="col-lg-10">
                                            <input type="text" class="form-control" placeholder="내용을 입력해주세요.">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card mt-4">
                            <div class="card-body">
                                <h5 class="header-title">매입처 상품</h5>
                                <hr>
                                <div class="row">
                                    <div class="col">

                                    </div>
                                    <div class="col text-right">
                                        <button type="button" data-toggle="modal" data-target="#add-product-modal" class="btn btn-sm btn-outline-primary"><i data-feather="plus" class="icon-xs"></i>상품추가</button>
                                    </div>
                                </div>
                                <div class="table-responsive mt-3">
                                    <table class="table">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>상품코드</th>
                                            <th>상품명</th>
                                            <th>카테고리</th>
                                            <th>규격(단위)</th>
                                            <th>제조사(원산지)</th>
                                            <th>매입단가(원)</th>
                                            <th>삭제</th>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <a href="/suppliers" class="btn btn-outline-secondary">목록으로</a>
                            <button class="btn btn-primary">저장하기</button>
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
<div class="modal fade" id="add-product-modal">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-soft-primary">
                <h5 class="modal-title">상품선택</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form-row">
                    <div class="col-8">
                        <div class="form-group row">
                            <label class="col-form-label col-lg-3">키워드 검색</label>
                            <div class="col-lg-9">
                                <div class="d-flex align-items-center">
                                    <span class="col-auto">
                                        상품번호/명
                                    </span>
                                    <input class="form-control" type="text" placeholder="">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <button type="button" class="btn btn-primary">검색</button>
                    </div>
                </form>
                <hr>
                <form>
                    <div class="form-group row">
                        <label class="col-form-label col-lg-2">즉시 검색</label>
                        <div class="col-lg-10">
                            <div class="form-row">
                                <div class="col-auto">
                                    <select class="form-control">
                                        <option>1차 카테고리</option>
                                    </select>
                                </div>
                                <div class="col-auto">
                                    <select class="form-control">
                                        <option>2차 카테고리</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <hr>
                <table class="table">
                    <thead class="thead-light">
                    <tr>
                        <th><input type="checkbox"></th>
                        <th>상품번호</th>
                        <th>상품명</th>
                        <th>카테고리</th>
                        <th>규격(단위)</th>
                        <th>제조사(원산지)</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-primary">저장</button>
            </div>
        </div>
    </div>
</div>
<!-- END wrapper -->

<script src="${contextPath}/resources/js/vendor.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>

</body>
</html>