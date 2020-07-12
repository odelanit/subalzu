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

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/metismenu/metisMenu.min.css" rel="stylesheet" type="text/css"/>
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
                <a href="javascript:;" class="nav-link" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
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
                <img src="${contextPath}/resources/images/logo_dark.svg" alt="logo" height="40" class="logo-icon" />
                <img src="${contextPath}/resources/images/logo_pando_dark.svg" alt="logo" height="40" class="logo-full" />
            </a>
        </div>
        <div class="sidebar-content">
            <!--- Sidemenu -->
            <div id="sidebar-menu" class="slimscroll-menu">
                <div class="media user-profile mt-2 mb-2">
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-sm rounded-circle mr-2" alt="Pando"/>
                    <img src="${contextPath}/resources/images/users/avatar-7.jpg" class="avatar-xs rounded-circle mr-2" alt="Pando"/>

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
                    <li class="mm-active">
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 서비스 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li class="mm-active">
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
                                <li class="breadcrumb-item">서비스 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">공지사항 등록</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">공지사항 등록</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">기본 정보 <span class="badge float-right"><span class="text-danger">*</span>필수 입력사항입니다.</span></h5>
                                <form:form method="post" modelAttribute="noticeForm">
                                    <spring:bind path="id">
                                        <form:hidden path="id" />
                                    </spring:bind>
                                    <table class="table table-bordered form-table">
                                        <tbody class="thead-light">
                                        <spring:bind path="type">
                                            <tr>
                                                <th class="required"><span>발송타입</span></th>
                                                <td>
                                                    <div class="form-check form-check-inline">
                                                        <form:radiobutton cssClass="form-check-input" path="type" id="type1" value="0" />
                                                        <label class="form-check-label" for="type1">전체발송</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <form:radiobutton cssClass="form-check-input" path="type" value="1" id="type2" />
                                                        <label class="form-check-label" for="type2">거래처 발송</label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <tr class="collapse <c:if test="${noticeForm.type == 1}">show</c:if>">
                                            <th>거래처</th>
                                            <td><button class="btn btn-secondary" data-toggle="modal" data-target="#selectShopModal" type="button">거래처 검색 및 선택</button></td>
                                        </tr>
                                        <tr class="collapse <c:if test="${noticeForm.type == 1}">show</c:if>">
                                            <th>선택한 거래처</th>
                                            <td>
                                                <div class="mb-2">
                                                    <span id="shop_total" class="float-right">전체 ${noticeForm.shops.size()}건</span>
                                                </div>
                                                <table class="table text-center table-hover table-sm" id="selected-shop-table">
                                                    <thead class="thead-light">
                                                    <tr>
                                                        <th>#</th>
                                                        <th>거래처</th>
                                                        <th>브랜드</th>
                                                        <th>삭제</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach items="${noticeForm.shops}" var="shop" varStatus="counter">
                                                        <tr id="data_tr${shop.id}">
                                                            <td>${counter.count}<input type="hidden" value="${shop.id}" name="shops"></td>
                                                            <td>${shop.name}</td>
                                                            <td></td>
                                                            <td><a class='btn btn-outline-danger btn-sm' href='javascript:deleteShop("${shop.id}")' role='button'>삭제</a></td>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <spring:bind path="popup">
                                            <tr>
                                                <th>팝업 공개</th>
                                                <td>
                                                    <div class="form-check">
                                                        <form:checkbox path="popup" cssClass="form-check-input" id="is-popup" value="true" />
                                                        <label class="form-check-label" for="is-popup">선택시 공지사항이 팝업으로 노출됩니다.</label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="section">
                                            <tr>
                                                <th>구분</th>
                                                <td>
                                                    <form:input path="section" cssClass="form-control w-50 ${status.error ? 'is-invalid' : ''}" placeholder="예) 유통안내, 추가상품 안내" maxlength="10" />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="section"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="title">
                                            <tr>
                                                <th class="required"><span>제목</span></th>
                                                <td>
                                                    <form:input path="title" cssClass="form-control w-75 ${status.error ? 'is-invalid' : ''}" />
                                                    <div class="invalid-feedback">
                                                        <form:errors path="title"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        <spring:bind path="description">
                                            <tr>
                                                <th class="required"><span>내용</span></th>
                                                <td>
                                                    <form:textarea path="description" id="description" />
                                                    <div class="invalid-feedback ${status.error ? 'd-block' : ''}">
                                                        <form:errors path="description"/>
                                                    </div>
                                                </td>
                                            </tr>
                                        </spring:bind>
                                        </tbody>
                                    </table>
                                    <div class="form-group row">
                                        <div class="col-lg-10 offset-lg-2">
                                            <a href="/notices" class="btn btn-secondary">목록으로</a>
                                            <button class="btn btn-primary">등록하기</button>
                                        </div>
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
<div class="modal fade" id="selectShopModal">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title text-light">거래처 검색/선택</h5>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body p-4">
                <form:form class="form-inline mb-3" id="shop-search-form" modelAttribute="shopSearchForm">
                    <label class="mr-2">검색</label>
                    <form:select class="form-control form-control-sm mr-2" path="type">
                        <form:option value="name">거래처명</form:option>
                    </form:select>
                    <form:input class="form-control form-control-sm mr-2" path="keyword" placeholder="검색어를 입력해주세요." />
                    <button class="btn btn-primary btn-sm">검색</button>
                </form:form>
                <div class="row mb-3">
                    <div class="col-lg-6">
                        거래처 목록
                    </div>
                    <div class="col-lg-6 text-right">
                        <span id="shopSearchResultCountText"></span>
                        <button id="all_sel_shop" class="btn btn-sm btn-secondary">전체선택</button>
                        <button id="remove_sel_shop" class="btn btn-sm btn-secondary">전체해제</button>
                    </div>
                </div>
                <div style="min-height: 500px; overflow-y: auto;">
                    <table class="table table-sm table-hover text-center" id="shopTable">
                        <thead class="thead-light">
                        <tr>
                            <th>#</th>
                            <th>거래처</th>
                            <th>브랜드</th>
                            <th>선택</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-primary" id="btn_save_popup">확인</button>
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
<script src="${contextPath}/resources/ckeditor5/ckeditor.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script src="${contextPath}/resources/js/app.js"></script>
<script type="text/javascript">
    ClassicEditor
        .create(document.querySelector('#description'), {
            ckfinder: {
                uploadUrl: '/upload/'
            }
        })
        .then(editor => {
            window.editor = editor;
        })
        .catch(err => {
            console.error(err.stack);
        });

    var allShopList = [];		//전체 거래처 데이터
    var searchShopList = [];		//검색된 목록에 한해서만의 거래처 데이터
    var selShopList = [];		//실제 선택된 거래처 데이터
    var okShopList = [];			//실제 저장 데이터
    var sortShopList = [];		//거래처 이름 소팅용

    var on_color = "#00a1b7";
    var off_color = "#000";

    $(document).ready(function() {
        $('input[name="shops"]').each(function(index, item) {
            okShopList.push({
                id: parseInt($(item).val()),
                name: $(item).parent().next().html()
            });
        });
    });

    $('input[name="type"]').on('change', function() {
        var type = parseInt($(this).val());
        switch (type) {
            case 0:
                $('.collapse').collapse('hide');
                break;
            case 1:
                $('.collapse').collapse('show');
                break;
            default:

        }
    });

    /**
     * 거래처 선택(popup)
     */
    function addTemporaryShop(shopId) {

        //선택되어있는 건 취소, 선택안되어있는 건 선택처리 필요
        if(selShopList.find(shop => shop.id === shopId) === undefined){
            var shopObj = allShopList.find(shop => shop.id === shopId);
            selShopList.push(shopObj);

            $("#shop_sel_text"+shopId).css("color", on_color);
        }
        //이미 선택되어 있음
        else{
            $("#shop_sel_text"+shopId).css("color", off_color);
            selShopList = selShopList.filter(shop => shop.id !== shopId);
        }

        popShopTotalText();
    }

    function popShopTotalText(){
        var tot_text = "";

        if(selShopList.length > 0){
            tot_text = "선택 "+selShopList.length+"건 / ";
        }

        tot_text += "전체 "+searchShopList.length+"건";

        $("#shopSearchResultCountText").text(tot_text);
    }

    /**
     * 거래처 전체 선택(popup)
     */
    function addAllTemporaryShop() {
        $.each(searchShopList, function(index, searchShop) {
            var shop_obj = allShopList.find(shop => shop.id === searchShop.id);
            if (selShopList.find(selShop => selShop.id == searchShop.id) === undefined) {
                selShopList.push(shop_obj);
            }
            $("#shop_sel_text"+searchShop.id).css("color", on_color);
        });

        popShopTotalText();
    }

    /**
     * 거래처 전체 해제(popup)
     */
    function removeAllTemporaryShop() {
        $.each(searchShopList, function(index, shop) {
            selShopList = selShopList.filter(selShop => selShop.id !== shop.id);
            $("#shop_sel_text"+shop.id).css("color", off_color);
        });

        popShopTotalText();
    }

    function loadShopList() {
        $("#shopTable tbody").empty();
        var form = $('#shop-search-form');
        $.ajax({
            type: 'POST',
            url: '/notices/shop_list',
            data: form.serialize(),
            success: function(data) {
                searchShopList = [];

                if (data.rc < 0) {
                } else {
                    var brand_count = $("#brand_count").val();

                    $("#shopTable tbody").empty();
                    $.each(data.data, function(index, row) {
                        var shopObj = {};
                        shopObj = {
                            "id" : row[0],
                            "name" : row[1],
                            "brand_name" : ""
                        }

                        allShopList.push(shopObj);
                        searchShopList.push(shopObj);

                        var choice_color = off_color;

                        if(selShopList.find(shop => shop.id === row[0]) !== undefined){
                            choice_color = on_color;
                        }

                        var brand_html = "<td></td>";

                        var html = ""
                            + "<tr onclick='javascript:addTemporaryShop("+ row[0] +")'>"
                            + "	<td>"+ (index+1) +"</td>"
                            + "	<td>" + row[1] + "</td>"
                            + brand_html
                            + "	<td><a href='#' class='btn btn-sm font-weight-bold' id='shop_sel_text"+row[0]+"' style='color:"+choice_color+";'>선택</a></td>"
                            + "</tr>";
                        $("#shopTable tbody").append(html);
                    });

                    popShopTotalText();
                }
            }// end of the function success
        });
    }

    //처리할 거래처이 로딩된 상태에서 호출
    //JSON 객체로 변환 저장 및 소팅 = sortGoodsList 객체 .
    function mainShopAsSort(){
        //JSON 객체로 변환 후 소팅.
        okShopList.sort((a, b) => {
            const nameA = a.name.toUpperCase();
            const nameB = b.name.toUpperCase();
            var comparison = 0;
            if (nameA > nameB) {
                comparison = 1;
            } else if (nameA < nameB) {
                comparison = -1;
            }
            return comparison;
        })

        sortShopList = okShopList;
    }

    function deleteShop(shop_id){
        $("#data_tr"+shop_id).remove();
        console.log(okShopList);
        okShopList = okShopList.filter(shop => shop.id !== parseInt(shop_id));

        $("#shop_total").text("전체 "+okShopList.length+"건");
    }

    // 팝업 선택 사항 메인에 반영
    function applyChoson() {
        $.each(selShopList, function(index, selShop) {
            var shop_obj = allShopList.find(shop => shop.id === selShop.id);
            if (okShopList.find(okShop => okShop.id === shop_obj.id) === undefined) {
                okShopList.push(shop_obj);
            }
        });

        mainShopAsSort();
        searchShopList = [];
        selShopList = [];

        // var right12 = $("#right12").val();
        //
        if(sortShopList.length > 0){
            var index = 0;

            // var brand_count = $("#brand_count").val();

            $("#selected-shop-table tbody").empty();

            $.each(sortShopList, function (index, shop) {
                var brand_html = "<td></td>";

                var add_html = "<tr id='data_tr"+shop.id+"'>"
                    +"<td>"+(++index)+"<input type='hidden' name='shops' value='" + shop.id + "' /></td>"
                    +"<td>"+shop.name+"</td>"
                    +brand_html;

                add_html += "<td><a class='btn btn-outline-danger btn-sm' href='javascript:deleteShop(\""+shop.id+"\")' role='button'>삭제</a></td>";

                add_html += "</tr>";

                $("#selected-shop-table tbody").append(add_html);
            });

            $("#shop_total").text("전체 "+okShopList.length+"건");
            //$("#selShop").show();
        }
    }

    $('#selectShopModal').on('show.bs.modal', function() {
        loadShopList();
    });

    $('#shop-search-form').on('submit', function(e) {
        e.preventDefault();
        loadShopList();
    });

    $('#all_sel_shop').on('click', function() {
        addAllTemporaryShop();
    })

    $('#remove_sel_shop').on('click', function() {
        removeAllTemporaryShop();
    });

    $('#btn_save_popup').on('click', function() {
        applyChoson();
        $('#selectShopModal').modal('hide');
    })
</script>
</body>
</html>
