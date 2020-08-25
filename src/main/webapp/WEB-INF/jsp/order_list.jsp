<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <meta name="_csrf" content="${_csrf.token}"/>

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/toastr-2.1.4/toastr.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="javascript:;" class="nav-link"><i class="fa fa-user"></i>&nbsp;<c:out
                        value="${pageContext.request.remoteUser}"/></a>
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
    <jsp:include page="sidebar.jsp"/>
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
                                <li class="breadcrumb-item active" aria-current="page">주문 목록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">주문 목록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="form" method="get">
                                    <form:hidden path="page"/>
                                    <table class="table table-bordered form-table">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간 구분</th>
                                            <td>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton value="createdAt" path="dateField"
                                                                      id="customRadioInline1"
                                                                      class="custom-control-input"/>
                                                    <label class="custom-control-label" for="customRadioInline1">주문
                                                        일시</label>
                                                </div>
                                                <div class="custom-control custom-radio custom-control-inline">
                                                    <form:radiobutton value="requestDate" path="dateField"
                                                                      id="customRadioInline2"
                                                                      class="custom-control-input"/>
                                                    <label class="custom-control-label" for="customRadioInline2">배송
                                                        요청일</label>
                                                </div>
                                            </td>
                                            <td rowspan="3">
                                                <button class="btn btn-outline-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
                                                    <div class="btn-group btn-group-sm btn-group-toggle mr-2"
                                                         data-toggle="buttons">
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="1"
                                                                              label="전체"/>
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off"
                                                                              value="-1" label="전일"/>
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off" value="0"
                                                                              label="당일"/>
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" autocomplete="off"
                                                                              value="-30" label="한달"/>
                                                        </label>
                                                    </div>
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateFrom" class="form-control"
                                                                    placeholder=""/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="far fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <span class="px-2">-</span>
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateTo" class="form-control form-control-sm"
                                                                    placeholder=""/>
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
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:select class="form-control form-control-sm mr-2 w-20"
                                                                 path="field">
                                                        <form:option value="shopName" label="거래처명"/>
                                                        <form:option value="orderCode" label="주문번호"/>
                                                    </form:select>
                                                    <form:input class="form-control form-control-sm w-40" path="keyword"
                                                                placeholder="검색어를 입력해주세요"/>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline" id="imSearch">
                                                    <form:select path="deliveryType"
                                                                 cssClass="form-control form-control-sm w-15 mr-2">
                                                        <form:option value="" label="배송유형"/>
                                                        <form:option value="direct" label="직배송"/>
                                                        <form:option value="parcel" label="택배배송"/>
                                                    </form:select>
                                                    <form:select cssClass="form-control form-control-sm w-15 mr-2"
                                                                 path="orderStatus">
                                                        <form:option value="" label="주문상태"/>
                                                        <form:option value="completed" label="주문완료"/>
                                                        <form:option value="modified" label="주문변경"/>
                                                        <form:option value="canceled" label="주문취소"/>
                                                        <form:option value="return_pending" label="반품접수"/>
                                                        <form:option value="return_completed" label="반품완료"/>
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm w-15 mr-2"
                                                                 path="releaseStatus">
                                                        <form:option value="" label="출고상태"/>
                                                        <form:option value="progress" label="출고전"/>
                                                        <form:option value="completed" label="출고완료"/>
                                                        <form:option value="rejected" label="출고거절"/>
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm w-15 mr-2"
                                                                 path="deliverer">
                                                        <form:option value="" label="배송 담당자"/>
                                                        <form:options items="${deliverers}" itemValue="id"
                                                                      itemLabel="fullName"/>
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm w-15"
                                                                 path="salesman">
                                                        <form:option value="" label="영업 담당자"/>
                                                        <form:options items="${salesMans}" itemValue="id"
                                                                      itemLabel="fullName"/>
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row align-items-center mb-3">
                                    <div class="col-md-6">
                                        <button type="button" onclick="printOrder()"
                                                class="btn btn-outline-primary btn-sm">
                                            <i class="fa fa-scroll"></i> 거래명세표
                                        </button>
                                        <button type="button" onclick="printReleaseProducts()"
                                                class="btn btn-outline-secondary btn-sm">
                                            <i class="fa fa-print"></i> 출고지시서
                                        </button>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <a href="/orders/create" class="btn btn-outline-primary btn-sm">
                                            <i class="fa fa-plus"></i> 신규주문 등록
                                        </a>
                                    </div>
                                </div>
                                <hr>
                                <div class="row align-items-center mb-4">
                                    <div class="col-6">
                                        <span>전체 ${orderPage.totalElements}건</span>
                                        <button class="btn btn-sm btn-outline-primary" id="completeRelease">출고 완료
                                        </button>
                                    </div>
                                    <div class="col-6 text-right">
                                        <span>* 전일~당일까지의 주문내역이 기본으로 노출됩니다. </span>
                                        <a class="btn btn-sm btn-excel" href="/orders/history/download">
                                            <i class="fa fa-file-excel"></i> 주문내역
                                        </a>
                                    </div>
                                </div>
                                <div>
                                    <table class="table table-hover text-center" id="orders">
                                        <thead class="thead-light">
                                        <tr>
                                            <th><input type="checkbox" id="selectAll"></th>
                                            <th>#</th>
                                            <th>주문일시</th>
                                            <th>배송요청일</th>
                                            <th>주문번호</th>
                                            <th>거래처</th>
                                            <th>배송유형</th>
                                            <th>총 주문수량</th>
                                            <th>결제수단</th>
                                            <th>주문금액</th>
                                            <th>주문상태</th>
                                            <th>출고상태</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${orders}" var="order">
                                            <tr data-id="${order.id}">
                                                <td><input type="checkbox" value="${order.id}" class="check"></td>
                                                <td>${order.id}</td>
                                                <td>${order.createdAt.format(localDateTimeFormat)}</td>
                                                <td>${order.requestDate.format(localDateTimeFormat2)}</td>
                                                <td>${order.orderCode}</td>
                                                <td>${order.shop.name}</td>
                                                <td>${order.deliveryType == "direct" ? "직배송" : "택배 배송" }</td>
                                                <td>${order.totalQty}</td>
                                                <td>${order.shop.paymentMethod == "credit" ? "외상거래" : "예치금"}</td>
                                                <td><fmt:formatNumber type="number" value="${order.funds}"/></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.returnStatus == ''}">
                                                            <c:choose>
                                                                <c:when test="${order.orderStatus == 'modified'}">
                                                                    주문변경
                                                                </c:when>
                                                                <c:when test="${order.orderStatus == 'completed'}">
                                                                    주문완료
                                                                </c:when>
                                                                <c:when test="${order.orderStatus == 'canceled'}">
                                                                    <span class="text-danger">주문취소</span>
                                                                </c:when>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:when test="${order.returnStatus != ''}">
                                                            <c:choose>
                                                                <c:when test="${order.returnStatus == 'progress'}">
                                                                    반품접수
                                                                </c:when>
                                                                <c:when test="${order.returnStatus == 'completed'}">
                                                                    반품완료
                                                                </c:when>
                                                            </c:choose>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.releaseStatus == 'progress'}">
                                                            출고전
                                                        </c:when>
                                                        <c:when test="${order.releaseStatus == 'completed'}">
                                                            출고완료
                                                        </c:when>
                                                        <c:otherwise>
                                                            출고거절
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                        <c:if test="${orderPage.totalPages > 1}">
                                            <tfoot>
                                            <tr>
                                                <td colspan="11">
                                                    <nav>
                                                        <ul class="pagination justify-content-center">
                                                            <c:choose>
                                                                <c:when test="${orderPage.hasPrevious()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link"
                                                                           data-page="${currentPage - 1}"
                                                                           href="javascript:;">
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
                                                            <c:forEach var="i" begin="1" end="${orderPage.totalPages}">
                                                                <li class="page-item <c:if test="${i == currentPage}">active</c:if>">
                                                                    <a href="javascript:;" class="page-link"
                                                                       data-page="${i}">${i}</a></li>
                                                            </c:forEach>
                                                            <c:choose>
                                                                <c:when test="${orderPage.hasNext()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link"
                                                                           data-page="${currentPage + 1}"
                                                                           href="javascript:;">
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
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    var token = $('meta[name="_csrf"]').attr('content');
    $('#dateFrom').datepicker({
        dateFormat: 'yy-mm-dd'
    });
    $('#dateTo').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $('#imSearch select').on('change', function () {
        $('#form').submit();
    });

    $('.page-link').on('click', function () {
        var pageNo = $(this).data('page');
        if (pageNo) {
            $('#page').val(pageNo);
            $('#form').submit();
        }
    });

    $('#selectAll').on('change', function (e) {
        $('#orders tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
    });

    $('#orders tbody tr td:not(:first-child)').on('click', function () {
        window.location.href = '/orders/' + $(this).closest('tr').data('id');
    });

    $('#orders tbody tr td:first-child').on('click', function (e) {
        var checkboxElement = $(this).find('input[type="checkbox"]');
        checkboxElement.prop('checked', !checkboxElement.prop('checked'));
    });

    $('#orders tbody tr td input[type="checkbox"]').on('change', function (e) {
        var checkboxElement = $(this);
        checkboxElement.prop('checked', !checkboxElement.prop('checked'));
    });

    $('#completeRelease').on('click', function () {
        var ids = [];
        $('#orders tbody input[type="checkbox"]:checked').each(function (index) {
            ids.push($(this).val());
        });
        if (ids.length > 0) {
            $.ajax({
                type: 'POST',
                url: '/orders/complete_release_all',
                contentType: 'application/json',
                accept: 'text/plain',
                headers: {
                    'X-CSRF-TOKEN': token
                },
                data: JSON.stringify(ids),
                beforeSend: function () {
                    $("#overlay").fadeIn(300);
                },
                success: function (data) {
                    window.location.reload();
                }
            }).done(function () {
                setTimeout(function () {
                    $("#overlay").fadeOut(300);
                }, 500);
            });
        } else {
            toastr.error('출고완료 처리할 주문을 선택해주세요.');
        }
    });

    function printOrder() {
        var ids = '';
        $('#orders tbody input[type="checkbox"]:checked').each(function (index) {
            ids += ($(this).val()) + ',';
        });
        if (ids) {
            window.open('/orders/print_order?ids=' + ids, "거래명세표", "width=1350, height=700, toolbar=no, menubar=no, scrollbars=yes, resizable=yes");
        } else {
            toastr.error('출력할 주문을 선택해주세요');
        }
    }

    function printReleaseProducts() {
        var ids = '';
        $('#orders tbody input[type="checkbox"]:checked').each(function (index) {
            ids += ($(this).val()) + ',';
        });
        if (ids) {
            window.open('/orders/print_release?ids=' + ids, "출고상품목록", "width=1301, height=700, toolbar=no, menubar=no, scrollbars=yes,resizable=yes");
        } else {
            toastr.error('출력할 주문을 선택해주세요');
        }
    }

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

    $('input[name="period"]').on('change', function () {
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

</script>
</body>
</html>