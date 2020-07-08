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
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-sm rounded-circle mr-2" alt="Pando"/>
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-xs rounded-circle mr-2" alt="Pando"/>

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
                            <li>
                                <a href="/orders">주문 목록</a>
                            </li>
                            <li>
                                <a href="/product-orders">상품별 주문 목록</a>
                            </li>
                            <li class="mm-active">
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
                                <a href="/shops">거래처 목록</a>
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
                                <li class="breadcrumb-item active" aria-current="page">반품 내역</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">반품 내역</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form class="form-row">
                                    <div class="col-8">
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-3">기간</label>
                                            <div class="col-lg-9">
                                                <div class="form-row">
                                                    <div class="col-auto">
                                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                            <label class="btn btn-outline-primary active">
                                                                <input type="radio" name="options" id="option1" checked> 전체
                                                            </label>
                                                            <label class="btn btn-outline-primary">
                                                                <input type="radio" name="options" id="option2"> 전일
                                                            </label>
                                                            <label class="btn btn-outline-primary">
                                                                <input type="radio" name="options" id="option3"> 당일
                                                            </label>
                                                            <label class="btn btn-outline-primary">
                                                                <input type="radio" name="options" id="option4"> 한달
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <input type="text" id="range-datepicker" class="form-control" placeholder="2019-01-01 to 2019-12-31">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-form-label col-lg-3">키워드 검색</label>
                                            <div class="col-lg-9">
                                                <div class="form-row">
                                                    <div class="col-auto">
                                                        <select class="form-control">
                                                            <option>거래처명</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-auto">
                                                        <input class="form-control" type="text" placeholder="검색어를 입력해주세요">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4 align-self-center text-right">
                                        <button class="btn btn-primary">검색</button>
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
                                                        <option>처리 담당자</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <hr>
                                <div class="row">
                                    <div class="col-md-6">
                                        <a href="/returns/transaction-details" class="btn btn-outline-primary">
                                            <i data-feather="file-text" class="icon-xs"></i> 반품 거래명세표 출력
                                        </a>
                                    </div>
                                    <div class="col-md-6 text-md-right mt-md-0 mt-2">
                                        <a href="/returns/create" class="btn btn-outline-danger">
                                            <i data-feather="file-plus" class="icon-xs"></i> 반품 등록
                                        </a>
                                    </div>
                                </div>
                                <hr>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>
                                                <input type="checkbox">
                                            </th>
                                            <th>#</th>
                                            <th>반품일시</th>
                                            <th>주문번호</th>
                                            <th>거래처</th>
                                            <th>총 주문수량</th>
                                            <th>주문금액</th>
                                            <th>총 반품수량</th>
                                            <th>반품금액</th>
                                            <th>처리 담당자</th>
                                            <th>출고상태</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td><a href="/returns/1">1</a></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>출고전</td>
                                        </tr>
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td><a href="/returns/2">2</a></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>출고 거절</td>
                                        </tr>
                                        <tr>
                                            <td><input type="checkbox"></td>
                                            <td><a href="/returns/3">3</a></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>출고 완료</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
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

</body>
</html>