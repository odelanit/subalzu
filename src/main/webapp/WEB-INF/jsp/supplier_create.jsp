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
                            <h6 class="pro-user-name mt-0 mb-0">${currentCompany.vendorName}</h6>
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
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 매입 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li>
                                <a href="/shipping">발주 관리</a>
                            </li>
                            <li class="mm-active">
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
                                <li class="breadcrumb-item">매입처 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">${page_title}</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">${page_title}</h4>
                    </div>
                </div>
                <form:form method="post" modelAttribute="supplierForm">
                    <div class="row">
                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <spring:bind path="id">
                                        <form:hidden path="id" />
                                    </spring:bind>
                                    <h5 class="card-title">기본 정보</h5>
                                    <table class="table table-bordered form-table mb-4">
                                        <colgroup>
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <spring:bind path="code">
                                                <th>매입처 코드</th>
                                                <td>
                                                    <form:input path="code"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="매입처코드를 입력하세요"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="code"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="name">
                                                <th class="required"><span>매입처 명</span></th>
                                                <td>
                                                    <form:input path="name"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="매입처명을 입력하세요."/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="name"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="regNo">
                                                <th>사업자등록번호</th>
                                                <td>
                                                    <form:input path="regNo"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="사업자등록번호를 입력해주세요."/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="regNo"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="ownerName">
                                                <th>대표자 명</th>
                                                <td>
                                                    <form:input path="ownerName"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                type="text" placeholder="대표자 명을 입력하세요."/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="ownerName"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <spring:bind path="businessTel">
                                                <th>대표 전화번호</th>
                                                <td>
                                                    <form:input path="businessTel"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="대표 전화번호를 입력해주세요."/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="businessTel"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <th>업종/업태</th>
                                            <td>
                                                <div class="d-flex">
                                                    <spring:bind path="businessTel">
                                                        <form:input path="businessItem"
                                                                    class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                    placeholder="업종"/>
                                                    </spring:bind>
                                                    <spring:bind path="businessConditions">
                                                        <form:input path="businessConditions"
                                                                    class="form-control ml-2 ${status.error ? 'is-invalid' : ''}"
                                                                    placeholder="업태"/>
                                                    </spring:bind>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <spring:bind path="fax">
                                                <th>FAX 번호</th>
                                                <td>
                                                    <form:input path="fax"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="FAX 번호를 입력해주세요."/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="fax"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="email">
                                                <th>이메일</th>
                                                <td>
                                                    <form:input path="email"
                                                                class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="abc@naver.com"/>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="email"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <tr>
                                            <th>사업장 소재지</th>
                                            <td colspan="3">
                                                <spring:bind path="zipCode">
                                                    <div class="input-group">
                                                        <form:input class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                    path="zipCode" readonly="true" id="business_addr_zip"/>
                                                        <div class="input-group-append">
                                                            <button type="button" id="zip_search" class="btn btn-outline-primary">주소검색
                                                            </button>
                                                        </div>
                                                    </div>
                                                </spring:bind>
                                                <spring:bind path="addressLine1">
                                                    <form:input
                                                            class="form-control mt-2 ${status.error ? 'is-invalid' : ''}"
                                                            path="addressLine1" readonly="true" id="business_address1"
                                                            placeholder="주소를 선택해주세요."/>
                                                </spring:bind>
                                                <spring:bind path="addressLine2">
                                                    <form:input
                                                            class="form-control mt-2 ${status.error ? 'is-invalid' : ''}"
                                                            id="business_address2"
                                                            path="addressLine2" placeholder="상세 주소를 입력해주세요."/>
                                                </spring:bind>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">매입처 계정 정보</h5>
                                    <form:hidden path="user" />
                                    <table class="table table-bordered form-table mb-4">
                                        <colgroup>
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                            <col style="width: 15%">
                                            <col style="width: 35%">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <spring:bind path="fullName">
                                                <th>담당자</th>
                                                <td>
                                                    <form:input path="fullName" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="담당자" />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="fullName"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                            <spring:bind path="phone">
                                                <th>담당자 휴대폰</th>
                                                <td>
                                                    <form:input class="form-control ${status.error ? 'is-invalid' : ''}" path="phone" placeholder="숫자만 입력해주세요." />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="phone"/>
                                                    </div>
                                                </td>
                                            </spring:bind>
                                        </tr>
                                        <spring:bind path="username">
                                            <tr>
                                                <th>아이디</th>
                                                <td colspan="3">
                                                    <form:input path="username" class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                placeholder="4자 이상 영문 또는 숫자만 사용 가능" />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="username"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="password">
                                            <tr>
                                                <th>임시 비밀번호</th>
                                                <td colspan="3">
                                                    <form:password path="password" class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                   placeholder="6자 이상 영문, 숫자 조합" />
                                                    <small class="form-text text-primary">매입처 최초 로그인을 위한 임시 비밀번호를 설정해 주세요.</small>
                                                    <div class="invalid-feedback">
                                                        <form:errors path="password"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="passwordConfirm">
                                            <tr>
                                                <th>임시 비밀번호 확인</th>
                                                <td colspan="3">
                                                    <form:password path="passwordConfirm" class="form-control ${status.error ? 'is-invalid' : ''}"
                                                                   placeholder="비밀번호를 다시 입력해주세요." />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="passwordConfirm"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="bio">
                                            <tr>
                                                <th>비고</th>
                                                <td colspan="3">
                                                    <form:input path="bio" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="내용을 입력해주세요." />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="bio"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <div class="form-group text-center">
                                        <a href="/suppliers" class="btn btn-outline-secondary">목록으로</a>
                                        <button class="btn btn-primary">저장하기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form:form>
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

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    $("#zip_search").click(function(e){

        var zipcode = "business_addr_zip";
        var addr1 = "business_address1";
        var addr2 = "business_address2";
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