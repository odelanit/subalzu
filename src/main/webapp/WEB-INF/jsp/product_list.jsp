<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link href="${contextPath}/resources/toastr-2.1.4/toastr.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="javascript:;" class="nav-link"><i class="fa fa-user"></i>&nbsp;<c:out
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
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 상품 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item active" aria-current="page">상품 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">상품 관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <c:if test="${message != null}">
                            <div class="alert alert-success">
                                    ${message}
                            </div>
                        </c:if>
                        <div class="card">
                            <div class="card-body">
                                <form:form method="get" modelAttribute="form">
                                    <table class="table table-bordered form-table mb-5">
                                        <colgroup>
                                            <col style="width: 100px;">
                                            <col style="width: 570px;">
                                            <col>
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:select path="field"
                                                                 cssClass="form-control form-control-sm w-25 mr-2">
                                                        <form:option value="name" label="상품명"/>
                                                        <form:option value="erpCode" label="상품코드"/>
                                                        <form:option value="makerName" label="제조사"/>
                                                    </form:select>
                                                    <form:input path="keyword"
                                                                cssClass="form-control form-control-sm w-70"/>
                                                    <form:hidden path="page"/>
                                                </div>
                                            </td>
                                            <td>
                                                <button class="btn btn-outline-secondary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline" id="imSearch">
                                                    <form:select path="status"
                                                                 cssClass="form-control w-20 form-control-sm mr-2">
                                                        <form:option value="" label="판매상태"/>
                                                        <form:option value="true" label="판매중"/>
                                                        <form:option value="false" label="판매중지"/>
                                                        <form:option value="out" label="재고부족"/>
                                                    </form:select>
                                                    <form:select path="deliveryType"
                                                                 cssClass="form-control w-20 form-control-sm mr-2">
                                                        <form:option value="" label="배송유형"/>
                                                        <form:option value="1" label="직배송"/>
                                                        <form:option value="2" label="택배배송"/>
                                                    </form:select>
                                                    <form:select path="category"
                                                                 cssClass="form-control w-20 form-control-sm mr-2">
                                                        <form:option value="" label="1차 카테고리"/>
                                                        <form:options items="${categories}" itemValue="id" itemLabel="name"/>
                                                    </form:select>
                                                    <form:select path="subcategory"
                                                                 cssClass="form-control w-20 form-control-sm mr-2">
                                                        <form:option value="" label="2차 카테고리"/>
                                                        <form:options items="${subcategories}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row">
                                    <div class="col-6">
                                        <button class="btn btn-sm btn-excel" data-toggle="modal" data-target="#editProductsModal">
                                            <i class="fa fa-file-excel"></i>상품 일괄 수정
                                        </button>
                                        <button class="btn btn-sm btn-excel" data-toggle="modal"
                                                data-target="#addProductsModal"><i class="fa fa-file-excel"></i>상품 대량 등록
                                        </button>
                                    </div>
                                    <div class="col-6 text-right">
                                        <a class="btn btn-sm btn-outline-primary" href="/products/create"><i
                                                class="fa fa-plus"></i>상품등록</a>
                                    </div>
                                </div>
                                <hr>
                                <div class="mb-2 row align-items-center">
                                    <div class="col-6">
                                        <span>전체 ${productPage.totalElements}건</span>
                                        <button class="btn btn-sm btn-outline-secondary changeStatus" data-action="true"><i class="fa fa-check"></i> 판매중
                                        </button>
                                        <button class="btn btn-sm btn-outline-secondary changeStatus" data-action="false"><i class="fa fa-times"></i>
                                            판매중지
                                        </button>
                                    </div>
                                    <div class="col-6 text-right">
                                        <a class="btn btn-sm btn-outline-primary" href="/stock"><i
                                                class="fa fa-exchange"></i> 재고변경</a>
                                        <button class="btn btn-sm btn-outline-danger" id="deleteProducts"><i class="fa fa-trash"></i> 삭제
                                        </button>
                                    </div>
                                </div>
                                <table class="table table-sm table-hover text-center table-middle" id="products">
                                    <thead class="thead-light">
                                    <tr>
                                        <th><input type="checkbox" id="selectAll"></th>
                                        <th>#</th>
                                        <th>상품코드</th>
                                        <th>썸네일</th>
                                        <th>상품명</th>
                                        <th>카테고리</th>
                                        <th>규격(단위)</th>
                                        <th>제조사(원산지)</th>
                                        <th>배송유형</th>
                                        <th>매입단가</th>
                                        <th>직배송단가</th>
                                        <th>택배배송단가</th>
                                        <th>재고량</th>
                                        <th>판매상태</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${products}" var="product">
                                        <tr data-id="${product.id}">
                                            <td><input type="checkbox" name="product" value="${product.id}"></td>
                                            <td>${product.id}</td>
                                            <td>${product.erpCode}</td>
                                            <td><c:if test="${not empty product.imageUrl}"><img style="max-width: 150px;"
                                                                                              class="img-thumbnail"
                                                                                              src="${product.imageUrl}"></c:if>
                                            </td>
                                            <td>${product.name}</td>
                                            <td>${product.category.name}</td>
                                            <td>
                                                    ${product.standard}<br>
                                                <c:if test="${!empty product.unit}">
                                                    (${product.unit})
                                                </c:if>
                                            </td>
                                            <td>
                                                    ${product.makerName} <br>
                                                <c:if test="${!empty product.country}">
                                                    (${product.country})
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.deliveryType == 0}">
                                                        직배송,<br>
                                                        택배배송
                                                    </c:when>
                                                    <c:when test="${product.deliveryType == 1}">
                                                        직배송
                                                    </c:when>
                                                    <c:when test="${product.deliveryType == 2}">
                                                        택배배송
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${product.buyPrice}</td>
                                            <td>${product.directPrice}</td>
                                            <td>${product.parcelPrice}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${product.useDecimal == true}">
                                                        ${product.qty}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:parseNumber value="${product.qty}" integerOnly="true" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${product.status ? '판매중' : '<span class="text-danger">판매중지</span>'}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
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

