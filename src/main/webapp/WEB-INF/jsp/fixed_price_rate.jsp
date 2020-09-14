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
    <jsp:include page="sidebar.jsp"/>
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
                                <li class="breadcrumb-item active" aria-current="page">정액 / 정률 관리</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">정액/정률 관리</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div id="app" v-cloak>
                            <div class="card mb-4">
                                <div class="card-body">
                                    <h5 class="card-title">정액/정률 사용 설정 <span data-toggle="modal"
                                                                             data-target="#infoModal"
                                                                             class="fa fa-info-circle"></span></h5>
                                    <div class="form-group row">
                                        <label class="col-form-label col-lg-2">설정 여부</label>
                                        <div class="col-lg-10">
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input type="radio" class="custom-control-input" v-model="use_special_price_rate"
                                                       value="true" id="flat1">
                                                <label class="custom-control-label" for="flat1">설정</label>
                                            </div>
                                            <div class="custom-control custom-control-inline custom-radio">
                                                <input type="radio" class="custom-control-input" v-model="use_special_price_rate"
                                                       value="false" id="flat2">
                                                <label class="custom-control-label" for="flat2">비설정</label>
                                            </div>
                                            <small class="form-text">
                                                * 타이틀 우측의 ?를 누르면 자세한 내용을 확인하실수 있습니다.
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-4" id="price-rate" v-show="use_special_price_rate === 'true'">
                                <div class="card-body">
                                    <h5 class="card-title">단가 그룹/상품 카테고리</h5>
                                    <p>* 정률값( (매입단가/100) &times; 설정% )의 소숫점은 올림 처리하고, 나머지 원 단위는 절삭합니다.</p>
                                    <p>* 상품 카테고리별로 정액/정률을 별도 설정하시려면 <a href="/categories">상품 관리 > 카테고리 설정</a>에서 먼저 사용여부를
                                        설정해
                                        주세요.</p>
                                    <div class="table-responsive">
                                        <table class="table table-middle text-center">
                                            <thead class="thead-light">
                                            <tr>
                                                <th style="width: 100px;">카테고리</th>
                                                <th v-for="priceGroup in priceGroups">
                                                    <template v-if="priceGroup.name === 'direct'">직배송 단가</template>
                                                    <template v-else-if="priceGroup.name === 'parcel'">택배배송 단가</template>
                                                    <template v-else-if="priceGroup.name === 'main'">기본 단가</template>
                                                    <template v-else>{{ priceGroup.name }}</template>
                                                </th>
                                                <th style="width: 100px;">삭제</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr v-for="row in matrix">
                                                <td>
                                                    <template v-if="row[0].category">
                                                        {{ row[0].category.name }}
                                                    </template>
                                                    <template v-else>
                                                        기본 설정
                                                    </template>
                                                </td>
                                                <td v-for="column in row">
                                                    <div class="input-group input-group-sm">
                                                        <input type="text" v-model="column.rate"
                                                               class="form-control text-right"/>
                                                        <div class="input-group-append">
                                                            <select class="form-control form-control-sm" v-model="column.unit">
                                                                <option value="w">원</option>
                                                                <option value="p">%</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <button v-if="row[0].category !== null" class="btn btn-outline-danger btn-sm" @click="deleteFixedPriceRate(row[0])">삭제</button>
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <a href="/prices" class="btn btn-secondary">이전 목록으로</a>
                                <button class="btn btn-primary" @click="saveMatrix">설정 저장</button>
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
    </div>
</div>
<div class="modal fade" id="infoModal">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">정액/정률 사용법 안내</div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <p class="text-primary">
                    * 설정 여부를 설정으로 놓고, 단가그룹별로 설정값을 세팅한 뒤, 적용버튼을 누르면 사용처리가 됩니다.<br>
                    * 해당 기능의 적용 범위는 아래와 같습니다.
                </p>
                <table class="table">
                    <thead class="thead-light">
                    <tr>
                        <th style="width: 25%;">적용부분</th>
                        <th style="width: 75%;">설명</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th>상품 대량 등록/수정</th>
                        <td>
                            상품 관리에서 상품 엑셀 대량 등록/수정시 입력하신 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.
                        </td>
                    </tr>
                    <tr>
                        <th>상품 등록/수정</th>
                        <td>상품 관리에서 새로운 상품 등록 및 기존 상품 수정 시 입력하신 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.</td>
                    </tr>
                    <tr>
                        <th>상품 단가 일괄 적용</th>
                        <td>
                            단가 관리 &gt; 상품 단가 일괄 적용 메뉴에서 매입단가 입력 및 단가 일괄 수정 시 입력한 매입단가를 기준으로 설정값에 맞게 그룹단가가 세팅됩니다.
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-dismiss="modal">닫기</button>
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
<script src="${contextPath}/resources/js/vue.js"></script>
<script src="${contextPath}/resources/js/axios.js"></script>
<script>
    var app = new Vue({
        el: '#app',
        data: {
            use_special_price_rate: 'false',
            priceGroups: [],
            categories: [],
            matrix: [],
        },
        mounted() {
            axios.get('/fixed_price_rate/data')
                .then(res => res.data)
                .then(data => {
                    this.use_special_price_rate = data.use_special_price_rate;
                    this.priceGroups = data.priceGroups;
                    this.categories = data.categories;
                    this.matrix = data.matrix;
                })
                .catch(error => {
                    console.error(error);
                });
        },
        methods: {
            deleteFixedPriceRate(column) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/categories/set_individual', {
                    category: column.category.id,
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
            },
            saveMatrix() {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/fixed_price_rate/store', {
                    matrix: this.matrix,
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
            use_special_price_rate: function(value) {
                let token = $("meta[name='_csrf']").attr("content");
                axios.post('/company/set', {
                    use_special_price_rate: value,
                }, {
                    headers: {
                        'X-CSRF-TOKEN': token,
                    }
                });
            }
        }
    })
</script>
</body>
</html>