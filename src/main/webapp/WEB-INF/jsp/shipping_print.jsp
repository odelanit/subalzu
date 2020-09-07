<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link href="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/fontawesome-pro/css/all.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/app.css" rel="stylesheet" type="text/css"/>
    <style>
        @media print {
            .page-wrapper {
                page-break-inside: avoid !important;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div id="container" class="py-5">
        <c:forEach items="${orders}" var="order">
            <div class="page-wrapper">
                <h4 class="text-center font-weight-bold my-4">발주서</h4>
                <div class="row mb-2">
                    <div class="col-6">
                        <span class="mr-3">발주일자: ${order.createdAt.format(localDateTimeFormat)}</span>
                        <span>발주번호: ${order.orderCode}</span>
                    </div>
                </div>
                <table class="table table-bordered table-middle mb-0" style="border-left: solid 2px black; border-top: solid 2px black; border-right: solid 2px black">
                    <colgroup>
                        <col width="400px"/>
                        <col width="50px"/>
                        <col width="110px"/>
                        <col width="240px"/>
                    </colgroup>
                    <tbody class="thead-light">
                    <tr>
                        <!-- 가맹점 -->
                        <td class="text-center" rowspan="5">
                            <h3>${order.supplier.name}</h3>
                            <p>${order.orderCode}<br>
                                발주일자: ${order.createdAt.format(localDateTimeFormat)}</p>
                            <p>아래와 같이 발주합니다.</p>
                        </td>
                        <!-- 유통사 -->
                        <th class="text-center" rowspan="5">발<br>주<br>처</th>
                        <td>사업자등록번호</td>
                        <td>${currentCompany.erpCode}</td>
                    </tr>
                    <tr>
                        <!-- 유통사 -->
                        <td class="text-center">상호(법인명)</td>
                        <td>${currentCompany.vendorName}</td>
                    </tr>
                    <tr>
                        <!-- 유통사 -->
                        <td class="text-center">주소</td>
                        <td>[${currentCompany.zipCode}] ${currentCompany.addressLine1} ${currentCompany.addressLine2}</td>
                    </tr>
                    <tr>
                        <!-- 유통사 -->
                        <td class="text-center">연락처/FAX</td>
                        <td>${currentCompany.businessTel}
                            / ${currentCompany.fax}
                        </td>
                    </tr>
                    </tbody>
                </table>
                <table class="table text-center mb-0" style="border-left: solid 2px black; border-right: solid 2px black;">
                    <tbody class="thead-light">
                    <tr>
                        <th>No.</th>
                        <th>상품명</th>
                        <th>규격(단위)</th>
                        <th>제조사(원산지)</th>
                        <th>수량</th>
                        <th>단가</th>
                        <th>총액</th>
                    </tr>
                    <c:forEach items="${order.supplyOrderProducts}" var="orderProduct" varStatus="loop">
                        <tr>
                            <td>${loop.count}</td>
                            <td>${orderProduct.product.name}</td>
                            <td>${orderProduct.product.standard}(${orderProduct.product.unit})</td>
                            <td>${orderProduct.product.makerName}(${orderProduct.product.country})</td>
                            <td><fmt:formatNumber type="number" value="${orderProduct.qty}" /> </td>
                            <td class="text-right"><fmt:formatNumber type="number" value="${orderProduct.price}" /></td>
                            <td class="text-right"><fmt:formatNumber type="number" value="${orderProduct.price * orderProduct.qty}" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <table class="table mb-0" style="border-left: solid 2px black; border-right: solid 2px black;">
                    <tbody class="thead-light">
                    <tr>
                        <th class="text-right">
                            <span class="h5 mr-3">총 발주수량: <fmt:formatNumber type="number" value="${order.totalQty}" />개</span>
                            <span class="h5">총 금액: <fmt:formatNumber type="number" value="${order.totalFunds}" />원</span>
                        </th>
                    </tr>
                    </tbody>
                </table>
                <table class="table mb-5" style="border-left: solid 2px black; border-right: solid 2px black; border-bottom: solid 2px black; margin-bottom: 30px;">
                    <colgroup>
                        <col width="100px"/>
                        <col width="240px"/>
                    </colgroup>
                    <tbody class="thead-light">
                    <tr>
                        <th class="text-center">비고</th>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </c:forEach>
    </div>
</div>
<div class="fixed-bottom py-4 bg-light" style="border-top: solid 1px rgb(204, 204, 204)">
<div class="row justify-content-center">
    <div class="col-3">
        <button type="button" class="btn btn-primary btn-block print">출력</button>
    </div>
</div>
</div>
<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/printThis/printThis.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
<script>
    function printDiv(divName){
        var printContents = document.getElementById(divName).innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = printContents;

        window.print();

        document.body.innerHTML = originalContents;

    }
    var token = $("meta[name='_csrf']").attr("content");
    $('.print').on('click', function() {
        // $('#container').printThis();
        printDiv('container');
    })
</script>
</body>
</html>