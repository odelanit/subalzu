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

    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/metismenu/metisMenu.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="/profile" class="nav-link"><i data-feather="user"></i>&nbsp;<c:out value="${pageContext.request.remoteUser}"/> 정보보기</a>
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
                            <li class="mm-active">
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
                                <div class="py-5">
                                    <h5 class="text-center">주문번호 ${order.orderCode} 상세내역입니다.</h5>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <a href="/orders/${order.id}/delete" class="btn btn-sm btn-outline-danger" id="order_delete">
                                            <i class="fa fa-trash"></i> 주문삭제
                                        </a>
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 'completed' && order.releaseStatus == 'progress'}">
                                                <button class="btn btn-sm btn-warning">주문취소</button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <button class="btn btn-sm btn-secondary">거래명세표</button>
                                        <c:choose>
                                            <c:when test="${order.releaseStatus == 'progress'}">
                                                <button class="btn btn-sm btn-outline-primary change_release_status" data-id="${order.id}" data-status="completed">
                                                    <i class="fa fa-check"></i>출고완료
                                                </button>
                                                <button class="btn btn-sm btn-outline-warning change_release_status" data-id="${order.id}" data-status="rejected">
                                                    <i class="fa fa-times"></i>출고거절
                                                </button>
                                            </c:when>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${order.releaseStatus == 'completed' && order.orderStatus == 'completed'}">
                                                <button class="btn btn-sm btn-outline-warning">
                                                    반품접수
                                                </button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <hr>
                                <h6 class="card-title">주문 정보 <span class="text-primary">(주문상태: ${order.orderStatus} / 출고상태: ${order.releaseStatus})</span></h6>
                                <table class="table form-table table-bordered">
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
                                        <td>${order.createdAt}</td>
                                        <th>담당자/연락처</th>
                                        <td>${order.shop.owner.fullName} / ${order.shop.owner.phone}</td>
                                    </tr>
                                    <tr>
                                        <th>거래처 주소</th>
                                        <td colspan="3">${order.shop.addressLine1} ${order.shop.addressLine2}</td>
                                    </tr>
                                    <tr>
                                        <th>결제수단</th>
                                        <td>${order.shop.paymentMethod}</td>
                                        <th>총 주문금액</th>
                                        <td>${order.totalAmount}</td>
                                    </tr>
                                    <tr>
                                        <th>주문 이력</th>
                                        <td colspan="3">
                                            <button type="button" class="btn btn-outline-primary">주문이력 보기</button>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <hr>
                                <h6 class="card-title">배송 정보</h6>
                                <table class="table table-bordered form-table">
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
                                            <input type="text" class="form-control" id="request-date" value="${order.requestDate}">
                                        </td>
                                        <th>배송 유형</th>
                                        <td>${order.deliveryType}</td>
                                    </tr>
                                    <tr>
                                        <th>배송 담당자</th>
                                        <td>${order.deliverer.fullName}</td>
                                        <th>영업 담당자</th>
                                        <td>${order.salesMan.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th>요청사항</th>
                                        <td colspan="3">${order.requestMemo}</td>
                                    </tr>
                                    <tr>
                                        <th>추가 메모</th>
                                        <td colspan="3">
                                            <textarea class="form-control">${order.memo}</textarea>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <hr>
                                <h6 class="card-title">주문 상품 목록</h6>
                                <table class="table table-sm">
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
                                        <th>삭제</th>
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
                                            <td></td>
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
<!-- END wrapper -->

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $('#request-date').datepicker({
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
        var token = $('meta[name="_csrf"]').attr('content');
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
            success: function (data) {
                window.location.href = '/orders';
            }
        })
    })
</script>
</body>
</html>