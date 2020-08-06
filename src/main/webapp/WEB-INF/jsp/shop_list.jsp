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
                            <li>
                                <a href="/order_products">상품별 주문 목록</a>
                            </li>
                            <li>
                                <a href="/return_orders">반품 내역</a>
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
                                <a href="/stock">입/출고 관리</a>
                            </li>
                            <li>
                                <a href="/stock-history">입/출고 내역</a>
                            </li>
                        </ul>
                    </li>
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 거래처 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item active" aria-current="page">거래처 목록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">거래처 목록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="form" method="get">
                                    <form:hidden path="page" />
                                    <table class="table table-bordered form-table mb-4">
                                        <colgroup>
                                            <col style="width: 100px;">
                                            <col style="width: 650px;">
                                            <col>
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="d-flex">
                                                    <form:select path="field" cssClass="custom-select custom-select-sm w-30 mr-2">
                                                        <form:option value="name" label="거래처명" />
                                                    </form:select>
                                                    <form:input path="keyword" cssClass="form-control form-control-sm" />
                                                </div>
                                            </td>
                                            <td rowspan="2">
                                                <button class="btn btn-outline-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td>
                                                <div class="d-flex" id="imSearch">
                                                    <form:select path="deliveryType" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="배송 유형" />
                                                        <form:option value="1" label="직배송" />
                                                        <form:option value="2" label="택배배송" />
                                                    </form:select>
                                                    <form:select path="deliverer" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="배송 담당자" />
                                                        <form:options items="${deliverers}" itemValue="id" itemLabel="fullName" />
                                                    </form:select>
                                                    <form:select path="salesman" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="영업 담당자" />
                                                        <form:options items="${salesMans}" itemValue="id" itemLabel="fullName" />
                                                    </form:select>
                                                    <form:select path="dealStatus" cssClass="custom-select custom-select-sm mr-2">
                                                        <form:option value="" label="거래 상태" />
                                                        <form:option value="true" label="거래중" />
                                                        <form:option value="false" label="거래중지" />
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div>
                                    <div class="row mb-3 align-items-center">
                                        <div class="col-lg-6 text-lg-left text-center">
                                            <span class="mr-3">전체 ${shopPage.totalElements}건</span>
                                            <button class="btn btn-sm btn-outline-danger changeStatus" data-action="false"><i class="fa fa-times"></i>거래 중지</button>
                                            <button class="btn btn-sm btn-outline-success changeStatus" data-action="true" ><i class="fa fa-check"></i>거래 재개</button>
                                        </div>
                                        <div class="col-lg-6 text-center text-lg-right">
                                            <a class="btn btn-outline-secondary btn-sm" href="/shop_grades"><i class="fal fa-badge-percent"></i>할인/할증 등급 관리</a>
                                            <button data-toggle="modal" data-target="#downloadEditForm" class="btn btn-outline-excel btn-sm"><i class="fa fa-file-excel"></i>거래처 일괄 수정</button>
                                            <a href="/shops/create" class="btn btn-outline-primary btn-sm"><i class="fa fa-plus"></i>거래처 등록</a>
                                        </div>
                                    </div>
                                    <table class="table text-center table-hover" id="shops">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>
                                                <input type="checkbox" data-toggle="tooltip" data-title="전체 선택" id="selectAll" />
                                            </th>
                                            <th>#</th>
                                            <th>등록일</th>
                                            <th>거래처</th>
                                            <th>배송 유형</th>
                                            <th>할인/할증 등급</th>
                                            <th>총 매출</th>
                                            <th>거래처 거래내역</th>
                                            <th>거래상태</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${shops}" var="shop">
                                            <tr data-id="${shop.id}">
                                                <td><input type="checkbox" value="${shop.id}" /></td>
                                                <td>${shop.id}</td>
                                                <td>${shop.createdAt.format(localDateTimeFormat)}</td>
                                                <td>${shop.name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${shop.deliveryType == 0}">
                                                            전체
                                                        </c:when>
                                                        <c:when test="${shop.deliveryType == 1}">
                                                            직배송
                                                        </c:when>
                                                        <c:when test="${shop.deliveryType == 2}">
                                                            택배 배송
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>${shop.shopGrade == null ? '없음' : shop.shopGrade.name}</td>
                                                <td>${shop.totalSales}원</td>
                                                <td>
                                                    <a href="/shops/${shop.id}">보기</a>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${shop.dealStatus == true}">
                                                            <span class="text-success">거래중</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-danger">거래중지</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                        <c:if test="${shopPage.totalPages > 1}">
                                            <tfoot>
                                            <tr>
                                                <td colspan="9">
                                                    <nav>
                                                        <ul class="pagination justify-content-center">
                                                            <c:choose>
                                                                <c:when test="${shopPage.hasPrevious()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link" data-page="${currentPage - 1}" href="javascript:;">
                                                                            &laquo;
                                                                        </a>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li class="page-item disabled">
                                                                        <a class="page-link" href="#">
                                                                            &laquo;
                                                                        </a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:forEach var="i" begin="1" end="${shopPage.totalPages}">
                                                                <li class="page-item <c:if test="${i == currentPage}">active</c:if>"><a href="javascript:;" class="page-link" data-page="${i}">${i}</a></li>
                                                            </c:forEach>
                                                            <c:choose>
                                                                <c:when test="${shopPage.hasNext()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link" data-page="${currentPage + 1}" href="javascript:;">
                                                                            &raquo;
                                                                        </a>
                                                                    </li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <li class="page-item disabled">
                                                                        <a class="page-link" href="#">
                                                                            &raquo;
                                                                        </a>
                                                                    </li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </ul>
                                                    </nav>
                                                </td>
                                            </tr>
                                            </tfoot>
                                        </c:if>
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
<div id="downloadEditForm" class="modal fade">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">
                    거래처 일괄 수정
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p><strong>양식 다운 로드 > 엑셀 파일 작성 > 등록 </strong> 버튼을 클릭하여 등록합니다.<br>
                    <small>* 기존 거래처만 수정 가능합니다. <span class="text-danger">※ 거래처 기본코드를 수정하면 오류가 발생하여 수정을 할 수 없습니다.</span></small>
                </p>
                <table class="table">
                    <tbody class="thead-light">
                    <tr>
                        <th>양식 다운 로드</th>
                        <td>
                            <a href="/shops/download_edit_form" class="btn btn-sm btn-outline-primary"><i
                                    class="fa fa-download"></i> 다운로드</a>
                        </td>
                    </tr>
                    <tr>
                        <th>파일 업로드</th>
                        <td>
                            <form:form method="post" action="/shops/upload_edit_file" id="uploadEditForm">
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
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $(document).ready(function() {
        var token = $("meta[name='_csrf']").attr("content");

        $('#imSearch').on('change', function() {
            $('#form').submit();
        });

        $('#selectAll').on('change', function (e) {
            $('#shops tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
        });

        $('#shops tbody tr td:not(:first-child)').on('click', function () {
            window.location.href = '/shops/' + $(this).closest('tr').data('id') + '/edit';
        });

        $('#shops tbody tr td:first-child').on('click', function (e) {
            var checkboxElement = $(this).find('input[type="checkbox"]');
            checkboxElement.prop('checked', !checkboxElement.prop('checked'));
        });

        $('#shops tbody tr td input[type="checkbox"]').on('change', function (e) {
            var checkboxElement = $(this);
            checkboxElement.prop('checked', !checkboxElement.prop('checked'));
        });

        $('#uploadExcelFile2').on('change', function (e) {
            if (e.target.files.length > 0) {
                var fileName = e.target.files[0].name;
                $(this).next('.custom-file-label').html(fileName);
            } else {
                $(this).next('.custom-file-label').html('<i class="fa fa-search"></i> 파일 찾기');
            }
        });

        $('#uploadEditForm').submit(function(e) {
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

        $('.changeStatus').on('click', function () {
            var action = $(this).data('action');
            var ids = [];
            $('#shops tbody input[type="checkbox"]:checked').each(function(index) {
                ids.push($(this).val());
            });
            if (ids.length === 0) {
                toastr.error("판매처리하실 상품을 선택해주세요.");
            } else {
                $.ajax({
                    type: 'POST',
                    url: '/shops/change_status',
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

        $('.page-link').on('click', function() {
            var pageNo = $(this).data('page');
            if (pageNo) {
                $('#page').val(pageNo);
                $('#form').submit();
            }
        })
    })
</script>
</body>
</html>