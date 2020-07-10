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
    <link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>

    <link href="${contextPath}/resources/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${contextPath}/resources/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${contextPath}/resources/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css"
          rel="stylesheet" type="text/css"/>

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
                <a href="/profile" class="nav-link"><i data-feather="user"></i>&nbsp;<c:out
                        value="${pageContext.request.remoteUser}"/> 정보보기</a>
            </li>
            <li class="nav-item d-none d-lg-block">
                <a href="javascript:;" class="nav-link"
                   onclick="document.getElementById('logout-form').submit();">로그아웃</a>
            </li>
            <li class="d-none d-sm-block">
                <div class="app-search">
                    <form>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search...">
                            <span data-feather="search"></span>
                        </div>
                    </form>
                </div>
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
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-sm rounded-circle mr-2"
                         alt="Pando"/>
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-xs rounded-circle mr-2"
                         alt="Pando"/>

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
                                <a href="/product-orders">상품별 주문 목록</a>
                            </li>
                            <li>
                                <a href="/returns">반품 내역</a>
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
                    <li class="mm-active">
                        <a href="javascript:;">
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
                                <li class="breadcrumb-item">등록 거래처 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">할인/할증 등급 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">할인/할증 등급 관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <div>
                                    <table class="table" id="shop_grades">
                                        <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>구분</th>
                                            <th>등급명</th>
                                            <th>할인/할증</th>
                                            <th>적용된 거래처 수</th>
                                            <th>수정</th>
                                            <th>삭제</th>
                                            <th>순서변경</th>
                                        </tr>
                                        </thead>
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
<div class="modal fade" id="add_grade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">할인/할증율 등급 등록</h5>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form:form id="add_grade_form" method="post">
                    <input type="hidden" name="id">
                    <div class="form-group row align-items-center">
                        <label class="col-form-label col-lg-3 text-lg-right">구분</label>
                        <div class="col-lg-9">
                            <div class="custom-control custom-control-inline custom-radio">
                                <input class="custom-control-input" type="radio" name="saleType" id="discount_type1"
                                       value="discount" checked>
                                <label class="custom-control-label" for="discount_type1">할인</label>
                            </div>
                            <div class="custom-control custom-control-inline custom-radio">
                                <input class="custom-control-input" type="radio" name="saleType" id="discount_type2"
                                       value="extra_charge">
                                <label class="custom-control-label" for="discount_type2">할증</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-lg-3 text-lg-right">등급명</label>
                        <div class="col-lg-9">
                            <input name="name" type="text" class="form-control" placeholder="예: 1등급가, 2등급가 등" required>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-lg-3 text-lg-right">할인/할증율</label>
                        <div class="col-lg-9">
                            <div class="input-group">
                                <input class="form-control" name="percentage" type="number" value="0">
                                <div class="input-group-append">
                                    <span class="input-group-text">%</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-outline-primary" form="add_grade_form">등록</button>
            </div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>

<script src="${contextPath}/resources/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${contextPath}/resources/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="${contextPath}/resources/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="${contextPath}/resources/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
<script src="${contextPath}/resources/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="${contextPath}/resources/datatables.net-buttons-bs4/js/buttons.bootstrap4.js"></script>

<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $(document).ready(function () {
        var token = $("meta[name='_csrf']").attr("content");
        var table = $('#shop_grades').DataTable({
            serverSide: true,
            responsive: true,
            lengthChange: true,
            ajax: {
                url: '/data/shop_grades',
                contentType: 'application/json',
                headers: {"X-CSRF-TOKEN": token},
                type: 'POST',
                data: function (d) {
                    return JSON.stringify(d);
                },
            },
            columns: [
                {
                    data: 'id',
                    searchable: false
                },
                {
                    data: 'saleType',
                    render: function (data) {
                        switch (data) {
                            case 'discount':
                                return '할인';
                            case 'extra_charge':
                                return '할증';
                            default:
                                return '';
                        }
                    }
                },
                {data: 'name'},
                {data: 'percentage'},
                {
                    data: 'shops',
                    orderable: false,
                    render: function (data) {
                        return data.length;
                    }
                },
                {
                    data: null,
                    searchable: false,
                    orderable: false,
                    render: function (data) {
                        return '<button data-id="' + data.id + '" class="btn btn-sm btn-outline-primary edit">수정</button>';
                    }
                },
                {
                    data: null,
                    searchable: false,
                    orderable: false,
                    render: function (data) {
                        return '<a class="btn btn-outline-danger btn-sm delete" href="/shop_grades/' + data.id + '">삭제</a>'
                    }
                },
                {data: null, searchable: false, orderable: false, defaultContent: ''},
            ],
            dom: "<'d-flex justify-content-end mb-2'B>" +
                "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
            buttons: [
                {
                    text: '<i class="fal fa-plus"></i> 할인/할증율 등록',
                    className: 'btn btn-sm btn-outline-primary',
                    action: function (e, dt, node, config) {
                        $('#add_grade').modal();
                        $('#add_grade_form').attr('action', '/shop_grades/store');
                        document.getElementById('add_grade_form').reset();
                        $('#add_grade_form input[name="id"]').val('');
                    },
                }
            ]
        });

        // $('#shop_grades tbody').on('click', 'tr', function () {
        //     var data = table.row( this ).data();
        //     window.location.href = '/shop_grades/' + data.id;
        // });

        $('#add_grade_form').submit(function (e) {
            e.preventDefault();
            var form = $(this);
            $.ajax({
                type: 'POST',
                url: form.attr('action'),
                data: form.serialize(),
                success: function (data) {
                    $('#add_grade_form input').removeClass('is-invalid');
                    $('#add_grade').modal('toggle');
                    table.draw();
                },
                error: function (xhr) {
                    var error = xhr.responseJSON.error;
                    Object.keys(error).forEach(function (k) {
                        $('#add_grade_form input[name="' + k + '"]').addClass('is-invalid');
                    })
                }
            })
        });

        $('#shop_grades').on('click', 'tbody .btn.edit', function () {
            var dataRow = table.row($(this).closest('tr')).data();
            $('#add_grade_form').attr('action', '/shop_grades/' + $(this).data('id'));
            $('#add_grade_form input[name="id"]').val($(this).data('id'));
            document.getElementById('add_grade_form').reset();
            Object.keys(dataRow).forEach(function (k) {
                $('#add_grade_form input[name="' + k + '"]').attr('type') === 'radio'
                    ? ($('#add_grade_form input[value="' + dataRow[k] + '"]').prop("checked", true))
                    : ($('#add_grade_form input[name="' + k + '"]').val(dataRow[k]));
            })
            $('#add_grade').modal();
        });

        $('#shop_grades').on('click', 'tbody .btn.delete', function (e) {
            e.preventDefault();
            $.ajax({
                url: $(this).attr('href'),
                success: function () {
                    table.draw();
                }
            })
        })
    });
</script>
</body>
</html>