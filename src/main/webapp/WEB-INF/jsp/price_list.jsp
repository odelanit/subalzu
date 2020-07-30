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
    <link href="${contextPath}/resources/toastr-2.1.4/toastr.min.css" rel="stylesheet" type="text/css"/>
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
                    <li class="mm-active">
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
                            <li class="mm-active">
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
                                <li class="breadcrumb-item">단가 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">상품 단가 일괄 적용</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">상품 단가 일괄 적용</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form:form method="get" modelAttribute="form">
                                    <table class="table form-table table-bordered mb-5">
                                        <colgroup>
                                            <col style="width: 150px;">
                                            <col style="width: 570px;">
                                            <col>
                                        </colgroup>
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>키워드 검색</th>
                                            <td>
                                                <div class="form-inline">
                                                    <form:select path="field" class="form-control form-control-sm mr-2 w-25">
                                                        <form:option value="name">상품 명</form:option>
                                                        <form:option value="erpCode">상품 코드</form:option>
                                                    </form:select>
                                                    <form:input class="form-control form-control-sm w-50" path="keyword" placeholder="검색어를 입력해주세요" />
                                                    <form:hidden path="page" />
                                                </div>
                                            </td>
                                            <td>
                                                <button class="btn btn-primary btn-sm">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline" id="imSearch">
                                                    <form:select class="form-control form-control-sm mr-2 w-20" path="category">
                                                        <form:option value="" label="1차 카테고리" />
                                                        <form:options items="${categories}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm w-20" path="subcategory">
                                                        <form:option value="" label="2차 카테고리" />
                                                        <form:options items="${subcategories}" itemValue="id" itemLabel="name" />
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row align-items-center">
                                    <div class="col-lg-6">

                                    </div>
