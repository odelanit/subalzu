<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
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
    <jsp:include page="sidebar.jsp" />
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
                                <li class="breadcrumb-item"><a href="/orders">주문 목록</a></li>
                                <li class="breadcrumb-item active" aria-current="page">거래명세표</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">거래명세표</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card" style="height: 69vh;">
                            <div class="card-body">
                                <div class="slimscroll">
                                    <table class="table-bordered table">
                                        <tr>
                                            <td class="bg-light" style="text-align: center; vertical-align: middle;" rowspan="5">공급자</td>
                                            <td>사업자등록번호</td>
                                            <td>123-45-67</td>
                                            <td class="bg-light" style="text-align: center; vertical-align: middle;" rowspan="5">공급받는자</td>
                                            <td>사업자등록번호</td>
                                            <td>123-45-67</td>
                                        </tr>
                                        <tr>
                                            <td>상호(법인명)</td>
                                            <td>서라벌농장(주)</td>
                                            <td>상호(법인명)</td>
                                            <td>진이최고당</td>
                                        </tr>
                                        <tr>
                                            <td>주소</td>
                                            <td>[423-841]경기 광명시 철산로 지하 13(철산동, 철산역) 118동 303호</td>
                                            <td>주소</td>
                                            <td>[15616]경기 안산시 단원구 첨단로 7(성곡동) 1</td>
                                        </tr>
                                        <tr>
                                            <td>연락처/FAX</td>
                                            <td>02-562-7005 / 02-6204-2144</td>
                                            <td>연락처/FAX</td>
                                            <td>02-562-7005</td>
                                        </tr>
                                        <tr>
                                            <td>담당자/연락처</td>
                                            <td>(배송)나눔/010-5840-2130</td>
                                            <td>담당자/연락처</td>
                                            <td>김웅/010-5840-2130</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <button class="btn btn-outline-primary">출력하기</button>
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

<script src="${contextPath}/resources/js/vendor.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>

</body>
</html>