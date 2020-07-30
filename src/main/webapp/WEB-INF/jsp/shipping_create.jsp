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
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
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
                            <li>
                                <a href="/order_products">상품별 주문 목록</a>
                            </li>
                            <li>
                                <a href="/return_orders">반품 내역</a>
                            </li>
                        </ul>
                    </li>
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 매입 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item"><a href="/shipping/">발주 관리</a></li>
                                <li class="breadcrumb-item active" aria-current="page">신규 발주 등록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">신규 발주 등록</h4>
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
                                            전체 건
                                        </div>
                                        <div class="col-6 text-right">
                                            <button type="button" class="btn btn-outline-primary btn-sm" id="addProducts">상품 추가</button>
                                        </div>
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
                                            <th>삭제</th>
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
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

        $('#addProducts').on('click', function() {
            var supplier = $('#supplier').val();
            if (supplier === "") {
                toastr.error('매입처 선택을 먼저 해주셔야 상품 선택이 가능합니다.');
                return false;
            }
            $.ajax({
                type: 'GET',
                url: '/products/data?supplier=' + supplier,
                success: function(data) {
                    var tableElement = $('#selectProducts');
                    allProducts = data.products;
                    var tbodyHtml = '';
                    allProducts.forEach(function (product, index) {
                        var trHtml =
                            '<tr data-id="' + product.id + '">' +
                                '<td><input type="checkbox" value="' + product.id + '" /></td>' +
                                '<td>' + product.erpCode + '</td>' +
                                '<td>' + product.name + '</td>' +
                                '<td>' + (product.category ? product.category.name : '') + '</td>' +
                                '<td>' + product.standard + '(' + product.unit + ')' + '</td>' +
                                '<td>' + product.makerName + '(' + product.country + ')' +  '</td>' +
                                '<td>' + product.buyPrice + '</td>' +
                                '<td>' + (product.tax ? '과세' : '면세') + '</td>' +
                            '</tr>';
                        tbodyHtml += trHtml;
                    });
                    tableElement.find('tbody').html(tbodyHtml);
                    $('#productsModal').modal();
                }
            })
        });

        $('#selectProducts tbody').on('click', 'tr', function() {
            var trElement = $(this);
            var checkboxEl = trElement.find('input[type="checkbox"]');
            checkboxEl.prop('checked', !checkboxEl.prop('checked'));
            var productId = trElement.data('id');
            var cartItem = selectedProducts.find(product => product.id === productId);
            var selectedProduct = allProducts.find(product => product.id === productId);
            if (checkboxEl.prop('checked')) {
                cartItem = selectedProduct;
                cartItem.qty = 1;
                selectedProducts.push(cartItem);
            } else {
                selectedProducts = selectedProducts.filter(product => product.id != productId);
            }
        });

        $('#confirmButton').on('click', function () {
            var tableElement = $('#products');
            var tbodyHtml = '';
            var tfootHtml = '';
            var sumQty = 0;
            var totalFunds = 0;
            selectedProducts.forEach(function (product, index) {
                var subTotal = product.qty * product.buyPrice;
                sumQty += product.qty;
                totalFunds += subTotal;
                var trHtml =
                    '<tr data-id="' + product.id + '">' +
                    '<td>' + product.id + '<input name="product" value="' + product.id + '" type="hidden" /></td>' +
                    '<td>' + product.name + '</td>' +
                    '<td>' + (product.category ? product.category.name : '') + '</td>' +
                    '<td>' + product.standard + '(' + product.unit + ')' + '</td>' +
                    '<td>' + product.makerName + '(' + product.country + ')' +  '</td>' +
                    '<td><input class="form-control" type="number" name="qty" value="' + product.qty + '"/></td>' +
                    '<td><input class="form-control" type="number" name="price" value="' + product.buyPrice + '"/></td>' +
                    '<td class="subtotal">' + subTotal + '</td>' +
                    '<td><button type="button" class="btn btn-sm btn-danger deleteProduct"><i class="fa fa-trash"></i></button></td>' +
                    '</tr>';
                tbodyHtml += trHtml;
            });
            tfootHtml =
                '<tr>' +
                '<th>합계</th>' +
                '<td></td>' +
                '<td></td>' +
                '<td></td>' +
                '<td></td>' +
                '<td class="sumQty">' + sumQty + '</td>' +
                '<td></td>' +
                '<td class="total">' + totalFunds + '</td>' +
                '<td></td>' +
                '</tr>';
            tableElement.find('tbody').html(tbodyHtml);
            tableElement.find('tfoot').html(tfootHtml);
            $('#productsModal').modal('hide');
        });

        $('#products tbody').on('keyup', 'input', function() {
            var trElement = $(this).closest('tr');
            var qty = parseFloat(trElement.find('input[name="qty"]').val());
            var buyPrice = parseFloat(trElement.find('input[name="price"]').val());
            trElement.find('.subtotal').html(qty * buyPrice);
            var sumQty = 0;
            var totalFunds = 0;
            $('#products tbody tr').each(function() {
                var qty = parseFloat($(this).find('input[name="qty"]').val());
                var buyPrice = parseFloat($(this).find('input[name="price"]').val());
                totalFunds += qty * buyPrice;
                sumQty += qty;
            });
            $('#products tfoot .sumQty').html(sumQty);
            $('#products tfoot .total').html(totalFunds);
        })

        $('#shippingForm').on('submit', function(e) {
            e.preventDefault();
            var supplier = $(this).find('select[name="supplier"]').val();
            var user = $(this).find('select[name="user"]').val();
            var deliverBy = $(this).find('input[name="deliverBy"]').val();
            var description = $(this).find('textarea[nam="description"]').val();
            var supplyOrderProducts = [];

            $('#products tbody tr').each(function() {
                var product = $(this).find('input[name="product"]').val();
                var qty = $(this).find('input[name="qty"]').val();
                var price = $(this).find('input[name="price"]').val();
                var totalAmount = parseInt(qty) * parseInt(price);
                supplyOrderProducts.push({
                    product: product,
                    qty: qty,
                    price: price,
                    totalAmount: totalAmount.toString()
                })
            });

            var supplyOrder = {
                supplier: supplier,
                user: user,
                deliverBy: deliverBy,
                description: description,
                supplyOrderProducts: supplyOrderProducts
            };

            var token = $("meta[name='_csrf']").attr("content");

            $.ajax({
                type: 'POST',
                url: '/shipping/create',
                contentType: 'application/json',
                accept: 'text/plain',
                headers: {
                    'X-CSRF-TOKEN': token,
                },
                data: JSON.stringify(supplyOrder),
                beforeSend: function() {
                    $("#overlay").fadeIn(300);
                },
                success: function(data) {
                    toastr.success(data.message);
                    window.location.href = "/shipping";
                }
            }).done(function () {
                setTimeout(function(){
                    $("#overlay").fadeOut(300);
                },500);
            });
        })
    });

</script>
</body>
</html>