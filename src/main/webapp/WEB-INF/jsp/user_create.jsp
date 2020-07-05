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
    <link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>
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
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-sm rounded-circle mr-2" alt="Pando"/>
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-xs rounded-circle mr-2" alt="Pando"/>

                    <div class="media-body">
                        <a href="/company">
                            <h6 class="pro-user-name mt-0 mb-0">Nik Patel</h6>
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
                            <li>
                                <a href="/order-setting">주문 설정</a>
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
                            <li>
                                <a href="#">구역 관리</a>
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
                            <i class="fa fa-folder"></i>
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
                            <i class="fa fa-folder"></i>
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
                            <i class="fa fa-folder"></i>
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
                            <i class="fa fa-folder"></i>
                            <span> 회계 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="#">Inbox</a>
                            </li>
                        </ul>
                    </li>
                    <li class="mm-active">
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
                                <a href="#">고객문의</a>
                            </li>
                            <li>
                                <a href="#">자주하는 질문 FAQ</a>
                            </li>
                            <li class="mm-active">
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
                                <li class="breadcrumb-item"><a href="/users">직원 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">직원 등록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">직원 등록</h4>
                    </div>
                </div>
            </div> <!-- container-fluid -->
            <div class="row">
                <div class="col">
                    <c:if test="${message != null}" >
                        <div class="alert alert-danger">
                            <span>${message}</span>
                        </div>
                    </c:if>
                    <form:form method="post" modelAttribute="userForm">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">기본 정보</h5>
                                <div class="row">
                                    <spring:bind path="fullName">
                                        <div class="col-lg-6">
                                            <div class="form-group row required">
                                                <label class="col-form-label col-lg-4">담당자</label>
                                                <div class="col-lg-8">
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="담당자" path="fullName" />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="fullName" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                    <spring:bind path="phone">
                                        <div class="col-lg-6">
                                            <div class="form-group row required">
                                                <label class="col-form-label col-lg-4">담당자 휴대폰</label>
                                                <div class="col-lg-8">
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="숫자만 입력해주세요."  path="phone" />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="phone" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </spring:bind>
                                </div>
                                <spring:bind path="username">
                                    <div class="form-group row required">
                                        <label class="col-form-label col-lg-2">아이디</label>
                                        <div class="col-lg-10">
                                            <form:input path="username" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="4자 이상 영문 또는 숫자만 사용 가능" />
                                            <div class="invalid-feedback">
                                                <form:errors path="username" />
                                            </div>
                                        </div>
                                    </div>
                                </spring:bind>
                                <spring:bind path="password">
                                    <div class="form-group row required">
                                        <label class="col-form-label col-lg-2">비밀번호</label>
                                        <div class="col-lg-10">
                                            <form:password path="password" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="6자 이상 영문 숫자 조합" />
                                            <div class="invalid-feedback">
                                                <form:errors path="password" />
                                            </div>
                                        </div>
                                    </div>
                                </spring:bind>
                                <spring:bind path="passwordConfirm">
                                    <div class="form-group row required">
                                        <label class="col-form-label col-lg-2">비밀번호 확인</label>
                                        <div class="col-lg-10">
                                            <form:password path="passwordConfirm" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="비밀번호를 다시 입력해주세요." />
                                            <div class="invalid-feedback">
                                                <form:errors path="passwordConfirm" />
                                            </div>
                                        </div>
                                    </div>
                                </spring:bind>
                                <spring:bind path="bio">
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">비고</label>
                                        <div class="col-lg-10">
                                            <form:input path="bio" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="내용을 입력해주세요." />
                                            <div class="invalid-feedback">
                                                <form:errors path="bio" />
                                            </div>
                                        </div>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">권한 정보</h5>
                                <spring:bind path="roles">
                                    <div class="form-group row required">
                                        <label class="col-form-label col-lg-2">권한 유형</label>
                                        <div class="col-lg-10">
                                            <c:forEach var="role" items="${roles}">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton id="role-${role.name}" value="${role.id}" class="custom-control-input" path="roles" />
                                                    <label class="custom-control-label" for="role-${role.name}">${role.koName}</label>
                                                </div>
                                            </c:forEach>
                                            <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                <form:errors path="roles" />
                                            </div>
                                        </div>
                                    </div>
                                </spring:bind>
                                <spring:bind path="permissions">
                                    <div class="form-group row required">
                                        <label class="col-form-label col-lg-2">정보조회 권한</label>
                                        <div class="col-lg-10">
                                            <c:forEach var="permission" items="${permissions}">
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton id="permission-${permission.name}" value="${permission.id}" path="permissions" class="custom-control-input" />
                                                    <label class="custom-control-label" for="permission-${permission.name}">${permission.koName}</label>
                                                </div>
                                            </c:forEach>
                                            <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                <form:errors path="permissions" />
                                            </div>
                                        </div>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                        <div class="form-group">
                            <button class="btn btn-primary">등록</button>
                        </div>
                    </form:form>
                </div>
            </div>

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

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>

</body>
</html>