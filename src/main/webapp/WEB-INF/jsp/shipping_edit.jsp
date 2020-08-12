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
    <meta name="_csrf" content="${_csrf.token}"/>

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
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
                                <li class="breadcrumb-item"><a href="/shipping/">발주 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">발주 수정</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">발주 수정</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="shippingForm" method="post">
                                    <h5 class="card-title">발주 정보</h5>
                                    <table class="table form-table table-bordered">
                                        <colgroup>
                                            <col width="15%">
                                            <col width="35%">
                                            <col width="15%">
                                            <col width="35%">
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <th class="required"><span>매입처</span></th>
                                            <td>
                                                <form:select class="form-control" path="supplier">
                                                    <form:option value="" label="-- 매입처 선택 --" />
                                                    <form:options items="${suppliers}" itemValue="id" itemLabel="name" />
                                                </form:select>
                                            </td>
                                            <th class="required"><span>담당자</span></th>
                                            <td>
                                                <form:select class="form-control" path="user">
                                                    <form:option value="" label="--담당자 선택 --" />
                                                    <form:options items="${employees}" itemValue="id" itemLabel="fullName" />
                                                </form:select>
                                            </td>
                                        </tr>
                                        <spring:bind path="deliverBy">
                                            <tr>
                                                <th class="required"><span>납기일자</span></th>
                                                <td colspan="3">
                                                    <div class="input-group w-25">
                                                        <form:input class="form-control" path="deliverBy" />
                                                        <div class="input-group-append">
                                                    <span class="input-group-text">
                                                        <i class="fa fa-calendar"></i>
                                                    </span>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <tr>
                                            <th>비고</th>
                                            <td colspan="3">
                                                <form:textarea path="description" class="form-control" rows="4" />
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <h5>발주 상품</h5>
                                    <div class="row mb-3">
                                        <div class="col-6">
                                            전체 ${shippingForm.supplyOrderProducts.size()}건
                                        </div>
<%--                                        <div class="col-6 text-right">--%>
<%--                                            <button type="button" class="btn btn-outline-primary btn-sm" id="addProducts">상품 추가</button>--%>
<%--                                        </div>--%>
                                    </div>
                                    <table class="table text-center table-middle mb-5" id="products">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>상품명</th>
                                            <th>카테고리</th>
                                            <th>규격(단위)</th>
                                            <th>제조사(원산지)</th>
                                            <th>수량</th>
                                            <th>매입단가(원)</th>
                                            <th>합계금액(원)</th>
<%--                                            <th>삭제</th>--%>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="orderProduct" items="${shippingForm.supplyOrderProducts}">
                                            <tr>
                                                <td>${orderProduct.id}</td>
                                                <td>${orderProduct.product.name}</td>
                                                <td>${orderProduct.product.category.name}</td>
                                                <td>${orderProduct.product.standard}<br>(${orderProduct.product.unit})</td>
                                                <td>${orderProduct.product.makerName}<br>(${orderProduct.product.country})</td>
                                                <td>${orderProduct.qty}</td>
                                                <td>${orderProduct.price}</td>
                                                <td>${orderProduct.totalAmount}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                        <tfoot class="thead-light">
                                        </tfoot>
                                    </table>
                                    <div class="form-group text-center">
                                        <a href="/shipping/" class="btn btn-outline-secondary">목록으로</a>
                                        <button class="btn btn-primary">저장하기</button>
                                    </div>
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

    <!-- ============================================================== -->
    <!-- End Page content -->
    <!-- ============================================================== -->


</div>
<!-- END wrapper -->
<div class="modal fade" id="productsModal">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">상품 선택</div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <table class="table table-sm table-hover text-center" id="selectProducts">
                    <thead class="thead-light">
                    <tr>
                        <th></th>
                        <th>상품코드</th>
                        <th>상품명</th>
                        <th>카테고리</th>
                        <th>규격(단위)</th>
                        <th>제조사(원산지)</th>
                        <th>매입단가</th>
                        <th>부가세여부</th>
                    </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">닫기</button>
                <button class="btn btn-primary" id="confirmButton">확인</button>
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
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    var allProducts = [];
    var selectedProducts = [];
    $(document).ready(function() {
        $('#deliverBy').datepicker({
            dateFormat: 'yy-mm-dd'
        });

    });

</script>
</body>
</html>