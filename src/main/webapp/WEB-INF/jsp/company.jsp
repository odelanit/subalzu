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
                <a href="javascript:;" class="nav-link"><i class="fa fa-user"></i>&nbsp;<c:out value="${pageContext.request.remoteUser}"/> 정보보기</a>
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
                                <li class="breadcrumb-item active" aria-current="page">기업정보 보기</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">기업정보 보기</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <c:if test="${message != null}" >
                            <div class="alert alert-success">
                                <span>${message}</span>
                            </div>
                        </c:if>
                        <form:form method="post" modelAttribute="companyForm">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">기업정보</h5>
                                    <spring:bind path="id">
                                        <form:hidden path="id"/>
                                    </spring:bind>
                                    <spring:bind path="user">
                                        <form:hidden path="user" />
                                    </spring:bind>
                                    <table class="table form-table table-bordered mb-5">
                                        <tbody class="thead-light">
                                        <spring:bind path="vendorName">
                                            <tr>
                                                <th>사업자명</th>
                                                <td colspan="3">
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                type="text" path="vendorName"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="vendorName"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="registeredNumber">
                                            <tr>
                                                <th>사업자등록번호</th>
                                                <td colspan="3">
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                type="text" path="registeredNumber"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="registeredNumber"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="ownerName">
                                            <tr>
                                                <th>대표자</th>
                                                <td colspan="3">
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                type="text" path="ownerName"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="ownerName"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <tr>
                                            <th>사업장 소재지</th>
                                            <td colspan="3">
                                                <spring:bind path="zipCode">
                                                    <div class="input-group">
                                                        <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" id="business_addr_zip" readonly="true"
                                                                    path="zipCode"/>
                                                        <div class="input-group-append">
                                                            <button type="button" id="zip_search" class="btn btn-primary">주소검색</button>
                                                        </div>
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="zipCode"/>
                                                    </div>
                                                </spring:bind>
                                                <spring:bind path="addressLine1">
                                                    <form:input readonly="true" id="business_address1"
                                                            cssClass="form-control mt-2 ${status.error ? 'is-invalid' : ''}"
                                                            path="addressLine1"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="addressLine1"/>
                                                    </div>
                                                </spring:bind>
                                                <spring:bind path="addressLine2">
                                                    <form:input id="business_address2"
                                                            cssClass="form-control mt-2 ${status.error ? 'is-invalid' : ''}"
                                                            path="addressLine2"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="addressLine2"/>
                                                    </div>
                                                </spring:bind>
                                            </td>
                                        </tr>
                                        <tr>
                                            <spring:bind path="businessConditions">
                                                <th>사업종류</th>
                                                <td>
                                                    <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" path="businessConditions"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="businessConditions"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="businessItem">
                                                <th>사업종목</th>
                                                <td>
                                                    <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" path="businessItem"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="businessItem"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="businessTel">
                                                <th>사업장 연락처</th>
                                                <td>
                                                    <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" path="businessTel"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="businessTel"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="email">
                                                <th>이메일</th>
                                                <td>
                                                    <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" placeholder="abcd@naver.com" path="email"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="email"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <spring:bind path="fax">
                                            <tr>
                                                <th>FAX 번호</th>
                                                <td colspan="3">
                                                    <form:input cssClass="form-control w-40 ${status.error ? 'is-invalid' : ''}" placeholder="02-1111-2222" path="fax"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="fax"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">정산계좌 정보</h5>
                                    <table class="table text-center table-bordered form-table">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>
                                                <label>정산계좌 정보</label>
                                            </th>
                                            <td>
                                                <table class="table">
                                                    <thead>
                                                    <tr>
                                                        <th>은행명</th>
                                                        <th>은행계좌</th>
                                                        <th>예금주</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr>
                                                        <td>
                                                            <spring:bind path="bankName">
                                                                <div class="form-group">
                                                                    <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" placeholder="은행명 입력" path="bankName"/>
                                                                    <div class="invalid-feedback">
                                                                        <form:errors path="bankName"/>
                                                                    </div>
                                                                </div>
                                                            </spring:bind>
                                                        </td>
                                                        <td>
                                                            <spring:bind path="bankAccount">
                                                                <div class="form-group">
                                                                    <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" placeholder="000-000-000000" path="bankAccount"/>
                                                                    <div class="invalid-feedback">
                                                                        <form:errors path="bankAccount"/>
                                                                    </div>
                                                                </div>
                                                            </spring:bind>
                                                        </td>
                                                        <td>
                                                            <spring:bind path="accountHolder">
                                                                <div class="form-group">
                                                                    <form:input cssClass="form-control ${status.error ? 'is-invalid' : ''}" placeholder="예금주 입력" path="accountHolder"/>
                                                                    <div class="invalid-feedback">
                                                                        <form:errors path="accountHolder"/>
                                                                    </div>
                                                                </div>
                                                            </spring:bind>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-primary">저장하기</button>
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
</script>
</body>
</html>