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
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">

    <!-- App css -->
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${contextPath}/resources/css/app.css" rel="stylesheet" type="text/css"/>
</head>

<body class="authentication-bg">
<div class="account-pages my-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-10">
                <div class="card">
                    <div class="card-body p-0">
                        <div class="row">
                            <div class="col-md-6 p-5">
                                <div class="mx-auto mb-5">
                                    <a href="/">
                                        <img src="${contextPath}/resources/images/logo.png" alt="" height="24" />
                                        <h3 class="d-inline align-middle ml-1 text-logo">Pando</h3>
                                    </a>
                                </div>
                                <h6 class="h5 mb-0 mt-4">Welcome back!</h6>
                                <p class="text-muted mt-1 mb-4">Enter your username and password to access admin panel.</p>

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

                                <form method="POST" action="${contextPath}/login" class="authentication-form">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <div class="form-group">
                                        <label class="form-control-label">Username</label>
                                        <input name="username" type="text" class="form-control" placeholder="Username"
                                               autofocus="true"/>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-control-label">Password</label>
                                        <input name="password" type="password" class="form-control" placeholder="Enter your password"/>
                                    </div>
                                    <div class="form-group mb-4">
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input"
                                                   id="checkbox-signin" checked>
                                            <label class="custom-control-label" for="checkbox-signin">Remember me</label>
                                        </div>
                                    </div>
                                    <div class="form-group mb-0">
                                        <button class="btn btn-primary btn-block" type="submit">Log In</button>
                                    </div>
                                </form>
                            </div>
                            <div class="col-lg-6 d-none d-md-inline-block">
                                <div class="auth-page-sidebar">
                                    <div class="overlay"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12 text-center">
                        <p class="text-muted">Don't have an account? <a href="${contextPath}/register" class="text-primary font-weight-bold ml-1">Sign Up</a></p>
                    </div> <!-- end col -->
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${contextPath}/resources/js/vendor.min.js"></script>
<script src="${contextPath}/resources/js/app.min.js"></script>
</body>
</html>