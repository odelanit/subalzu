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

    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/metismenu/metisMenu.min.css" rel="stylesheet" type="text/css"/>
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
                <a class="nav-link" href="javascript:;">
                    <i class="fa fa-user"></i>&nbsp;<c:out value="${pageContext.request.remoteUser}"/>
                </a>
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
                                <li class="breadcrumb-item"><a href="/orders">주문 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">주문 상세내역</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">주문 상세내역</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="order">
                                    <form:hidden path="id" />
                                    <div class="py-5">
                                        <h5 class="text-center">주문번호 ${order.orderCode} 상세내역입니다.</h5>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <a href="/orders/${order.id}/delete" class="btn btn-sm btn-outline-danger" id="order_delete">
                                                <i class="fa fa-trash"></i> 주문삭제
                                            </a>
                                            <c:choose>
                                                <c:when test="${order.orderStatus == 'completed' && order.releaseStatus != 'rejected' && order.releaseStatus != 'completed'}">
                                                    <a href="/orders/${order.id}/cancel" class="btn btn-sm btn-warning">주문취소</a>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                        <div class="col-md-6 text-right">
                                            <button class="btn btn-sm btn-outline-secondary" onclick="printOrder()" type="button">
                                                <i class="fa fa-scroll"></i>
                                                거래명세표
                                            </button>
                                            <c:choose>
                                                <c:when test="${order.orderStatus == 'completed' && order.releaseStatus == 'progress'}">
                                                    <button class="btn btn-sm btn-outline-danger change_release_status" type="button" data-id="${order.id}" data-status="rejected">
                                                        <i class="fa fa-times"></i>출고거절
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-primary change_release_status" type="button" data-id="${order.id}" data-status="completed">
                                                        <i class="fa fa-check"></i>출고완료
                                                    </button>
                                                </c:when>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${order.releaseStatus == 'completed' && order.orderStatus == 'completed'}">
                                                    <button class="btn btn-sm btn-outline-warning" type="button" data-toggle="modal" data-target="#returnOrderModal">
                                                        반품접수
                                                    </button>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <hr>
                                    <h5 class="card-title">주문 정보
                                        <span class="text-primary">
                                        (주문상태:
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'completed'}">주문완료</c:when>
                                            <c:when test="${order.orderStatus == 'canceled'}">주문취소</c:when>
                                        </c:choose>
                                    </span>
                                        <span class="mx-1">/</span>
                                        <span class="text-success">
                                        출고상태:
                                        <c:choose>
                                            <c:when test="${order.releaseStatus == 'progress'}">출고전</c:when>
                                            <c:when test="${order.releaseStatus == 'rejected'}">출고거절</c:when>
                                            <c:when test="${order.releaseStatus == 'completed'}">출고완료</c:when>
                                        </c:choose>
                                        )
                                    </span>
                                    </h5>
                                    <table class="table form-table table-bordered mb-4">
                                        <colgroup>
                                            <col width="15%">
                                            <col width="35%">
                                            <col width="15%">
                                            <col width="35%">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>주문번호</th>
                                            <td>${order.orderCode}</td>
                                            <th>거래처</th>
                                            <td>${order.shop.name}</td>
                                        </tr>
                                        <tr>
                                            <th>주문일자</th>
                                            <td>${order.createdAt.format(localDateTimeFormat)}</td>
                                            <th>담당자/연락처</th>
                                            <td>${order.shop.shopOwner.fullName} / ${order.shop.shopOwner.phone}</td>
                                        </tr>
                                        <tr>
                                            <th>거래처 주소</th>
                                            <td colspan="3">${order.shop.addressLine1} ${order.shop.addressLine2}</td>
                                        </tr>
                                        <tr>
                                            <th>결제수단</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.shop.paymentMethod == 'credit'}">외상결제</c:when>
                                                    <c:when test="${order.shop.paymentMethod == 'prepaid'}">예치금</c:when>
                                                </c:choose>
                                            </td>
                                            <th>총 주문금액</th>
                                            <td>${order.totalAmount}</td>
                                        </tr>
                                        <tr>
                                            <th>주문 이력</th>
                                            <td colspan="3">
                                                <button type="button" class="btn btn-sm btn-outline-dark">주문이력 보기</button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">배송 정보</h5>
                                    <table class="table table-bordered form-table mb-4">
                                        <colgroup>
                                            <col width="15%">
                                            <col width="35%">
                                            <col width="15%">
                                            <col width="35%">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>배송 요청일</th>
                                            <td>
                                                <div class="input-group input-group-sm">
                                                    <form:input path="requestDate" type="text" class="form-control" />
                                                    <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <i class="fa fa-calendar"></i>
                                                    </span>
                                                        <button type="button" class="btn btn-outline-primary update" data-field="requestDate">변경</button>
                                                    </div>
                                                </div>
                                            </td>
                                            <th>배송 유형</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.deliveryType == 'parcel'}">택배배송</c:when>
                                                    <c:when test="${order.deliveryType == 'direct'}">직배송</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>배송 담당자</th>
                                            <td>
                                                <div class="input-group input-group-sm">
                                                    <form:select path="deliverer" cssClass="form-control form-control-sm">
                                                        <form:option value="" label="--선택--" />
                                                        <form:options items="${deliverers}" itemValue="id" itemLabel="fullName" />
                                                    </form:select>
                                                    <div class="input-group-append">
                                                        <button type="button" class="btn btn-outline-primary update" data-field="deliverer">변경</button>
                                                    </div>
                                                </div>
                                            </td>
                                            <th>영업 담당자</th>
                                            <td>
                                                <div class="input-group input-group-sm">
                                                    <form:select path="salesMan" cssClass="form-control form-control-sm">
                                                        <form:option value="" label="--선택--" />
                                                        <form:options items="${salesMans}" itemValue="id" itemLabel="fullName" />
                                                    </form:select>
                                                    <div class="input-group-append">
                                                        <button type="button" class="btn btn-outline-primary update" data-field="salesMan">변경</button>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>요청사항</th>
                                            <td colspan="3">${order.requestMemo}</td>
                                        </tr>
                                        <tr>
                                            <th>추가 메모</th>
                                            <td colspan="3">
                                                <div class="input-group input-group-sm">
                                                    <form:textarea path="memo" class="form-control" rows="4" />
                                                    <div class="input-group-append">
                                                        <button type="button" class="btn btn-outline-primary update" data-field="memo">변경</button>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <h5 class="card-title">주문 상품 목록</h5>
                                    <div class="row mb-2">
                                        <div class="col-6">
                                            총 상품 수 : ${order.orderProducts.size()}개
                                        </div>
                                        <div class="col-6 text-right">
                                            <c:if test="${order.orderStatus == 'completed' && order.releaseStatus !='rejected' && order.releaseStatus != 'completed'}">
                                                <button type="button" class="btn btn-sm btn-outline-primary" data-toggle="modal" data-target="#selectProductsModal">
                                                    <i class="fa fa-plus"></i>상품 추가
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                    <table class="table table-middle text-center mb-4">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>상품코드</th>
                                            <th>대표 매입처</th>
                                            <th>상품명</th>
                                            <th>규격(단위)</th>
                                            <th>제조사(원산지)</th>
                                            <th>수량</th>
                                            <th>단가(원)</th>
                                            <th>합계금액(원)</th>
                                            <c:if test="${order.orderStatus == 'completed' && order.releaseStatus !='rejected' && order.releaseStatus != 'completed'}">
                                                <th>삭제</th>
                                            </c:if>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="orderProduct" items="${order.orderProducts}">
                                            <tr>
                                                <td>${orderProduct.id}</td>
                                                <td>${orderProduct.product.erpCode}</td>
                                                <td>${orderProduct.product.supplier.name}</td>
                                                <td>${orderProduct.product.name}</td>
                                                <td>${orderProduct.product.unit}</td>
                                                <td>${orderProduct.product.country}</td>
                                                <td>${orderProduct.qty}</td>
                                                <td>${orderProduct.price}</td>
                                                <td>${orderProduct.qty * orderProduct.price}</td>
                                                <c:if test="${order.orderStatus == 'completed' && order.releaseStatus !='rejected' && order.releaseStatus != 'completed'}">
                                                <td>
                                                    <button type="button" class="btn btn-sm btn-outline-danger">
                                                        <i class="fa fa-trash"></i> 삭제
                                                    </button>
                                                </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                        <tfoot class="thead-light">
                                        <tr>
                                            <th>합계</th>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>${order.orderProducts.size()}</td>
                                            <td></td>
                                            <td>${order.totalAmount}원</td>
                                            <c:if test="${order.orderStatus == 'completed' && order.releaseStatus !='rejected' && order.releaseStatus != 'completed'}">
                                                <td></td>
                                            </c:if>
                                        </tr>
                                        </tfoot>
                                    </table>
                                </form:form>
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
</div>
<div class="modal fade" id="selectProductsModal">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">

                </div>
                <button type="button" class="close text-right" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="searchForm" method="get">
                    <table class="table form-table table-bordered">
                        <colgroup>
                            <col style="width: 10%">
                            <col style="width: 57%">
                            <col>
                        </colgroup>
                        <tbody class="thead-light">
                        <th>즉시 검색</th>
                        <td>
                            <div class="row">
                                <div class="col-4">
                                    <form:select path="category" cssClass="form-control form-control-sm">
                                        <form:option value="" label="카테고리" />
                                        <form:options items="${categories}" itemValue="id" itemLabel="name" />
                                    </form:select>
                                </div>
                                <div class="col-8">
                                    <form:input path="keyword" cssClass="form-control form-control-sm" placeholder="상품명 또는 상품코드를 입력하세요." />
                                </div>
                            </div>
                        </td>
                        <td>
                            <button class="btn btn-outline-primary">검색</button>
                        </td>
                        </tbody>
                    </table>
                </form:form>
                <div class="row">
                    <div class="col-lg-7">
                        <div class="row mb-3">
                            <div class="col-6 text-primary">
                                <small>*해당 거래처에서 자주 주문한 상품 순입니다.</small>
                            </div>
                            <div class="col-6 text-right">전체 <span id="productsCount"></span>건</div>
                        </div>
                        <div class="list-wrap" style="height:460px; overflow: auto;">
                            <table id="productsTable" class="table table-hover text-center table-sm">
                                <colgroup>
                                    <col width="*">
                                    <col width="10%">
                                    <col width="15%">
                                    <col width="15%">
                                </colgroup>
                                <thead class="thead-light">
                                <tr>
                                    <th>상품명</th>
                                    <th>재고량</th>
                                    <th>매입 단가(원)</th>
                                    <th>판매 단가(원)</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="row mb-3">
                            <div class="col-6">선택상품 목록<span class="cor_primary" id="goodsSelectCountText">(전체 0건)</span></div>
                            <div class="col-6 text-right"><a class="btn btn-sm btn-outline-primary" id="resetCart" href="javascript:;" role="button"><i class="fa fa-undo"></i></a></div>
                        </div>
                        <div id="goods_select_wrap">
                            <div style="height:420px; overflow: auto;">
                                <ul class="list-group" id="shopping_cart">
                                </ul>
                            </div>
                            <div class="bg-light p-4">
                                <div class="row">
                                    <div class="col-6">합계금액</div>
                                    <div class="col-6 text-right"><span id="totalAmount">0</span>원</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                <button id="cartItemsSave" class="btn btn-primary">저장</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="confirmDelete">
    <div class="modal-dialog modal-dialog-sm">
        <div class="modal-content">
            <div class="modal-header bg-danger">
                <h5 class="modal-title text-light">주문 삭제</h5>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                해당 주문을 삭제 처리하시겠습니까?
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-danger confirm">확인</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="returnOrderModal">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header bg-danger">
                <div class="modal-title text-light">
                    반품 접수
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <h6>주문 상품 목록</h6>
                <table class="table text-center table-middle" id="returnProducts">
                    <thead class="thead-light">
                    <tr>
                        <th>#</th>
                        <th>상품코드</th>
                        <th>상품명</th>
                        <th>카테고리</th>
                        <th>규격(단위)</th>
                        <th>제조사(원산지)</th>
                        <th>주문수량</th>
                        <th class="w-10">반품수량</th>
                        <th>단가</th>
                        <th>총액</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${order.orderProducts}" var="orderProduct">
                        <tr data-id="${orderProduct.id}">
                            <td>${orderProduct.id}</td>
                            <td>${orderProduct.product.erpCode}</td>
                            <td>${orderProduct.product.name}</td>
                            <td>${orderProduct.product.category.name}</td>
                            <td>${orderProduct.product.standard}<br>(${orderProduct.product.unit})</td>
                            <td>${orderProduct.product.makerName}<br>(${orderProduct.product.country})</td>
                            <td class="qty">${orderProduct.qty}</td>
                            <td>
                                <input class="form-control form-control-sm" type="number" name="qty" value="0">
                            </td>
                            <td>${orderProduct.price}</td>
                            <td>${orderProduct.price * orderProduct.qty}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
                <button class="btn btn-outline-primary" id="returnConfirm">접수완료</button>
            </div>
        </div>
    </div>
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
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    var token = $('meta[name="_csrf"]').attr('content');

    $('#requestDate').datepicker({
        dateFormat: 'yy-mm-dd'
    });

    $('#confirmDelete .confirm').click(function () {
        var url = $('#order_delete').attr('href');
        window.location.href = url;
    });

    $('#order_delete').click(function (e) {
        e.preventDefault();
        $('#confirmDelete').modal('show');
    });

    $('.change_release_status').on('click', function() {
        var status = $(this).data('status');
        var id = $(this).data('id');
        $.ajax({
            type: 'POST',
            url: '/orders/change_status',
            headers: {
                'X-CSRF-TOKEN': token
            },
            data: {
                id: id,
                action: 'release',
                status: status
            },
            beforeSend: function() {
                $("#overlay").fadeIn(300);
            },
            success: function (data) {
                window.location.href = '/orders';
            }
        }).done(function () {
            setTimeout(function(){
                $("#overlay").fadeOut(300);
            },500);
        });
    });

    $('.update').on('click', function () {
        var field = $(this).data('field');
        var value = $(this).closest('.input-group').find('.form-control').val();
        var id = $('input[name="id"]').val();
        $.ajax({
            type: 'POST',
            url: '/orders/' + id + '/update',
            contentType: 'application/json',
            accept: 'text/plain',
            headers: {
                'X-CSRF-TOKEN': token
            },
            data: JSON.stringify({
                field: field,
                value: value
            }),
            beforeSend: function() {
                $("#overlay").fadeIn(300);
            },
            success: function(data) {
                toastr.success(data.message);
            },
            error: function(xhr, statusCode, error) {

            }
        }).done(function () {
            setTimeout(function(){
                $("#overlay").fadeOut(300);
            },500);
        });

    });

    $('#returnProducts tbody input[name="qty"]').on('keyup', function() {
        var returnQty = parseFloat($(this).val());
        var orderQty = parseFloat($(this).closest('tr').find('.qty').html());
        if (returnQty > orderQty) {
            toastr.error('반품은 주문 수량 내에서만 가능합니다.');
            $(this).val(orderQty);
        }
    });

    $('#returnConfirm').on('click', function () {
        var returnProducts = [];
        $('#returnProducts tbody tr').each(function() {
            var orderProductId = $(this).data('id');
            var returnQty = parseFloat($(this).find('input[name="qty"]').val());
            if (returnQty > 0) {
                returnProducts.push({
                    orderProduct: orderProductId,
                    qty: returnQty,
                })
            }
        });
        console.log(returnProducts);

        var id = $('input[name="id"]').val();

        if (returnProducts.length > 0) {
            $.ajax({
                type: 'POST',
                url: '/orders/' + id + '/return',
                contentType: 'application/json',
                accept: 'text/plain',
                headers: {
                    'X-CSRF-TOKEN': token
                },
                data: JSON.stringify(returnProducts),
                beforeSend: function() {
                    $("#overlay").fadeIn(300);
                },
                success: function(data) {
                    toastr.success(data.message);
                    window.location.href = "/return_orders"
                },
                error: function(xhr, statusCode, error) {
                    toastr.error(error);
                }
            }).done(function () {
                setTimeout(function(){
                    $("#overlay").fadeOut(300);
                },500);
            });
        } else {
            toastr.error('반품 접수할 상품 수량을 입력해주세요.');
        }
    });

    function printOrder() {
        var order_id = $('input[name="id"]').val();
        window.open('/orders/print_order?ids='+order_id, "거래명세표", "width=1301, height=700, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
    }
</script>
</body>
</html>