<%--                                    <div class="col-lg-6 text-lg-right">--%>
<%--                                        <a class="btn btn-sm btn-outline-primary" href="/prices/fixed-price-rate"--%>
<%--                                           data-toggle="tooltip"--%>
<%--                                           data-placement="top"--%>
<%--                                           title="정액/정률 설정값을 변경할 수 있습니다. 적용하실 상품을 먼저 검색하여 사용하시는 것을 권장합니다.">--%>
<%--                                            정액/정률 관리--%>
<%--                                        </a>--%>
<%--                                    </div>--%>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-6">
                                        <span>전체 ${productPage.totalElements}건</span>
                                    </div>
                                    <div class="col-6 text-right">
                                        <button type="button" class="btn btn-sm btn-outline-primary" id="applyAll">전체 적용</button>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <table class="table table-sm text-center table-middle" id="products">
                                        <colgroup>
                                            <col>
                                            <col>
                                            <col>
                                            <col>
                                            <col>
                                            <col>
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                            <col style="width: 120px;">
                                            <col style="width: 70px;">
                                        </colgroup>
                                        <thead class="thead-light">
                                        <tr>
                                            <th><input type="checkbox" id="selectAll"></th>
                                            <th>#</th>
                                            <th>상품명</th>
                                            <th>카테고리</th>
                                            <th>규격(단위)</th>
                                            <th>제조사(원산지)</th>
                                            <th>매입단가</th>
                                            <th>직배송단가</th>
                                            <th>택배배송단가</th>
                                            <th>기본단가</th>
                                            <th>적용</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="product" items="${products}">
                                            <tr data-id="${product.id}">
                                                <td>
                                                    <input type="checkbox" class="check" value="${product.id}">
                                                </td>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>${product.category.name}</td>
                                                <td>${product.standard}<br>(${product.unit})</td>
                                                <td>${product.makerName}<br>(${product.country})</td>
                                                <td>
                                                    <input class="form-control form-control-sm buyPrice" type="number" value="${product.buyPrice}">
                                                </td>
                                                <td>
                                                    <input class="form-control form-control-sm directPrice" type="number" value="${product.directPrice}">
                                                </td>
                                                <td>
                                                    <input class="form-control form-control-sm parcelPrice" type="number" value="${product.parcelPrice}">
                                                </td>
                                                <td>
                                                    <input class="form-control form-control-sm sellPrice" type="number" value="${product.sellPrice}">
                                                </td>
                                                <td>
                                                    <button type="button" class="apply btn btn-outline-primary btn-sm">적용</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
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
<!-- END wrapper -->

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $(document).ready(function () {
        var token = $("meta[name='_csrf']").attr("content");

        $('#imSearch').on('change', function() {
            $('#form').submit();
        });

        $('.apply').on('click', function() {
            var productId = $(this).closest('tr').data('id');
            var buyPrice = $(this).closest('tr').find('.buyPrice').val();
            var directPrice = $(this).closest('tr').find('.directPrice').val();
            var parcelPrice = $(this).closest('tr').find('.parcelPrice').val();
            var sellPrice = $(this).closest('tr').find('.sellPrice').val();

            if (productId && buyPrice && directPrice && parcelPrice && sellPrice) {
                if (parseInt(buyPrice) <= 0 || parseInt(directPrice) <= 0 || parseInt(parcelPrice) <= 0 || parseInt(sellPrice) <= 0) {
                    toastr.error('정수값을 입력하세요.');
                } else {
                    $.ajax({
                        type: 'POST',
                        url: '/prices/update',
                        headers: {
                            'X-CSRF-TOKEN': token
                        },
                        data: {
                            product: productId,
                            buyPrice: buyPrice,
                            directPrice: directPrice,
                            parcelPrice: parcelPrice,
                            sellPrice: sellPrice
                        },
                        beforeSend: function() {
                            $("#overlay").fadeIn(300);
                        },
                        success: function(data) {
                            toastr.success(data.message);
                        }
                    }).done(function () {
                        setTimeout(function(){
                            $("#overlay").fadeOut(300);
                        },500);
                    });
                }
            } else {
                toastr.error('값을 정확히 입력하세요.');
            }
        });

        $('#selectAll').on('change', function () {
            $('#products tbody tr .check').prop('checked', $(this).prop('checked'));
        });

        $('#applyAll').on('click', function () {
            var checkedElements = $('#products tbody tr .check:checked');
            if (checkedElements.length <= 0) {
                toastr.error('변경 입력한 단가가 없습니다.');
                return false;
            }
            var priceInfos = [];
            checkedElements.each(function() {
                var productId = $(this).closest('tr').data('id');
                var buyPrice = $(this).closest('tr').find('.buyPrice').val();
                var directPrice = $(this).closest('tr').find('.directPrice').val();
                var parcelPrice = $(this).closest('tr').find('.parcelPrice').val();
                var sellPrice = $(this).closest('tr').find('.sellPrice').val();
                var priceInfo = {
                    product: productId,
                    buyPrice: buyPrice,
                    directPrice: directPrice,
                    parcelPrice: parcelPrice,
                    sellPrice: sellPrice
                };
                priceInfos.push(priceInfo);
            });
            var invalidInfo = priceInfos.find(info => parseInt(info.buyPrice) <= 0 || parseInt(info.directPrice) <= 0 || parseInt(info.parcelPrice) <= 0 || parseInt(info.sellPrice) <= 0);
            if (invalidInfo) {
                toastr.error('정수값을 입력하세요.');
                return false;
            }
            $.ajax({
                type: 'POST',
                url: '/prices/update_all',
                contentType: 'application/json',
                accept: 'text/plain',
                headers: {
                    'X-CSRF-TOKEN': token,
                },
                data: JSON.stringify(priceInfos),
                beforeSend: function() {
                    $("#overlay").fadeIn(300);
                },
                success: function(data) {
                    toastr.success(data.message);
                }
            }).done(function () {
                setTimeout(function(){
                    $("#overlay").fadeOut(300);
                },500);
            });
        });
    })
</script>
</body>
</html>