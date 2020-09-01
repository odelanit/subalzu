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
                                    <div class="col-lg-6 text-lg-right">
                                        <a class="btn btn-sm btn-outline-primary" href="/fixed_price_rate/"
                                           data-toggle="tooltip"
                                           data-placement="top"
                                           title="정액/정률 설정값을 변경할 수 있습니다. 적용하실 상품을 먼저 검색하여 사용하시는 것을 권장합니다.">
                                            정액/정률 관리
                                        </a>
                                    </div>
                                </div>
                                <hr>
                                <div id="price-table">
                                    <div class="row">
                                        <div class="col-6">
                                            <span>전체 {{ totalElements }}건</span>
                                        </div>
                                        <div class="col-6 text-right">
                                            <button type="button" class="btn btn-sm btn-outline-excel" data-toggle="modal" data-target="#excelUploadModal"><i class="fa fa-file-excel"></i> 단가 일괄 수정</button>
                                            <button type="button" class="btn btn-sm btn-outline-primary" @click="applyAll"><span class="fa fa-exchange mr-1"></span>전체 적용</button>
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <table class="table table-sm text-center table-middle" id="products">
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
                                            <tr v-for="product in products">
                                                <td>
                                                    <input type="checkbox" class="check" value="${product.id}">
                                                </td>
                                                <td>${product.id}</td>
                                                <td>${product.name}</td>
                                                <td>${product.category.name}</td>
                                                <td>${product.standard}<c:if test="${not empty product.unit}"><br>(${product.unit})</c:if></td>
                                                <td>${product.makerName}<c:if test="${not empty product.country}"><br>(${product.country})</c:if></td>
                                                <td>
                                                    <input class="form-control form-control-sm text-right buyPrice" type="number" value="${product.buyPrice}">
                                                </td>
                                                <td>
                                                    <input class="form-control form-control-sm text-right directPrice" type="number" value="${product.directPrice}">
                                                </td>
                                                <td>
                                                    <input class="form-control form-control-sm text-right parcelPrice" type="number" value="${product.parcelPrice}">
                                                </td>
                                                <td>
                                                    <input class="form-control form-control-sm text-right sellPrice" type="number" value="${product.sellPrice}">
                                                </td>
                                                <td>
                                                    <button type="button" class="apply btn btn-outline-primary btn-sm">적용</button>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
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
</div>
<div class="modal fade" id="excelUploadModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">
                    상품 일괄 수정
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p><strong>단가 다운 로드 > 엑셀 파일 작성 > 등록 </strong> 버튼을 클릭하여 등록합니다.<br>
                    <small>* 단가만 수정 가능합니다. <span class="text-danger">※ 단가 이외의 항목을 수정하면 오류가 발생하여 수정을 할 수 없습니다.</span></small>
                </p>
                <table class="table">
                    <tbody class="thead-light">
                    <tr>
                        <th>양식 다운 로드</th>
                        <td>
                            <a href="/prices/download" class="btn btn-sm btn-outline-primary"><i
                                    class="fa fa-download"></i> 다운로드</a>
                        </td>
                    </tr>
                    <tr>
                        <th>파일 업로드</th>
                        <td>
                            <form:form method="post" action="/prices/upload" id="uploadEditForm">
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
<!-- END wrapper -->

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/toastr-2.1.4/toastr.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script src="${contextPath}/resources/js/vue.js"></script>
<script src="${contextPath}/resources/js/axios.js"></script>
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
    })
</script>
<script>
    var priceTable = new Vue({
        el: '#price-table',
        data: {
            totalElements: 0,
            products: []
        },
        mounted() {
            console.log(window.location.pathname + window.location.search);
            axios.get(window.location.pathname + '/data' + window.location.search)
                .then(res => res.data)
                .then(data => {
                    console.log(data);
                    this.totalElements = data.productPage.totalElements;
                })
                .catch(error => {
                    console.error(error);
                })
        },
        methods: {
            applyAll: function () {

            }
        }
    })
</script>
</body>
</html>