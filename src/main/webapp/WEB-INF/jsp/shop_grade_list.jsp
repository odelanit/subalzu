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
                                    <div class="row align-items-center mb-4">
                                        <div class="col-lg-6">
                                            전체 ${shopGrades.size()}건
                                        </div>
                                        <div class="col-lg-6 text-right">
                                            <button class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteAllModal"><i class="fa fa-trash"></i>전체 삭제</button>
                                            <button class="btn btn-primary btn-sm" id="add_shop_grade_button">
                                                <i class="fa fa-plus"></i>할인/할증율 등록
                                            </button>
                                        </div>
                                    </div>
                                    <table class="table table-sm text-center">
                                        <colgroup>
                                            <col style="width: 5%">
                                            <col style="width: 8%">
                                            <col>
                                            <col style="width: 12%">
                                            <col style="width: 14%">
                                            <col style="width: 12%">
                                            <col style="width: 12%">
                                        </colgroup>
                                        <thead class="thead-light">
                                        <tr>
                                            <th>#</th>
                                            <th>구분</th>
                                            <th>등급명</th>
                                            <th>할인/할증</th>
                                            <th>적용된 거래처 수</th>
                                            <th>수정</th>
                                            <th>삭제</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${shopGrades}" var="shopGrade">
                                            <tr>
                                                <td>${shopGrade.id}</td>
                                                <td>${shopGrade.saleType == 'discount' ? '할인' : '할증'}</td>
                                                <td>${shopGrade.name}</td>
                                                <td>${shopGrade.percentage}%</td>
                                                <td>${shopGrade.shops.size()}</td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm edit"
                                                            data-id="${shopGrade.id}"
                                                            data-type="${shopGrade.saleType}"
                                                            data-name="${shopGrade.name}"
                                                            data-percentage="${shopGrade.percentage}"
                                                    >
                                                        <i class="fa fa-pencil"></i>수정
                                                    </button>
                                                </td>
                                                <td>
                                                    <a class="btn btn-danger btn-sm delete" href="/shop_grades/${shopGrade.id}"><i class="fa fa-trash"></i>삭제</a>
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
<div class="modal fade" id="add_grade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h6 class="modal-title text-white">할인/할증율 등급 등록</h6>
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
                <button class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-times"></i> 취소</button>
                <button class="btn btn-primary" form="add_grade_form"><i class="fa fa-save"></i> 등록</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteAllModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-danger">
                <h6 class="modal-title text-white">전체 삭제</h6>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                등록된 등급을 모두 삭제하시겠습니까?
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-dismiss="modal"><i class="fa fa-times"></i> 취소</button>
                <button class="btn btn-danger" id="delete_all_button"><i class="fa fa-trash"></i> 확인</button>
            </div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/metismenu/metisMenu.min.js"></script>
<script src="${contextPath}/resources/slimscroll/jquery.slimscroll.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script>
    $(document).ready(function () {

        $('#add_shop_grade_button').click(function () {
            $('#add_grade').modal();
            $('#add_grade_form').attr('action', '/shop_grades/store');
            document.getElementById('add_grade_form').reset();
            $('#add_grade_form input[name="id"]').val('');
        })

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
                    window.location.reload();
                },
                error: function (xhr) {
                    var error = xhr.responseJSON.error;
                    Object.keys(error).forEach(function (k) {
                        $('#add_grade_form input[name="' + k + '"]').addClass('is-invalid');
                    })
                }
            })
        });

        $('.btn.edit').on('click', function () {
            $('#add_grade_form').attr('action', '/shop_grades/' + $(this).data('id'));
            $('#add_grade_form input[name="id"]').val($(this).data('id'));
            document.getElementById('add_grade_form').reset();
            $('#add_grade_form input[name="name"]').val($(this).data('name'));
            $('#add_grade_form input[name="percentage"]').val($(this).data('percentage'));
            if ($('#add_grade_form input[name="saleType"]').attr('type') === 'radio') {
                $('#add_grade_form input[value="' + $(this).data('saleType') + '"]').prop("checked", true)
            }
            $('#add_grade').modal();
        });

        $('.btn.delete').on('click', function (e) {
            e.preventDefault();
            $.ajax({
                url: $(this).attr('href'),
                success: function () {
                    window.location.reload();
                }
            })
        });

        $('#delete_all_button').click(function() {
            var token = $("meta[name='_csrf']").attr("content");
            $.ajax({
                type: 'POST',
                url: '/shop_grades/delete_all',
                headers: {
                    'X-CSRF-TOKEN': token,
                },
                success: function(data) {
                    window.location.reload();
                    $('#deleteAllModal').modal();
                }
            })
        })
    });
</script>
</body>
</html>