<div class="modal fade" id="addProductsModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">
                    상품 대량 등록
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p><strong>양식 다운 로드 > 엑셀 파일 작성 > 등록 </strong> 버튼을 클릭하여 등록합니다.<br>
                    <small>* 기존 상품 정보 수정은 일괄 수정을 통해 할수 있습니다.</small>
                </p>
                <table class="table">
                    <tbody class="thead-light">
                    <tr>
                        <th>양식 다운 로드</th>
                        <td>
                            <a href="/products/create_form" class="btn btn-sm btn-outline-primary"><i
                                    class="fa fa-download"></i> 다운로드</a>
                        </td>
                    </tr>
                    <tr>
                        <th>파일 업로드</th>
                        <td>
                            <form:form method="post" action="/products/upload_create_file" id="uploadExcelForm">
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="file"
                                               accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                                               class="custom-file-input" id="uploadExcelFile" name="upload">
                                        <label class="custom-file-label" for="uploadExcelFile">
                                            <i class="fa fa-search"></i>파일 찾기
                                        </label>
                                    </div>
                                    <div class="input-group-append">
                                        <button class="btn btn-primary">등록</button>
                                    </div>
                                </div>
                            </form:form>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editProductsModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <div class="modal-title">
                    상품 일괄 수정
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p><strong>양식 다운 로드 > 엑셀 파일 작성 > 등록 </strong> 버튼을 클릭하여 등록합니다.<br>
                    <small>* 기존 상품만 수정 가능합니다. <span class="text-danger">※ 상품 기본코드를 수정하면 오류가 발생하여 수정을 할 수 없습니다.</span></small>
                </p>
                <table class="table">
                    <tbody class="thead-light">
                    <tr>
                        <th>양식 다운 로드</th>
                        <td>
                            <a href="/products/edit_form" class="btn btn-sm btn-outline-primary"><i
                                    class="fa fa-download"></i> 다운로드</a>
                        </td>
                    </tr>
                    <tr>
                        <th>파일 업로드</th>
                        <td>
                            <form:form method="post" action="/products/upload_edit_file" id="uploadEditForm">
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="file"
                                               accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"
                                               class="custom-file-input" id="uploadExcelFile2" name="upload">
                                        <label class="custom-file-label" for="uploadExcelFile2">
                                            <i class="fa fa-search"></i>파일 찾기
                                        </label>
                                    </div>
                                    <div class="input-group-append">
                                        <button class="btn btn-primary">등록</button>
                                    </div>
                                </div>
                            </form:form>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<div id="overlay">
    <div class="cv-spinner">
        <div class="lds-default">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $(document).ready(function () {
        var token = $("meta[name='_csrf']").attr("content");

        $('#uploadExcelFile, #uploadExcelFile2').on('change', function (e) {
            if (e.target.files.length > 0) {
                var fileName = e.target.files[0].name;
                $(this).next('.custom-file-label').html(fileName);
            } else {
                $(this).next('.custom-file-label').html('<i class="fa fa-search"></i>파일 찾기');
            }
        });

        $('#uploadExcelForm, #uploadEditForm').submit(function(e) {
            e.preventDefault();
            var formData = new FormData($(this)[0]);
            $.ajax({
                type: 'POST',
                url: $(this).attr('action'),
                data: formData,
                processData: false,
                contentType: false,
                beforeSend: function() {
                    $("#overlay").fadeIn(300);
                },
                success: function(data) {
                    toastr.success(data.message);
                    window.location.reload();
                }
            }).done(function () {
                setTimeout(function(){
                    $("#overlay").fadeOut(300);
                },500);
            });
        });

        $('#selectAll').on('change', function (e) {
            $('#products tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
        });

        $('#products tbody tr td:not(:first-child)').on('click', function () {
            window.location.href = '/products/' + $(this).closest('tr').data('id');
        });

        $('#products tbody tr td:first-child').on('click', function (e) {
            var checkboxElement = $(this).find('input[type="checkbox"]');
            checkboxElement.prop('checked', !checkboxElement.prop('checked'));
        });

        $('#products tbody tr td input[type="checkbox"]').on('change', function (e) {
            var checkboxElement = $(this);
            checkboxElement.prop('checked', !checkboxElement.prop('checked'));
        });

        $('.changeStatus').on('click', function () {
            var action = $(this).data('action');
            var ids = [];
            $('#products tbody input[type="checkbox"]:checked').each(function(index) {
                ids.push($(this).val());
            });
            if (ids.length === 0) {
                toastr.error("판매처리하실 상품을 선택해주세요.");
            } else {
                $.ajax({
                    type: 'POST',
                    url: '/products/change_status',
                    headers: {
                        'X-CSRF-TOKEN': token,
                    },
                    data: {
                        ids: ids,
                        action: action
                    },
                    beforeSend: function() {
                        $("#overlay").fadeIn(300);
                    },
                    success: function(data) {
                        toastr.success(data.message);
                        window.location.reload();
                    }
                }).done(function () {
                    setTimeout(function(){
                        $("#overlay").fadeOut(300);
                    },500);
                });
            }
        });

        $('#deleteProducts').on('click', function () {
            var ids = [];
            $('#products tbody input[type="checkbox"]:checked').each(function(index) {
                ids.push($(this).val());
            });
            if (ids.length === 0) {
                toastr.error("삭제처리하실 상품을 선택해주세요.");
            } else {
                $.ajax({
                    type: 'POST',
                    url: '/products/delete',
                    headers: {
                        'X-CSRF-TOKEN': token,
                    },
                    data: {
                        ids: ids,
                    },
                    beforeSend: function() {
                        $("#overlay").fadeIn(300);
                    },
                    success: function(data) {
                        toastr.success(data.message);
                        window.location.reload();
                    }
                }).done(function () {
                    setTimeout(function(){
                        $("#overlay").fadeOut(300);
                    },500);
                });
            }
        });

        $('#imSearch select').on('change', function() {
            $('#form').submit();
        });
    });
</script>
</body>
</html>