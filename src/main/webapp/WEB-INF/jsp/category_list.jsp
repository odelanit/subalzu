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
                                <div id="app">
                                    <table class="table table-bordered form-table">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th style="width: 200px;">카테고리 팝업 노출 설정</th>
                                            <td>
                                                <div class="form-check-inline">
                                                    <input type="radio" class="form-check-input" v-model="first_category_popup" value="on"
                                                           id="set-popup1"/>
                                                    <label class="form-check-label" for="set-popup1">ON</label>
                                                </div>
                                                <div class="form-check-inline">
                                                    <input type="radio" class="form-check-input" v-model="first_category_popup" value="off"
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
                                    <ul class="mb-4">
                                        <li>
                                            카테고리 '단가 정액/정률 별도 사용'에 체크하시면, <a style="text-decoration: underline"
                                                                             href="/fixed_price_rate/">단가 관리 > 정액/정률
                                            관리</a>에서 개별 설정이 가능합니다.<br>
                                            (하위 카테고리를 개별 설정하시려면, 상위 카테고리의 체크를 해제해 주세요.)
                                        </li>
                                        <li class="text-primary" v-if="use_special_price_rate === 'false'">
                                            현재 <a style="text-decoration: underline" href="/fixed_price_rate">단가
                                            관리 > 정액/정률 관리</a>의 설정 여부가 '비설정'상태입니다.<br>
                                            '단가 정액/정률 별도 사용'기능을 사용하시려면, 설정 여부를 '설정'으로 변경해 주세요.
                                        </li>
                                    </ul>
                                    <div class="row">
                                        <div class="col">
                                            <!-- <div class="text-right mb-2">
                                                <button class="btn btn-outline-primary btn-sm change-level0" data-direction="up"><i class="fa fa-arrow-up"></i></button>
                                                <button class="btn btn-outline-primary btn-sm change-level0" data-direction="down"><i class="fa fa-arrow-down"></i></button>
                                            </div> -->
                                            <table class="table text-center table-hover" id="categoryTable">
                                                <colgroup>
                                                    <col>
                                                    <col style="width: 150px;">
                                                </colgroup>
                                                <thead class="thead-light">
                                                <tr>
                                                    <th>
                                                        1차 카테고리 목록 <br>
                                                        (상위 카테고리)
                                                    </th>
                                                    <th>
                                                        단가 정액/정률<br>
                                                        별도 사용
                                                    </th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr v-for="(category, index) in categories" v-bind:key="index">
                                                    <td>
                                                        <div class="d-flex">
                                                            <div>
                                                                <a href="javascript:;" @click="selectCategory(category)">{{ category.name }}</a>
                                                            </div>
                                                            <div class="ml-auto">
                                                                <a class="btn btn-sm btn-outline-warning mr-1" role="button">수정</a>
                                                                <a class="btn btn-sm btn-outline-danger" role="button" @click="deleteCategory(category)" href="javascript:;">삭제</a>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <a class="btn btn-sm btn-outline-primary btn-check" @click="setIndividual(category)" href="javascript:;" :class="category.useIndividual === true ? 'checked' : ''">
                                                            <i class="fa fa-check"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                                </tbody>
                                                <tfoot>
                                                <tr>
                                                    <td>
                                                        <input v-model="new_category_name" class="form-control form-control-sm"
                                                                    placeholder="1차 카테고리 명 입력(예: 농산)" type="text"/>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-outline-primary btn-sm" @click="addCategory">추가</button>
                                                    </td>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                        <div class="col">
                                            <table id="categoryTable2" class="table text-center">
                                                <colgroup>
                                                    <col>
                                                    <col style="width: 150px;">
                                                </colgroup>
                                                <thead class="thead-light">
                                                <tr>
                                                    <th>2차 카테고리 목록<br>(하위 카테고리)</th>
                                                    <th>단가 정액/정률<br>별도 사용</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <tr v-if="selectedCategory === null">
                                                    <td colspan="2">
                                                        (1차 카테고리 선택 후<br>2차 카테고리 설정이 가능합니다.)
                                                    </td>
                                                </tr>
                                                <tr v-if="selectedCategory">
                                                    <td>
                                                        <span class="font-weight-bold">{{ selectedCategory.name }} (1차 카테고리)</span>
                                                    </td>
                                                    <td>
                                                        <span v-if="selectedCategory.useIndividual">
                                                            전체 적용중
                                                        </span>
                                                    </td>
                                                </tr>
                                                <template v-if="selectedCategory">
                                                    <tr v-for="(subcategory, index1) in selectedCategory.children">
                                                        <td>
                                                            <div class="d-flex">
                                                                <div>
                                                                    {{ subcategory.name }}
                                                                </div>
                                                                <div class="ml-auto">
                                                                    <a class="btn btn-sm btn-outline-warning mr-1" role="button">수정</a>
                                                                    <a class="btn btn-sm btn-outline-danger" role="button" @click="deleteCategory(subcategory)">삭제</a>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <a v-if="selectedCategory.useIndividual === false" @click="setIndividual(subcategory)" class="btn btn-sm btn-outline-primary btn-check" href="javascript:;" :class="subcategory.useIndividual === true ? 'checked' : ''">
                                                                <i class="fa fa-check"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </template>
                                                </tbody>
                                                <tfoot v-if="selectedCategory">
                                                <tr>
                                                    <td>
                                                        <input v-model="new_subcategory_name" class="form-control form-control-sm"
                                                               placeholder="2차 카테고리 명 입력(예: 농산)" type="text"/>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-outline-primary btn-sm" @click="addSubcategory">추가</button>
                                                    </td>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div>
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
<script src="${contextPath}/resources/js/vue.js"></script>
<script src="${contextPath}/resources/js/axios.js"></script>
<script>
    axios.interceptors.request.use(function (config) {
        $("#overlay").fadeIn(300);
        return config;
    }, function (error) {
        setTimeout(function(){
            $("#overlay").fadeOut(300);
        },500);
        return Promise.reject(error);
    });
    axios.interceptors.response.use(function (response) {
        setTimeout(function(){
            $("#overlay").fadeOut(300);
        },500);
        return response;
    });
    var app = new Vue({
        el: '#app',
        data: {
            categories: [],
            first_category_popup: '',
            use_special_price_rate: '',
            new_category_name: '',
            new_subcategory_name: '',
            selectedCategory: null,
        },
        mounted() {
            axios.get('/categories/data')
                .then(res => res.data)
                .then(data => {
                    this.categories = data.categories;
                    this.first_category_popup = data.first_category_popup;
                    this.use_special_price_rate = data.use_special_price_rate;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        methods: {
            addCategory: function () {
                let token = $("meta[name='_csrf']").attr("content");
                if (this.new_category_name) {
                    axios.post('/categories/store', {
                        name: this.new_category_name,
                        category: 0,
                    }, {
                        headers: {
                            'X-CSRF-TOKEN': token,
                        }
                    })
                        .then(res => res.data)
                        .then(data => {
                            this.categories.push(data.category);
                            this.new_category_name = ''
                        })
                        .catch(error => {
                            console.log(error);
                        });
                }
            },
            selectCategory: function (category) {
                this.selectedCategory = category;
            },
            addSubcategory: function () {
                let token = $("meta[name='_csrf']").attr("content");
                if (this.new_subcategory_name) {
                    axios.post('/categories/store', {
                        name: this.new_subcategory_name,
                        category: this.selectedCategory.id,
                    }, {
                        headers: {
                            'X-CSRF-TOKEN': token,
                        }
                    })
                        .then(res => res.data)
                        .then(data => {
                            this.selectedCategory.children.push(data.category);
                            this.new_subcategory_name = ''
                        })
                        .catch(error => {
                            console.log(error);
                        });
                }
            },
            setIndividual: function (category) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/categories/set_individual', {
                    category: category.id,
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        category.useIndividual = data.useIndividual;
                    })
                    .catch(error => {
                        console.log(error);
                    });
            },
            deleteCategory: function (category) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/categories/delete', {
                    category: category.id,
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        window.location.reload();
                    })
                    .catch(error => {
                        console.log(error);
                    });
            }
        },
        watch: {
            first_category_popup: function(value) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/company/set', {
                    first_category_popup: value,
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                })
                    .then(res => res.data)
                    .then(data => {
                        console.log(data);
                    })
                    .catch(error => {
                        console.error(error);
                    })
            }
        }
    })
</script>
</body>
</html>