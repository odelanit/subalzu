<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/toastr-2.1.4/toastr.min.css" rel="stylesheet" type="text/css"/>
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
                    <i class="fa fa-times"></i>
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
                                <li class="breadcrumb-item">매입처 잔액 관리</li>
                                <li class="breadcrumb-item active" aria-current="page">매입처 잔액 상세내역</li>
                            </ol>
                        </nav>
                        <h4 class="mb-1 mt-0">매입처 잔액 상세 내역</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="row mb-2">
                            <div class="col-auto">
                                <div class="card">
                                    <div class="card-body p-0">
                                        <div class="media p-3 align-items-center">
                                            <div class="media-body mr-5">
                                                <h3 class="mb-0">${supplier.name}</h3>
                                            </div>
                                            <div class="align-self-center">
                                                <span class="d-block text-muted text-right font-weight-bold">현재 잔액</span>
                                                <span class="h3 text-danger"><fmt:formatNumber type="number"
                                                                                               value="${supplier.totalFunds}"/>원</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <form:form modelAttribute="searchForm" method="get">
                                    <table class="table form-table table-bordered">
                                        <tbody class="thead-light">
                                        <tr>
                                            <th>기간</th>
                                            <td>
                                                <div class="form-inline">
                                                    <div class="btn-group btn-group-sm btn-group-toggle mr-4" data-toggle="buttons">
                                                        <label class="btn btn-outline-primary active">
                                                            <form:radiobutton path="period" value="-1" label="전체" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" value="2" label="전월" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" value="1" label="금월" />
                                                        </label>
                                                        <label class="btn btn-outline-primary">
                                                            <form:radiobutton path="period" value="0" label="당일" />
                                                        </label>
                                                    </div>
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateFrom" cssClass="form-control"/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <span class="mx-2">-</span>
                                                    <div class="input-group input-group-sm">
                                                        <form:input path="dateTo" cssClass="form-control"/>
                                                        <div class="input-group-append">
                                                            <span class="input-group-text">
                                                                <i class="fa fa-calendar"></i>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td style="width: 20%;">
                                                <button class="btn btn-primary">검색</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>즉시 검색</th>
                                            <td colspan="2">
                                                <div class="form-inline" id="imSearch">
                                                    <form:select class="form-control form-control-sm w-20 mr-2"
                                                                 path="type">
                                                        <form:option value="" label="구분"/>
                                                        <form:option value="output" label="출금"/>
                                                        <form:option value="shipping" label="매입"/>
                                                        <form:option value="update" label="수정"/>
                                                    </form:select>
                                                    <form:select class="form-control form-control-sm w-20"
                                                                 path="method">
                                                        <form:option value="" label="처리방식"/>
                                                        <form:option value="manual_order" label="일반 발주"/>
                                                        <form:option value="auto_order" label="자동 발주"/>
                                                        <form:option value="direct_minus" label="직접 출금"/>
                                                        <form:option value="fund_minus" label="금액 차감"/>
                                                        <form:option value="fund_plus" label="금액 추가"/>
                                                        <form:option value="canceled_order" label="발주 취소"/>
                                                    </form:select>
                                                </div>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </form:form>
                                <div class="row mb-3 align-items-center">
                                    <div class="col-lg-6">
                                        <span>전체 ${transactionPage.totalElements}건</span>
                                        <button type="button" class="btn btn-sm btn-primary" data-toggle="modal"
                                                data-target="#outputModal">출금 처리
                                        </button>
                                        <button type="button" class="btn btn-sm btn-secondary" data-toggle="modal"
                                                data-target="#manualModal">직접 수정
                                        </button>
                                    </div>
                                    <div class="col-lg-6 text-lg-right">
                                        <a class="btn btn-sm btn-outline-primary"
                                           href="/balance/${supplier.id}/download_excel">
                                            <i class="fa fa-file-excel"></i> Excel 다운로드
                                        </a>
                                    </div>
                                </div>
                                <table class="table table-middle table-striped text-center">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>#</th>
                                        <th>일시</th>
                                        <th>구분</th>
                                        <th>거래 방식</th>
                                        <th>거래 금액</th>
                                        <th>총 잔액</th>
                                        <th>비고</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${transactions}" var="transaction">
                                        <tr>
                                            <td>${transaction.id}</td>
                                            <td>${transaction.createdAt.format(localDateTimeFormat)}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${transaction.type == 'output'}">
                                                        출금
                                                    </c:when>
                                                    <c:when test="${transaction.type == 'shipping'}">
                                                        매입
                                                    </c:when>
                                                    <c:when test="${transaction.type == 'update'}">
                                                        수정
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${transaction.method == 'direct_minus'}">
                                                        직접 출금
                                                    </c:when>
                                                    <c:when test="${transaction.method == 'fund_minus'}">
                                                        금액 차감
                                                    </c:when>
                                                    <c:when test="${transaction.method == 'fund_plus'}">
                                                        금액 추가
                                                    </c:when>
                                                    <c:when test="${transaction.method == 'manual_order'}">
                                                        일반 발주
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatNumber value="${transaction.amount}" type="number"/>원</td>
                                            <td><fmt:formatNumber value="${transaction.totalAmount}" type="number"/>원
                                            </td>
                                            <td>${transaction.description}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
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
<div class="modal fade" id="outputModal">
    <div class="modal-dialog-centered modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <div class="modal-title text-light">
                    출금 처리
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div id="output">
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">{{ supplierName }}</div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                            {{ formatNumber(prevTotalFunds) }} 원
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4" for="inputFunds">입금 금액</label>
                        <div class="col-8 text-right">
                            <input type="text" id="inputFunds" class="form-control form-control-sm text-right"
                                   v-model="displayFunds">
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">입금 후 잔액</label>
                        <div class="col-8 text-right text-danger">
                            <span>{{ formatNumber(prevTotalFunds - funds) }}</span> 원
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">비고</label>
                        <div class="col-8">
                            <textarea class="form-control form-control-sm" v-model="description"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-primary" onclick="submitOutput()">적용</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="manualModal">
    <div class="modal-dialog-centered modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-secondary">
                <div class="modal-title text-light">
                    직접 수정
                </div>
                <button class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div id="update">
                    <div class="form-group row">
                        <label class="col-form-label col-4">구분</label>
                        <div class="col-8 text-right">
                            <div class="custom-control custom-control-inline custom-radio">
                                <input type="radio" class="custom-control-input" v-model="method" value="fund_minus"
                                                  id="transactionType1"/>
                                <label class="custom-control-label" for="transactionType1">금액 차감</label>
                            </div>
                            <div class="custom-control custom-control-inline custom-radio">
                                <input type="radio" class="custom-control-input" v-model="method" value="fund_plus"
                                                  id="transactionType2"/>
                                <label class="custom-control-label" for="transactionType2">금액 추가</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">거래처</label>
                        <div class="col-8 text-right">
                            {{ supplierName }}
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">총 잔액</label>
                        <div class="col-8 text-right">
                            {{ formatNumber(prevTotalFunds) }} 원
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 금액</label>
                        <div class="col-8 text-right">
                            <input type="text" class="form-control text-right form-control-sm" v-model="displayFunds"/>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">수정 후 잔액</label>
                        <div class="col-8 text-right text-danger">
                            <span>{{ formatNumber(totalFunds) }}</span> 원
                        </div>
                    </div>
                    <hr>
                    <div class="form-group row">
                        <label class="col-form-label col-4">비고</label>
                        <div class="col-8">
                            <textarea v-model="description" class="form-control-sm form-control" rows="3"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
                <button class="btn btn-primary" onclick="submitUpdate()">적용</button>
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
<script src="${contextPath}/resources/js/vue.js"></script>
<script src="${contextPath}/resources/js/axios.js"></script>
<script>
    var fundsOutput = new Vue({
        el: '#output',
        data: {
            prevTotalFunds: 0,
            funds: 0,
            totalFunds: 0,
            supplierName: '',
            description: '',
            isInputActive: false,
            type: 'output',
            method: 'direct_minus',
        },
        mounted() {
            axios.get(window.location.pathname + '/ajax')
                .then(res => res.data)
                .then(data => {
                    this.prevTotalFunds = data.totalFunds;
                    this.supplierName = data.name;
                })
                .catch(error => {
                    console.error(error);
                });
        },
        computed: {
            displayFunds: {
                get: function () {
                    let fixedValue = this.toFixed(this.funds);
                    // if (this.isInputActive) {
                    //     return fixedValue.toString();
                    // } else {
                        return fixedValue.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    // }
                },
                set: function (modifiedValue) {
                    let newValue = parseFloat(modifiedValue.replace(/[^\d\.]/g, ""));
                    if (isNaN(newValue)) {
                        newValue = 0;
                    }
                    this.funds = newValue;
                }
            }
        },
        methods: {
            formatNumber(value) {
                let fixedValue = this.toFixed(value);
                return fixedValue.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            },
            toFixed(x) {
                if (Math.abs(x) < 1.0) {
                    var e = parseInt(x.toString().split('e-')[1]);
                    if (e) {
                        x *= Math.pow(10, e - 1);
                        x = '0.' + (new Array(e)).join('0') + x.toString().substring(2);
                    }
                } else {
                    var e = parseInt(x.toString().split('+')[1]);
                    if (e > 20) {
                        e -= 20;
                        x /= Math.pow(10, e);
                        x += (new Array(e + 1)).join('0');
                    }
                }
                return x;
            },
            applyFunds() {
                let currentUrl = window.location.pathname;
                let token = $("meta[name='_csrf']").attr("content");
                axios.post(currentUrl + '/add', {
                    funds: this.funds,
                    type: this.type,
                    method: this.method,
                    description: this.description
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
                        console.error(error);
                    });
            }
        }
    });

    var fundsUpdate = new Vue({
        el: '#update',
        data: {
            prevTotalFunds: 0,
            funds: 0,
            supplierName: '',
            description: '',
            isInputActive: false,
            type: 'update',
            method: 'fund_minus',
        },
        mounted() {
            axios.get(window.location.pathname + '/ajax')
                .then(res => res.data)
                .then(data => {
                    this.prevTotalFunds = data.totalFunds;
                    this.supplierName = data.name;
                })
                .catch(error => {
                    console.error(error);
                });
        },
        computed: {
            displayFunds: {
                get: function () {
                    let fixedValue = this.toFixed(this.funds);
                    // if (this.isInputActive) {
                    //     return fixedValue.toString();
                    // } else {
                        return fixedValue.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    // }
                },
                set: function (modifiedValue) {
                    let newValue = parseFloat(modifiedValue.replace(/[^\d\.]/g, ""));
                    if (isNaN(newValue)) {
                        newValue = 0;
                    }
                    this.funds = newValue;
                }
            },
            totalFunds: {
                get: function() {
                    if (this.method.includes("minus")) {
                        return this.prevTotalFunds - this.funds;
                    } else {
                        return this.prevTotalFunds + this.funds;
                    }
                }
            }
        },
        methods: {
            formatNumber(value) {
                let fixedValue = this.toFixed(value);
                return fixedValue.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            },
            toFixed(x) {
                if (Math.abs(x) < 1.0) {
                    var e = parseInt(x.toString().split('e-')[1]);
                    if (e) {
                        x *= Math.pow(10, e - 1);
                        x = '0.' + (new Array(e)).join('0') + x.toString().substring(2);
                    }
                } else {
                    var e = parseInt(x.toString().split('+')[1]);
                    if (e > 20) {
                        e -= 20;
                        x /= Math.pow(10, e);
                        x += (new Array(e + 1)).join('0');
                    }
                }
                return x;
            },
            applyFunds() {
                let currentUrl = window.location.pathname;
                let token = $("meta[name='_csrf']").attr("content");
                axios.post(currentUrl + '/add', {
                    funds: this.funds,
                    type: this.type,
                    method: this.method,
                    description: this.description
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
                        console.error(error);
                    });
            }
        }
    });

    function submitOutput() {
        fundsOutput.applyFunds();
    }

    function submitUpdate() {
        fundsUpdate.applyFunds();
    }

    formatDate = function (date) {
        let month = '' + (date.getMonth() + 1),
            day = '' + date.getDate(),
            year = date.getFullYear();

        if (month.length < 2)
            month = '0' + month;
        if (day.length < 2)
            day = '0' + day;

        return [year, month, day].join('-');
    };

    $('input[name="period"]').on('change', function() {
        var diff = +$(this).val();
        const dateTo = new Date();
        let strDateTo = formatDate(dateTo);
        if (diff === -1) {
            $('#dateFrom').val('2020-01-01');
            $('#dateTo').val(strDateTo);
        } else if (diff === 0) {
            $('#dateFrom').val(strDateTo);
            $('#dateTo').val(strDateTo);
        } else if (diff === 1) {
            let firstDay = new Date(dateTo.getFullYear(), dateTo.getMonth(), 1);
            let lastDay = new Date(dateTo.getFullYear(), dateTo.getMonth() + 1, 0);
            $('#dateFrom').val(formatDate(firstDay));
            $('#dateTo').val(formatDate(lastDay));
        } else if (diff === 2) {
            let firstDay = new Date(dateTo.getFullYear(), dateTo.getMonth() - 1, 1);
            let lastDay = new Date(dateTo.getFullYear(), dateTo.getMonth(), 0);
            $('#dateFrom').val(formatDate(firstDay));
            $('#dateTo').val(formatDate(lastDay));
        }
    });

    $('#imSearch select').on('change', function() {
        $('#searchForm').submit();
    });
</script>
</body>
</html>