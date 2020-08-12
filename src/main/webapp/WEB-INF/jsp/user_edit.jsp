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
                                <li class="breadcrumb-item">직원 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">직원 정보 수정</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">직원 정보 수정</h4>
                    </div>
                </div>
            </div> <!-- container-fluid -->
            <div class="row">
                <div class="col">
                    <form:form method="post" modelAttribute="userForm">
                        <spring:bind path="id">
                            <form:hidden path="id"/>
                        </spring:bind>
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">기본 정보</h5>
                                <table class="table table-bordered form-table">
                                    <tbody class="thead-light">
                                    <tr>
                                        <spring:bind path="fullName">
                                            <th class="required"><span>담당자</span></th>
                                            <td>
                                                <form:input cssClass="form-control w-75 ${status.error ? 'is-invalid' : ''}"
                                                            placeholder="담당자" path="fullName"/>
                                                <div class="invalid-feedback">
                                                    <form:errors path="fullName"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                        <spring:bind path="phone">
                                            <th class="required"><span>담당자 휴대폰</span></th>
                                            <td>
                                                <form:input cssClass="w-75 form-control ${status.error ? 'is-invalid' : ''}"
                                                            placeholder="숫자만 입력해주세요." path="phone"/>
                                                <div class="invalid-feedback">
                                                    <form:errors path="phone"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                    </tr>
                                    <tr>
                                        <spring:bind path="username">
                                            <th><span>아이디</span></th>
                                            <td colspan="3">
                                                <form:input path="username"
                                                            cssClass="w-75 form-control ${status.error ? 'is-invalid' : ''}"
                                                            readonly="true"
                                                            placeholder="4자 이상 영문 또는 숫자만 사용 가능"/>
                                                <div class="invalid-feedback">
                                                    <form:errors path="username"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                    </tr>
                                    <tr>
                                        <spring:bind path="password">
                                            <th class="required"><label>비밀번호</label></th>
                                            <td colspan="3">
                                                <form:password path="password"
                                                               cssClass="w-75 form-control ${status.error ? 'is-invalid' : ''}"
                                                               placeholder="6자 이상 영문 숫자 조합"/>
                                                <div class="invalid-feedback">
                                                    <form:errors path="password"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                    </tr>
                                    <tr>
                                        <spring:bind path="passwordConfirm">
                                            <th class="required"><span>비밀번호 확인</span></th>
                                            <td colspan="3">
                                                <form:password path="passwordConfirm"
                                                               cssClass="w-75 form-control ${status.error ? 'is-invalid' : ''}"
                                                               placeholder="비밀번호를 다시 입력해주세요."/>
                                                <div class="invalid-feedback">
                                                    <form:errors path="passwordConfirm"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                    </tr>
                                    <tr>
                                        <spring:bind path="bio">
                                            <th><span>비고</span></th>
                                            <td colspan="3">
                                                <form:input path="bio"
                                                            cssClass="w-75 form-control ${status.error ? 'is-invalid' : ''}"
                                                            placeholder="내용을 입력해주세요."/>
                                                <div class="invalid-feedback">
                                                    <form:errors path="bio"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                    </tr>
                                    </tbody>
                                </table>
                                <h5 class="card-title">권한 정보</h5>
                                <table class="table table-bordered form-table">
                                    <tbody class="thead-light">
                                    <tr>
                                        <spring:bind path="roles">
                                            <th class="required"><span>권한 유형</span></th>
                                            <td>
                                                <c:forEach var="role" items="${roles}">
                                                    <div class="custom-control custom-radio custom-control-inline">
                                                        <form:radiobutton id="role-${role.name}" value="${role.id}"
                                                                          checked="${userRole.id == role.id ? 'checked' : '' }"
                                                                          class="custom-control-input" path="roles"/>
                                                        <label class="custom-control-label"
                                                               for="role-${role.name}">${role.koName}</label>
                                                    </div>
                                                </c:forEach>
                                                <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                    <form:errors path="roles"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                    </tr>
                                    <tr>
                                        <spring:bind path="permissions">
                                            <th class="required"><span>정보조회 권한</span></th>
                                            <td>
                                                <c:forEach var="permission" items="${permissions}">
                                                    <div class="custom-control custom-radio custom-control-inline">
                                                        <form:radiobutton id="permission-${permission.name}"
                                                                          value="${permission.id}" path="permissions"
                                                                          class="custom-control-input"
                                                                          checked="${userPermission.id == permission.id ? 'checked' : '' }"
                                                        />
                                                        <label class="custom-control-label"
                                                               for="permission-${permission.name}">${permission.koName}</label>
                                                    </div>
                                                </c:forEach>
                                                <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                    <form:errors path="permissions"/>
                                                </div>
                                            </td>
                                        </spring:bind>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="form-group text-center">
                                    <a href="/users" class="btn btn-secondary">목록으로</a>
                                    <button class="btn btn-primary">수정하기</button>
                                </div>
                            </div>
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