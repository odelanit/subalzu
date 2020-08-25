<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
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
                                <li class="breadcrumb-item">재고 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">입/출고 내역</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">입/출고 내역</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="form" method="get">
                                    <table class="table table-bordered form-table mb-5">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
                                                    <div class="btn-group btn-group-sm btn-group-toggle mr-2" data-toggle="buttons">
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="1" label="전체" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="-1" label="전일" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="0" label="당일" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="-30" label="한달" />
                                                        </label>
                                                    </div>
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateFrom" cssClass="form-control" placeholder="" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="far fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <span class="px-2">-</span>
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateTo" cssClass="form-control" placeholder="" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="far fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td rowspan="2">
                                                <button class="btn btn-outline-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:select class="form-control form-control-sm w-25 mr-2" path="field">
                                                        <form:option value="product_name" label="상품명" />
                                                        <form:option value="product_erpCode" label="상품코드" />
                                                        <form:option value="product_makerName" label="제조사" />
                                                    </form:select>
                                                    <form:input class="form-control form-control-sm w-50" path="keyword" placeholder="검색어를 입력해주세요" />
                                                    <form:hidden path="page" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <form:select path="action" cssClass="custom-select custom-select-sm w-20">
                                                    <form:option value="" label="구분" />
                                                    <form:option value="shipping_input" label="입고" />
                                                    <form:option value="output" label="출고" />
                                                    <form:option value="manual_input" label="수동입고" />
                                                    <form:option value="manual_output" label="수동출고" />
                                                    <form:option value="discard_output" label="폐기출고" />
                                                    <form:option value="return_output" label="반품출고" />
                                                </form:select>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row mb-3 align-items-center">
                                    <div class="col-6">
                                        전체 ${recordPage.totalElements}건
                                    </div>
                                    <div class="col-6 text-right">
                                        <a href="/stock-history/download_excel" class="btn btn-sm btn-excel"><i class="fa fa-file-excel"></i> Excel 다운로드</a>
                                    </div>
                                </div>
                                <table class="table table-middle text-center">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>일지</th>
                                        <th>상품코드</th>
                                        <th>상품명</th>
                                        <th>제조사(원산지)</th>
                                        <th>구분</th>
                                        <th>처리수량</th>
                                        <th>재고</th>
                                        <th>처리 관리자</th>
                                        <th>비고</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${records}" var="record">
                                        <tr>
                                            <td>${record.id}</td>
                                            <td>${record.createdAt.format(localDateTimeFormat)}</td>
                                            <td>${record.product.erpCode}</td>
                                            <td>${record.product.name}</td>
                                            <td>${record.product.makerName}<br>
                                                <c:if test="${not empty record.product.country}">
                                                    (${record.product.country})
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${record.action == 'shipping_input'}">
                                                        입고
                                                    </c:when>
                                                    <c:when test="${record.action == 'output'}">
                                                        출고
                                                    </c:when>
                                                    <c:when test="${record.action == 'manual_input'}">
                                                        수동입고
                                                    </c:when>
                                                    <c:when test="${record.action == 'manual_output'}">
                                                        수동출고
                                                    </c:when>
                                                    <c:when test="${record.action == 'discard_output'}">
                                                        폐기출고
                                                    </c:when>
                                                    <c:when test="${record.action == 'return_output'}">
                                                        반품출고
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${record.product.useDecimal == true}">
                                                        ${record.diff}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:parseNumber type="number" value="${record.diff}" integerOnly="true" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${record.product.useDecimal == true}">
                                                        ${record.qty}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:parseNumber value="${record.qty}" integerOnly="true" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${not empty record.user}">
                                                    ${record.user.fullName}
                                                </c:if>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <c:if test="${recordPage.totalPages > 1}">
                                        <tfoot>
                                        <tr>
                                            <td colspan="11">
                                                <nav>
                                                    <ul class="pagination justify-content-center">
                                                        <c:choose>
                                                            <c:when test="${recordPage.hasPrevious()}">
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
                                                        <c:forEach var="i" begin="1" end="${recordPage.totalPages}">
                                                            <li class="page-item <c:if test="${i == currentPage}">active</c:if>"><a href="javascript:;" class="page-link" data-page="${i}">${i}</a></li>
                                                        </c:forEach>
                                                        <c:choose>
                                                            <c:when test="${recordPage.hasNext()}">
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
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $(document).ready(function () {
        $('#action').on('change', function () {
            $('#form').submit();
        });

        $('#dateFrom, #dateTo').datepicker({
            dateFormat: 'yy-mm-dd'
        });

        $('.page-link').on('click', function() {
            var pageNo = $(this).data('page');
            if (pageNo) {
                $('#page').val(pageNo);
                $('#form').submit();
            }
        });

        formatDate = function (date) {
            let month = '' + (date.getMonth() + 1),
                day = '' + date.getDate(),
                year = date.getFullYear();

            if (month.length < 2)
                month = '0' + month;
            if (day.length < 2)
                day = '0' + day;

            return [year, month, day].join('-');
        };

        $('input[name="period"]').on('change', function() {
            var diff = +$(this).val();
            const dateTo = new Date();
            let strDateTo = formatDate(dateTo);
            let strDateFrom;
            if (diff !== 1) {
                const dateFrom = new Date(dateTo);
                dateFrom.setDate(dateTo.getDate() + diff);
                strDateFrom = formatDate(dateFrom);
                $('#dateFrom').val(strDateFrom);
            } else {
                $('#dateFrom').val('2020-01-01');
            }
            if (diff === -1) {
                $('#dateTo').val(strDateFrom);
            } else {
                $('#dateTo').val(strDateTo);
            }
        });
    })
</script>
</body>
</html>