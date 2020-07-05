<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Pando</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="" name="description"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>

    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.svg">

    <!-- App css -->
    <link href="${contextPath}/resources/bootstrap-4.4.1/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>
</head>

<body class="vh-100">
<div class="container h-100">
    <div class="row justify-content-center h-100 align-items-center">
        <div class="col-md-8 col-lg-6">
            <div class="card">
                <div class="card-body">
                    <div class="text-center">
                        <a href="/">
                            <img src="${contextPath}/resources/images/logo.png" alt="" height="100" />
                        </a>
                    </div>

                    <c:if test="${error != null}" >
                        <div class="alert alert-danger">
                            <span>${error}</span>
                        </div>
                    </c:if>

                    <c:if test="${message != null}" >
                        <div class="alert alert-success">
                            <span>${message}</span>
                        </div>
                    </c:if>

                    <form:form method="POST" action="${contextPath}/login">
                        <div class="form-group">
                            <label class="form-control-label">ID</label>
                            <input name="username" type="text" class="form-control" placeholder="ID" autofocus />
                        </div>
                        <div class="form-group">
                            <label class="form-control-label">비밀번호</label>
                            <input name="password" type="password" class="form-control" placeholder="비밀번호"/>
                        </div>
                        <div class="form-group mb-0">
                            <button class="btn btn-primary btn-block" type="submit">가입</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/js/vendor.min.js"></script>
</body>
</html>