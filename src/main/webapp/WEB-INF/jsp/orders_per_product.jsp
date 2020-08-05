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

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
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
                            <li class="mm-active">
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
                                <li class="breadcrumb-item active" aria-current="page">상품별 주문 목록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">상품별 주문 목록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="form" method="get">
                                    <form:hidden path="page" />
                                    <table class="table table-bordered form-table mb-5">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간 구분</th>
                                            <td>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton path="dateField" id="customRadioInline1" class="custom-control-input" value="order_createdAt" />
                                                    <label class="custom-control-label" for="customRadioInline1">주문 일시</label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton path="dateField" id="customRadioInline2" class="custom-control-input" value="order_requestDate" />
                                                    <label class="custom-control-label" for="customRadioInline2">배송 요청일</label>
                                                </div>
                                            </td>
                                            <td rowspan="3">
                                                <button class="btn btn-primary">검색</button>
                                            </td>
                                        </tr>
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
                                                    <div class="input-group">
                                                        <form:input path="dateFrom" class="form-control form-control-sm" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="far fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <span class="mx-2">-</span>
                                                    <div class="input-group">
                                                        <form:input path="dateTo" class="form-control form-control-sm" />
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="far fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>거래처 검색</th>
                                            <td>
                                                <form:input path="shopKeyword" class="form-control form-control-sm" placeholder="검색어를 입력해주세요." />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline">
                                                    <form:select class="form-control form-control-sm w-10 mr-2" path="field">
                                                        <form:option value="product_name" label="상품명" />
                                                        <form:option value="product_erpCode" label="상품코드" />
                                                        <form:option value="order_code" label="주문번호" />
                                                    </form:select>
                                                    <form:input path="keyword" class="form-control form-control-sm w-20" placeholder="검색어를 입력해주세요" />
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline" id="imSearch">
                                                    <form:select class="form-control form-control-sm mr-2 w-15" path="deliveryType">
                                                        <form:option value="" label="배송유형" />
                                                        <form:option value="direct" label="직배송" />
                                                        <form:option value="parcel" label="택배배송" />
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm mr-2 w-15" path="orderStatus">
                                                        <form:option value="" label="주문상태" />
                                                        <form:option value="completed" label="주문완료" />
                                                        <form:option value="modified" label="주문변경" />
                                                        <form:option value="canceled" label="주문취소" />
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm mr-2 w-15" path="releaseStatus">
                                                        <form:option value="" label="출고상태" />
                                                        <form:option value="progress" label="출고전" />
                                                        <form:option value="completed" label="출고완료" />
                                                        <form:option value="rejected" label="출고거절" />
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm mr-2 w-15" path="category">
                                                        <form:option value="" label="1차 카테고리" />
                                                        <form:options items="${categories}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm mr-2 w-15" path="subcategory">
                                                        <form:option value="" label="2차 카테고리" />
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row mb-3 align-items-center">
                                    <div class="col-6">
                                        <span>전체 ${orderProductPage.totalElements}건</span>
                                    </div>
                                    <div class="col-6 text-right">
                                        <span>* 전일~당일까지의 주문내역이 기본으로 노출됩니다.</span>
<%--                                        <a class="btn btn-sm btn-outline-excel" href=""><i class="fa fa-file-excel"></i>Excel 다운로드</a>--%>
                                    </div>
                                </div>
                                <table class="table text-center table-middle table-hover" id="orderProducts">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>주문일시</th>
                                        <th>배송요청일</th>
                                        <th>주문번호</th>
                                        <th>거래처</th>
                                        <th>상품명</th>
                                        <th>판매규격(단위)</th>
                                        <th>주문수량</th>
                                        <th>단가</th>
                                        <th>대표매입처</th>
                                        <th>주문상태</th>
                                        <th>출고상태</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${orderProducts}" var="orderProduct">
                                        <tr data-order="${orderProduct.order.id}">
                                            <td>${orderProduct.id}</td>
                                            <td>${orderProduct.order.createdAt.format(localDateTimeFormat)}</td>
                                            <td>${orderProduct.order.requestDate.format(localDateTimeFormat2)}</td>
                                            <td>${orderProduct.order.orderCode}</td>
                                            <td>${orderProduct.order.shop.name}</td>
                                            <td>${orderProduct.product.name}</td>
                                            <td>${orderProduct.product.standard}<br>(${orderProduct.product.unit})</td>
                                            <td>${orderProduct.qty}</td>
                                            <td>${orderProduct.price}</td>
                                            <td>${orderProduct.product.supplier.name}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${orderProduct.order.orderStatus == 'completed'}">주문완료</c:when>
                                                    <c:when test="${orderProduct.order.orderStatus == 'canceled'}">주문취소</c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${orderProduct.order.releaseStatus == 'progress'}">출고전</c:when>
                                                    <c:when test="${orderProduct.order.releaseStatus == 'rejected'}">출고거절</c:when>
                                                    <c:when test="${orderProduct.order.releaseStatus == 'completed'}">출고완료</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <c:if test="${orderProductPage.totalPages > 1}">
                                        <tfoot>
                                        <tr>
                                            <td colspan="11">
                                                <nav>
                                                    <ul class="pagination justify-content-center">
                                                        <c:choose>
                                                            <c:when test="${orderProductPage.hasPrevious()}">
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
                                                        <c:forEach var="i" begin="1" end="${orderProductPage.totalPages}">
                                                            <li class="page-item <c:if test="${i == currentPage}">active</c:if>"><a href="javascript:;" class="page-link" data-page="${i}">${i}</a></li>
                                                        </c:forEach>
                                                        <c:choose>
                                                            <c:when test="${orderProductPage.hasNext()}">
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
        $('#dateFrom, #dateTo').datepicker({
            dateFormat: 'yy-mm-dd'
        });

        $('#orderProducts tbody tr').on('click', function () {
            var orderId = $(this).data('order');
            window.location.href = '/orders/' + orderId;
        });

        $('#imSearch select').on('change', function() {
            $('#form').submit();
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
    });
</script>
</body>
</html>