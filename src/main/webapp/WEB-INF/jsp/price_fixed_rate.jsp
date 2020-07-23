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
                    <li class="mm-active">
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
                            <li class="mm-active">
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
                                <li class="breadcrumb-item">단가 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">정액 / 정률 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">정액/정률 관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">정액/정률 사용 설정 <span data-toggle="modal" data-target="#infoModal"
                                                                   class="fa fa-info-circle"></span></h5>
                            </div>
                            <div class="card-body">
                                <form:form method="post" id="setting">
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">설정 여부</label>
                                        <div class="col-lg-10">
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input type="radio" class="custom-control-input" name="is_fixed" value="true"
                                                       id="flat1"
                                                       <c:if test="${fixedRateSetting == true}">checked</c:if>>
                                                <label class="custom-control-label" for="flat1">설정</label>
                                            </div>
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input type="radio" class="custom-control-input" name="is_fixed" value="false"
                                                       id="flat2"
                                                       <c:if test="${fixedRateSetting == false}">checked</c:if>>
                                                <label class="custom-control-label" for="flat2">비설정</label>
                                            </div>
                                            <small class="form-text">
                                                * 타이틀 우측의 ?를 누르면 자세한 내용을 확인하실수 있습니다.
                                            </small>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                        <div class="card mb-4 <c:if test="${fixedRateSetting == false}">d-none</c:if>" id="price-rate">
                            <div class="card-header">
                                <h5 class="mb-0">단가 그룹/상품 카테고리</h5>
                            </div>
                            <div class="card-body">
                                <p>* 정률값( (매입단가/100) &times; 설정% )의 소숫점은 올림 처리하고, 나머지 원 단위는 절삭합니다.</p>
                                <p>* 상품 카테고리별로 정액/정률을 별도 설정하시려면 <a href="/categories">상품 관리 > 카테고리 설정</a>에서 먼저 사용여부를 설정해
                                    주세요.</p>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>카테고리</th>
                                            <th>직배송 단가</th>
                                            <th>택배배송 단가</th>
                                            <th>기본 단가</th>
                                        </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <a href="/prices" class="btn btn-secondary">이전 목록으로</a>
                            <button form="setting" class="btn btn-primary">설정 저장</button>
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
<div class="modal fade" id="infoModal">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">정액/정률 사용법 안내</div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p class="text-primary">
                    * 설정 여부를 설정으로 놓고, 단가그룹별로 설정값을 세팅한 뒤, 적용버튼을 누르면 사용처리가 됩니다.<br>
                    * 해당 기능의 적용 범위는 아래와 같습니다.
                </p>
                <table class="table">
                    <thead class="thead-light">
                    <tr>
                        <th style="width: 25%;">적용부분</th>
                        <th style="width: 75%;">설명</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th>상품 대량 등록/수정</th>
                        <td>
                            상품 관리에서 상품 엑셀 대량 등록/수정시 입력하신 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.
                        </td>
                    </tr>
                    <tr>
                        <th>상품 등록/수정</th>
                        <td>상품 관리에서 새로운 상품 등록 및 기존 상품 수정 시 입력하신 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.</td>
                    </tr>
                    <tr>
                        <th>상품 단가 일괄 적용</th>
                        <td>
                            단가 관리 &gt; 상품 단가 일괄 적용 메뉴에서 매입단가 입력 및 단가 일괄 수정 시 입력한 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- END wrapper -->

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $('input[name="is_fixed"]').on('change', function() {
        var isFixed = $(this).val();
        switch (isFixed) {
            case 'true':
                $('#price-rate').removeClass('d-none');
                break;
            case 'false':
                $('#price-rate').addClass('d-none');
                break;
        }
    });
</script>

</body>
</html>