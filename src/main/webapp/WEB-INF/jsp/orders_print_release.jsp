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
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-9">
            <div id="container" class="py-5">
                <div class="text-center mb-5">
                    <h5>출고지시서</h5>
                </div>
                <div class="row mb-2">
                    <div class="col-6">
                        출력일 : ${printDate.format(localDateTimeFormat)}
                    </div>
                    <div class="col-6 text-right">
                        총 상품 수량: <fmt:formatNumber type="number" value="${totalQty}" />
                    </div>
                </div>
                <table class="table table-middle text-center" style="border: 2px solid black">
                    <thead class="thead-light">
                    <tr>
                        <th style="width: 70px;">#</th>
                        <th>상품코드</th>
                        <th>상품명</th>
                        <th>수량</th>
                        <th>규격(단위)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orderProducts}" var="orderProduct" varStatus="loop">
                        <tr>
                            <td>${loop.count}</td>
                            <td>${orderProduct.product.erpCode}</td>
                            <td>${orderProduct.product.name}</td>
                            <td><fmt:formatNumber value="${orderProduct.qty}" type="number" /></td>
                            <td>${orderProduct.product.standard} <c:if test="${not empty orderProduct.product.unit}">(${orderProduct.product.unit})</c:if> </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                    <tfoot class="thead-light">
                    <tr>
                        <th colspan="5" class="text-right text-dark">
                            총 상품 수량: <fmt:formatNumber type="number" value="${totalQty}" />
                        </th>
                    </tr>
                    <tr>
                        <th colspan="2">거래 가맹점 명(${shops.size()})</th>
                        <td colspan="3" class="text-left">
                            <c:forEach items="${shops}" var="shop" varStatus="loop">
                                ${shop.name}
                                <c:if test="${not loop.last}">,</c:if>
                            </c:forEach>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="fixed-bottom bg-light" style="border-top: solid 1px rgb(204, 204, 204)">
    <div class="row justify-content-center my-3">
        <div class="col-2">
            <button class="btn btn-block btn-primary" id="print">출력하기</button>
        </div>
    </div>
</div>
<script src="${contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${contextPath}/resources/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script src="${contextPath}/resources/bootstrap-4.4.1/js/bootstrap.bundle.min.js"></script>
<script src="${contextPath}/resources/printThis/printThis.js"></script>
<script>
    $('#print').on('click', function() {
        $('#container').printThis();
    })
</script>
</body>
</html>