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
        <div class="media user-profile mt-2 mb-2">
            <div class="media-body">
                <a href="/company">
                    <h4 class="pro-user-name mt-0 mb-0">${currentCompany.vendorName}</h4>
                    <span class="pro-user-desc">기업정보보기</span>
                </a>
            </div>
        </div>
        <div class="sidebar-content">
            <!--- Sidemenu -->
            <div id="sidebar-menu" class="slimscroll-menu">
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
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 재고 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item">재고 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">입/출고 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">입/출고 관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
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
                                                    <form:select path="qtyStatus"
                                                                 cssClass="form-control w-20 form-control-sm mr-2">
                                                        <form:option value="" label="재고상태"/>
                                                        <form:option value="0" label="재고부족"/>
                                                        <form:option value="1" label="재고충분"/>
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
                                <div class="row align-items-center mb-3">
                                    <div class="col-6">
                                        전체 ${productPage.totalElements}건
                                    </div>
                                    <div class="col-6 text-right">
                                        <button class="btn btn-sm btn-outline-primary" id="changeAll">
                                            <i class="fa fa-exchange"></i>전체 변경
                                        </button>
                                    </div>
                                </div>
                                <table class="table table-middle text-center" id="products">
                                    <colgroup>
                                        <col style="width: 1%">
                                        <col style="width: 3%">
                                        <col style="width: 5%">
                                        <col style="width: 12%">
                                        <col style="width: 10%">
                                        <col style="width: 8%">
                                        <col style="width: 8%">
                                        <col style="width: 8%">
                                        <col style="width: 11%">
                                        <col>
                                        <col style="width: 10%">
                                    </colgroup>
                                    <thead class="thead-light">
                                    <tr>
                                        <th><input id="selectAll" type="checkbox"></th>
                                        <th>#</th>
                                        <th>상품코드</th>
                                        <th>썸네일</th>
                                        <th>상품명</th>
                                        <th>규격(단위)</th>
                                        <th>제조사(원산지)</th>
                                        <th>현재 재고</th>
                                        <th>구분</th>
                                        <th>수량</th>
                                        <th>변경 후 재고</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${products}" var="product">
                                        <tr data-id="${product.id}">
                                            <td><input type="checkbox" value="${product.id}"></td>
                                            <td>${product.id}</td>
                                            <td>${product.erpCode}</td>
                                            <td><c:if test="${not empty product.imageUrl}"><img style="max-width: 150px;"
                                                                                                class="img-thumbnail"
                                                                                                src="${product.imageUrl}"></c:if>
                                            </td>
                                            <td>${product.name}</td>
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
                                            <td class="currentQty">
                                                <c:choose>
                                                    <c:when test="${product.useDecimal == true}">
                                                        ${product.qty}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:parseNumber value="${product.qty}" integerOnly="true" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <select class="custom-select custom-select-sm">
                                                    <option value="manual_input">수동입고</option>
                                                    <option value="manual_output">수동출고</option>
                                                    <option value="discard_output">폐기출고</option>
                                                    <option value="return_output">반품출고</option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="input-group input-group-sm">
                                                    <input class="form-control" type="number" value="0">
                                                    <div class="input-group-prepend">
                                                        <button type="button" class="btn btn-outline-primary modify">변경</button>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="modifiedQty">
                                                <c:choose>
                                                    <c:when test="${product.useDecimal == true}">
                                                        ${product.qty}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:parseNumber value="${product.qty}" integerOnly="true" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                    <c:if test="${productPage.totalPages > 1}">
                                        <tfoot>
                                        <tr>
                                            <td colspan="11">
                                                <nav>
                                                    <ul class="pagination justify-content-center">
                                                        <c:choose>
                                                            <c:when test="${productPage.hasPrevious()}">
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
                                                        <c:forEach var="i" begin="1" end="${productPage.totalPages}">
                                                            <li class="page-item <c:if test="${i == currentPage}">active</c:if>"><a href="javascript:;" class="page-link" data-page="${i}">${i}</a></li>
                                                        </c:forEach>
                                                        <c:choose>
                                                            <c:when test="${productPage.hasNext()}">
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

        $('#selectAll').on('change', function (e) {
            $('#products tbody input[type="checkbox"]').prop('checked', $(this).prop('checked'));
        });

        $('#products tbody tr td:first-child').on('click', function (e) {
            var checkboxElement = $(this).find('input[type="checkbox"]');
            checkboxElement.prop('checked', !checkboxElement.prop('checked'));
        });

        $('#products tbody tr td input[type="checkbox"]').on('change', function (e) {
            var checkboxElement = $(this);
            checkboxElement.prop('checked', !checkboxElement.prop('checked'));
        });

        function changeQty(target, currentQty, action, diff) {
            var modifiedQty = 0
            if (action.indexOf('input') >= 0) {
                modifiedQty = currentQty + diff;
            } else if (action.indexOf('output') >= 0) {
                modifiedQty = currentQty - diff;
            }
            $(target).closest('tr').find('.modifiedQty').text(modifiedQty);
        }

        $('#products tbody tr input[type="number"]').on('keyup', function() {
            var currentQty = $(this).closest('tr').find('.currentQty').html();
            currentQty = parseFloat(currentQty);
            var action = $(this).closest('tr').find('select').val();
            var diff = parseFloat($(this).val());
            if (diff) {
                changeQty(this, currentQty, action, diff);
            }
        });

        $('#products tbody tr select').on('change', function() {
            var currentQty = $(this).closest('tr').find('.currentQty').html();
            currentQty = parseFloat(currentQty);
            var action = $(this).closest('tr').find('select').val();
            var diff = parseFloat($(this).closest('tr').find('input[type="number"]').val());
            if (diff) {
                changeQty(this, currentQty, action, diff);
            }
        });

        $('#products tbody tr button').on('click', function() {
            var diff = parseFloat($(this).closest('tr').find('input[type="number"]').val());
            var action = $(this).closest('tr').find('select').val();
            var id = $(this).closest('tr').data('id')
            if (diff > 0) {
                $.ajax({
                    type: 'POST',
                    url: '/products/change_qty',
                    headers: {
                        'X-CSRF-TOKEN': token,
                    },
                    data: {
                        product: id,
                        diff: diff,
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
            } else {
                toastr.error('변경할 재고 수량을 입력해주세요.');
            }
        });

        $('#imSearch select').on('change', function() {
            $('#form').submit();
        });

        $('#changeAll').on('click', function () {
            var records = [];
            $('#products tbody tr input[type="checkbox"]:checked').each(function(index) {
                var diff = $(this).closest('tr').find('input[type="number"]').val();
                if (parseFloat(diff) <= 0) {
                    return;
                }
                var action = $(this).closest('tr').find('select').val();
                var record = {
                    product: $(this).val(),
                    diff: diff,
                    action: action
                }
                records.push(record);
            });

            if (records.length === 0) {
                toastr.error("변경할 재고건이 없습니다.");
            } else {
                $.ajax({
                    type: 'POST',
                    url: '/products/change_qty_all',
                    contentType: 'application/json',
                    accept: 'text/plain',
                    headers: {
                        'X-CSRF-TOKEN': token,
                    },
                    data: JSON.stringify(records),
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
    });
</script>
</body>
</html>