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
                                <li class="breadcrumb-item">상품 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">카테고리 설정</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">카테고리 설정</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="popupForm" id="popupForm" action="/categories/set_popup">
                                    <table class="table table-bordered form-table">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th style="width: 200px;">카테고리 팝업 노출 설정</th>
                                            <td>
                                                <div class="form-check-inline">
                                                    <form:radiobutton class="form-check-input" path="popup" value="on"
                                                                      id="set-popup1"/>
                                                    <label class="form-check-label" for="set-popup1">ON</label>
                                                </div>
                                                <div class="form-check-inline">
                                                    <form:radiobutton class="form-check-input" path="popup" value="off"
                                                                      id="set-popup2"/>
                                                    <label class="form-check-label" for="set-popup2">OFF</label>
                                                </div>
                                                <small class="form-text text-primary">
                                                    * 상품 주문시 카테고리 팝업이 상품보다 먼저 노출
                                                </small>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <ul>
                                    <li>
                                        카테고리 '단가 정액/정률 별도 사용'에 체크하시면, <a style="text-decoration: underline"
                                                                         href="/prices/fixed-price-rate">단가 관리 > 정액/정률
                                        관리</a>에서 개별 설정이 가능합니다.<br>
                                        (하위 카테고리를 개별 설정하시려면, 상위 카테고리의 체크를 해제해 주세요.)
                                    </li>
                                    <c:if test="${fixedPriceRate == false}">
                                        <li class="text-primary">
                                            현재 <a style="text-decoration: underline" href="/prices/fixed-price-rate">단가
                                            관리 > 정액/정률 관리</a>의 설정 여부가 '비설정'상태입니다.<br>
                                            '단가 정액/정률 별도 사용'기능을 사용하시려면, 설정 여부를 '설정'으로 변경해 주세요.
                                        </li>
                                    </c:if>
                                </ul>
                                <input type="hidden" id="sel_category_id0" name="sel_category_id0" value="">
                                <input type="hidden" id="sel_category_id1" name="sel_category_id1" value="">
                                <input type="hidden" id="fixed_rate_use_yn" name="fixed_rate_use_yn"
                                       value="${fixedPriceRate}">
                                <div class="row">
                                    <div class="col">
                                        <%--                                        <div class="text-right mb-2">--%>
                                        <%--                                            <button class="btn btn-outline-primary btn-sm change-level0" data-direction="up"><i class="fa fa-arrow-up"></i></button>--%>
                                        <%--                                            <button class="btn btn-outline-primary btn-sm change-level0" data-direction="down"><i class="fa fa-arrow-down"></i></button>--%>
                                        <%--                                        </div>--%>
                                        <table class="table text-center" id="categoryTable">
                                            <colgroup>
                                                <col>
                                                <col style="width: 125px;">
                                                <col style="width: 100px;">
                                            </colgroup>
                                            <thead class="thead-light">
                                            <tr>
                                                <th colspan="2">
                                                    1차 카테고리 목록 <br>
                                                    (상위 카테고리)
                                                </th>
                                                <th style="width: 100px;">
                                                    단가 정액/정률<br>
                                                    별도 사용
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${categories}" var="category">
                                                <tr id="tr_${category.id}" data-depth="0" data-id="${category.id}">
                                                    <td id="td_input_${category.id}">${category.name}</td>
                                                    <td id="td_btn_${category.id}">
                                                        <a class="btn btn-sm btn-outline-warning mr-1" role="button"
                                                           href="javascript:categoryModify('0', ${category.id})">수정</a>
                                                        <a class="btn btn-sm btn-outline-danger" role="button"
                                                           href="javascript:categoryDelete('0', ${category.id})">삭제</a>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-sm btn-outline-primary btn-check <c:if test="${category.usedIndividual == true}">checked</c:if>"
                                                           href="javascript:;" data-id="${category.id}">
                                                            <i class="fa fa-check"></i>
                                                        </a>
                                                    </td>
                                                    <td style="display:none;">
                                                        <input type="hidden" id="category_name_${category.id}"
                                                               value="${category.name}">
                                                        <input type="hidden" id="category_goods_cnt_${category.id}"
                                                               value="0">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                            <tfoot>
                                            <tr>
                                                <td>
                                                    <form:form action="/categories/store" id="add_category_form"
                                                               modelAttribute="categoryForm">
                                                        <form:input path="name" cssClass="form-control form-control-sm"
                                                                    placeholder="1차 카테고리 명 입력(예: 농산)" type="text"/>
                                                    </form:form>
                                                </td>
                                                <td>
                                                    <button class="btn btn-outline-primary btn-sm"
                                                            form="add_category_form">추가
                                                    </button>
                                                </td>
                                                <td></td>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                    <div class="col">
                                        <table id="categoryTable2" class="table text-center">
                                            <colgroup>
                                                <col>
                                                <col style="width: 125px;">
                                                <col style="width: 100px;">
                                            </colgroup>
                                            <thead class="thead-light">
                                            <tr>
                                                <th scope="col" colspan="2">2차 카테고리 목록<br>(하위 카테고리)</th>
                                                <th scope="col" colspan="1">단가 정액/정률<br>별도 사용</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td colspan="3">
                                                    (1차 카테고리 선택 후<br>2차 카테고리 설정이 가능합니다.)
                                                </td>
                                            </tr>
                                            </tbody>
                                            <tfoot>
                                            </tfoot>
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

    <!-- ============================================================== -->
    <!-- End Page content -->
    <!-- ============================================================== -->


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
    var chk_submit = true;

    //카테고리 팝업 노출 설정 라디오박스
    $('input[name="popup"]').on('change', function () {
        var popup = $(this).val();
        var form = $('#popupForm');
        if (chk_submit) {
            chk_submit = false;
            $.ajax({
                type: 'POST',
                url: form.attr('action'),
                data: form.serialize(),
                success: function (data) {
                    toastr.success('변경이 완료되었습니다.');
                    chk_submit = true;
                }
            })
        } else {
            toastr.warning("기존 요청이 처리될 때까지 잠시만 기다려주세요.");
        }
    });

    // function changeCategoryLevel(id, direction) {
    //     if(chk_submit){
    //         chk_submit = false;
    //
    //         //결제내역 정보 추출
    //         var token = $("meta[name='_csrf']").attr("content");
    //         $.ajax({
    //             type: 'POST',
    //             url: '/categories/change_level',
    //             headers: {"X-CSRF-TOKEN": token},
    //             data: {
    //                 id: id,
    //                 direction: direction,
    //             },
    //             success: function(data) {
    //                 chk_submit = true;
    //
    //                 var element = $("#category_table tbody tr.table-active");
    //
    //                 if(direction === "down"){
    //                     element.insertAfter(element.next());
    //                 }
    //                 else{
    //                     element.insertBefore(element.prev());
    //                 }
    //             }
    //         });
    //     }
    //     else{
    //         toastr.warning("기존 요청이 처리될 때까지 잠시만 기다려주세요.");
    //     }
    // }

    // $('.change-level0').on('click', function () {
    //     var selectedRow = $('#category_table tbody').find('.table-active');
    //     if (selectedRow.length) {
    //         var categoryId = parseInt($(selectedRow).data('id'));
    //         changeCategoryLevel(categoryId, $(this).data('direction'));
    //     } else {
    //         toastr.error('순서를 변경할 카테고리를 선택해주세요.');
    //     }
    // })

    function categoryAdd(depth) {
        var category_name = $("#ins_category_name" + depth);

        if (category_name.val() === "") {
            toastr.error("추가할 카테고리명을 입력해주세요.");
            category_name.focus();
        } else {
            if (chk_submit) {
                var parent_id = null;
                var parent_name = "";
                var parent_fixed_rate_use_yn = false;

                if (depth !== "0") {
                    parent_id = $("#sel_category_id0").val();
                    parent_fixed_rate_use_yn = !!$('.btn-check[data-id=' + parent_id + ']').hasClass('checked');
                }

                chk_submit = false;

                var token = $("meta[name='_csrf']").attr("content");

                //결제내역 정보 추출
                $.ajax({
                    type: 'POST',
                    url: '/categories/add_category',
                    headers: {"X-CSRF-TOKEN": token},
                    data: {
                        name: category_name.val(),
                        parent: parent_id
                    },
                    success: function (data) {
                        chk_submit = true;
                        var category = data.category;

                        if (data.result_code === "00") {
                            var add_html = "<tr id='tr_" + category.id + "' data-depth='" + depth + "' data-id='" + category.id + "'>"
                                + "<td id='td_input_" + category.id + "'>" + category.name + "</td>";

                            add_html += "<td id='td_btn_" + category.id + "'><a class='btn btn-sm btn-outline-warning mr-1' role='button' href=\"javascript:categoryModify('" + depth + "','" + category.id + "')\">수정</a>"
                                + "<a class='btn btn-sm btn-outline-danger' role='button' href=\"javascript:categoryDelete('" + depth + "','" + category.id + "')\">삭제</a></td>";

                            add_html += '<td><a href="#" class="btn btn-sm btn-outline-primary btn-check" data-id="' + category.id + '" style="' + (parent_fixed_rate_use_yn === true ? 'display:none;' : '') + '">' +
                                '<i class="fa fa-check"></i></a></td>';

                            add_html += "<td style='display:none;'><input type='hidden' id='category_name_" + category.id + "' value='" + category.name + "'/>"
                                + "</td>"
                                + "</tr> ";

                            var table_id = "categoryTable";

                            if (depth === '1') {
                                table_id = "categoryTable2";
                            }

                            $("#" + table_id + " tbody").append(add_html);

                            var input_placeholder = "1차 카테고리 명 입력(예 : 농산)";

                            if (depth === "1") {
                                input_placeholder = "2차 카테고리 명 입력(예 : 채소류)";
                            }

                            var input_html = "<tr id='add_category_tr" + depth + "'>"
                                + "<td>"
                                + "<input type='text' id='ins_category_name" + depth + "' title='카테고리명' class='form-control form-control-sm' placeholder='" + input_placeholder + "'>"
                                + "</td>"
                                + "<td style='text-align:center;'>"
                                + "<a class='btn btn-sm btn-outline-primary' role='button' href=\"javascript:categoryAdd('" + depth + "')\">추가</a>"
                                + "</td>";

                            input_html += '<td></td>';

                            input_html += "</tr>";

                            $("#" + table_id).find('tfoot').html(input_html);

                            $("#ins_category_name" + depth).focus();
                        }
                    }
                });
            } else {
                toastr.warning("기존 요청이 처리될 때까지 잠시만 기다려주세요.");
            }
        }
    }

    //1차, 2차 카테고리 대상 테이블 리턴.
    function return_table(depth) {
        var target_table = $("#categoryTable");

        if (parseInt(depth) === 1) {
            target_table = $("#categoryTable2");
        }

        return target_table;
    }

    //수정 모드로 전환
    function categoryModify(depth, category_id) {
        var target_table = return_table(depth);
        selectCategory(target_table, category_id, depth);

        var category_name = decodeURIComponent($("#category_name_" + category_id).val()).replace(/\+/g, " ");
        // var category_goods_cnt = $("#category_goods_cnt_" + category_id).val();

        var td_input = $("#td_input_" + category_id);
        var td_btn = $("#td_btn_" + category_id);

        var change_input_html = "<input type='text' id='mod_category_name" + depth + "' title='1차 카테고리명' class='form-control form-control-sm' placeholder='1차 카테고리 명 입력(예 : 농산)' value='" + category_name + "'>";
        td_input.html(change_input_html);

        var change_btn_html = "<a class='btn btn-sm btn-outline-primary mr-1' role='button' href=\"javascript:categoryModifySave('" + depth + "')\">저장</a>"
            + "<a class='btn btn-sm btn-outline-secondary' role='button' href=\"javascript:categoryModifyCancel('" + depth + "','" + category_id + "')\">취소</a>";

        td_btn.html(change_btn_html);
    }

    //수정 처리
    function categoryModifySave(depth) {
        var category_name = $("#mod_category_name" + depth);
        var category_id = $("#sel_category_id" + depth).val();

        if (category_name.val() === "") {
            toastr.error("수정할 카테고리명을 입력해주세요.");
            category_name.focus();
        } else {
            if (chk_submit) {
                var parent_id = null;

                if (depth !== "0") {
                    parent_id = $("#sel_category_id0").val();
                }

                chk_submit = false;

                //결제내역 정보 추출
                var token = $("meta[name='_csrf']").attr("content");
                $.ajax({
                    type: 'POST',
                    url: '/categories/update',
                    headers: {"X-CSRF-TOKEN": token},
                    data: {
                        id: category_id,
                        name: category_name.val(),
                        parent: parent_id,
                    },
                    success: function (data) {
                        chk_submit = true;

                        $("#category_name_" + category_id).val(encodeURIComponent(category_name.val()));

                        if (depth === "0") {
                            $("#sub_category_title_td").html(category_name.val() + "(1차 카테고리)");
                        }

                        if (data.result_code === "00") {
                            categoryModifyCancel(depth, category_id);
                        }
                    }
                });
            } else {
                toastr.warning("기존 요청이 처리될 때까지 잠시만 기다려주세요.");
            }
        }
    }

    //수정 모드 해제
    function categoryModifyCancel(depth, category_id) {
        var category_name = $("#category_name_" + category_id).val();
        var category_goods_cnt = $("#category_goods_cnt_" + category_id).val();

        var td_input = $("#td_input_" + category_id);
        var td_btn = $("#td_btn_" + category_id);

        var change_input_html = decodeURIComponent(category_name).replace(/\+/g, " ");
        td_input.html(change_input_html);

        var change_btn_html =
            "<a class='btn btn-sm btn-outline-warning mr-1' role='button' href=\"javascript:categoryModify('" + depth + "','" + category_id + "')\">수정</a>"
            + "<a class='btn btn-sm btn-outline-danger' role='button' href=\"javascript:categoryDelete('" + depth + "','" + category_id + "')\">삭제</a>";

        td_btn.html(change_btn_html);
    }

    //카테고리 삭제
    function categoryDelete(depth, category_id) {
        if (chk_submit) {
            var sel_category_id = $("#sel_category_id" + depth).val();

            var category_name = decodeURIComponent($("#category_name_" + category_id).val()).replace(/\+/g, " ");

            if (confirm(category_name + " 카테고리를 정말 삭제 하시겠습니까?")) {

                chk_submit = false;

                var token = $("meta[name='_csrf']").attr("content");
                //결제내역 정보 추출
                $.ajax({
                    type: 'POST',
                    url: '/categories/delete',
                    headers: {"X-CSRF-TOKEN": token},
                    data: {
                        id: category_id,
                    },
                    success: function (data) {
                        chk_submit = true;

                        if (data.result_code === "00") {
                            $("#tr_" + category_id).remove();
                            console.log(depth);
                            //1차카테고리이고 선택했던 카테고리와 삭제하는 카테고리가 같으면 2차 카테고리를 초기화
                            if (depth === "0" && sel_category_id !== "" && sel_category_id === category_id) {
                                $("#sel_category_id1").val("");

                                // var thead_html = "<tr class='middle'>"
                                // 	+"<th scope='col' colspan='2'>2차 카테고리 목록<br>(하위 카테고리)</th>"
                                // 	+"<th scope='col'>상품 수</th>"
                                // 	+"</tr>";

                                var tbody_html = "<tr>"
                                    + "<td colspan='2'>"
                                    + "(1차 카테고리 선택 후<br>2차 카테고리 설정이 가능합니다.)"
                                    + "</td>"
                                    + "</tr>";
                                //
                                $("#categoryTable2 thead tr").eq(1).remove();
                                $("#categoryTable2 tbody").html(tbody_html);
                                $("#categoryTable2 tfoot").html("");
                            }
                        }
                    }
                });
            }
        } else {
            toastr.warning("기존 요청이 처리될 때까지 잠시만 기다려주세요.");
        }
    }

    //카테고리 선택 처리
    function selectCategory(target_table, category_id, depth) {
        //1차 카테고리이면 2차 카테고리 호출
        if (depth === 0) {
            $("#sel_category_id1").val(""); //선택했던 2차 카테고리 초기화

            chk_submit = false;

            $("#categoryTable").find(".table-active").removeClass("table-active");
            $("#tr_" + category_id).addClass('table-active');
            $("#sel_category_id" + depth).val(category_id);

            var parent_fixed_rate_use_yn = !!$('.btn-check[data-id=' + category_id + ']').hasClass('checked');

            //2차 카테고리 정보
            $.ajax({
                url: '/categories/sub_categories',
                data: {
                    id: category_id
                },
                success: function (data) {
                    chk_submit = true;

                    if (data.result_code === "00") {
                        var category_name = decodeURIComponent($("#category_name_" + category_id).val()).replace(/\+/g, " ");
                        var target_table = return_table("1");

                        $("#sub_category_title").remove();

                        var title_html = "<tr id='sub_category_title'>"
                            + "<td style='color:#000; font-weight:700;' id='sub_category_title_td'>" + category_name + "(1차 카테고리)</td>"
                            + '<td></td>';

                        title_html += "<td>" + (parent_fixed_rate_use_yn === true ? '전체 적용중' : '') + "</td>"

                        title_html += "</tr>";

                        target_table.find('thead').append(title_html);

                        var add_html = "";

                        var input_html = "<tr id='add_category_tr1'>"
                            + "<td>"
                            + "<input type='text' id='ins_category_name1' title='1차 카테고리명' class='form-control form-control-sm' placeholder='2차 카테고리 명 입력(예 : 채소류)'>"
                            + "</td>"
                            + "<td>"
                            + "<a class='btn btn-sm btn-outline-primary' role='button' href=\"javascript:categoryAdd('1')\">추가</a>"
                            + "</td>";

                        input_html += '<td></td>';

                        input_html += "</tr>";

                        if (data.listdata != null && data.listdata !== "") {
                            $.each(data.listdata, function (key, category) {
                                var category_id = decodeURIComponent(category.id).replace(/\+/g, " ");
                                var category_name = decodeURIComponent(category.name).replace(/\+/g, " ");
                                var fixed_rate_use_yn = category.usedIndividual;

                                add_html += "<tr id='tr_" + category_id + "' data-depth='1' data-id='" + category_id + "'>"
                                    + "<td id='td_input_" + category_id + "'>"
                                    + category_name
                                    + "</td>";

                                add_html += "<td id='td_btn_" + category_id + "'><a class='btn btn-sm btn-outline-warning mr-1' role='button' href=\"javascript:categoryModify('1','" + category_id + "')\">수정</a>"
                                    + "<a class='btn btn-sm btn-outline-danger' role='button' href=\"javascript:categoryDelete('1','" + category_id + "')\">삭제</a></td>";

                                add_html += '<td><a href="#" class="btn btn-sm btn-outline-primary btn-check ' + (fixed_rate_use_yn === true ? 'checked' : '') + '" data-id="' + category_id + '" style="' + (parent_fixed_rate_use_yn === true ? 'display:none;' : '') + '">' +
                                    '<i class="fa fa-check"></i></a></td>';

                                add_html += "<td style='display:none;'><input type='hidden' id='category_name_" + category_id + "' value='" + encodeURIComponent(category_name) + "'/>"
                                    + "</td></tr>";
                            });

                            target_table.find('tbody').html(add_html);

                            target_table.find('tfoot').html(input_html);
                        } else {
                            target_table.find('tbody').html("");
                            target_table.find('tfoot').html(input_html);
                        }
                    }
                }
            });
        } else {
            target_table.find(".table-active").removeClass("table-active");
            $("#tr_" + category_id).addClass('table-active');
            $("#sel_category_id" + depth).val(category_id);
        }
    }

    //카테고리 select 시
    $(document).on('click', 'tbody tr:not(.table-active)', function (e) {
        //e.preventDefault();

        var depth = $(this).data('depth');
        var category_id = $(this).data("id");
        var sel_category_id = $("#sel_category_id" + depth).val();
        var nodeName = e.target.nodeName;
        var target_table = return_table(depth);

        if (nodeName !== "A" && nodeName !== "INPUT") {
            e.preventDefault();

            selectCategory(target_table, category_id, depth);
        }

        if (sel_category_id !== "" && sel_category_id !== category_id) {
            categoryModifyCancel(depth, sel_category_id);
        }
    });

    // 정액/정률 사용 여부 토글
    $(document).on('click', '.btn-check', function () {
        if (chk_submit) {
            //todo: 권한 관련 정리 필요
            // var right03 = $("#right03").val();
            // if(!(right03 == 3 || right03 == 6)){
            //     alert('권한이 없습니다');
            //     return false;
            // }

            var vendor_fixed_rate_use_yn = $("#fixed_rate_use_yn").val(); // 유통사 정량/정률 설정
            if (vendor_fixed_rate_use_yn === 'false') {
                toastr.info('정액/정률 사용 설정이 ‘비설정’ 상태입니다\n해당 기능을 사용하시려면 먼저 정액/정률 사용 설정 여부를 ‘설정’으로 변경해 주세요.');
                return false;
            }

            var $this = $(this);
            var selected_parent_category = $("#sel_category_id0").val(); // 현재 선택된 부모 카테고리
            var category_id = $(this).data('id');
            var checkbox_checked_class = 'checked';
            var category_fixed_rate_use_yn = !$(this).hasClass(checkbox_checked_class); // 변경될 값
            var token = $("meta[name='_csrf']").attr("content");
            var form_data = {
                id: category_id,
                usedIndividual: category_fixed_rate_use_yn,
            };

            chk_submit = false;
            $.ajax({
                type: 'POST',
                url: '/categories/update_fixed_rate',
                data: form_data,
                headers: {"X-CSRF-TOKEN": token},
                success: function (data) {
                    if (data.result_code === '00') {
                        $this.toggleClass(checkbox_checked_class);
                        // 바뀐 카테고리가 선택되어있 카테고리라면던 하위 카테고리 리로드
                        if (category_id === selected_parent_category) {
                            selectCategory(null, category_id, 0);
                        }
                    } else {
                        toastr.error('변경에 실패하였습니다.');
                    }
                },
                error: function () {
                    toastr.error("변경에 실패하였습니다.");
                },
                complete: function () {
                    chk_submit = true;
                }
            });
        } else {
            toastr.warning("기존 요청이 처리될 때까지 잠시만 기다려주세요.");
        }

        return false;
    });
</script>
</body>
</html>