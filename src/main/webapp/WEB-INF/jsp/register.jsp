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
                                <div class="mx-auto mb-1">
                                    <a href="/">
                                        <img src="${contextPath}/resources/images/logo.png" alt="" height="24" />
                                        <h3 class="d-inline align-middle ml-1 text-logo">Pando</h3>
                                    </a>
                                </div>

                                <h6 class="h5 mb-0 mt-4 mb-3">계정 등록</h6>

                                <%--@elvariable id="userForm" type="com.pando.subalzu.model.User"--%>
                                <form:form method="POST" modelAttribute="userForm" class="authentication-form">
                                    <spring:bind path="fullName">
                                        <div class="form-group required">
                                            <label>담당자</label>
                                            <form:input type="text" path="fullName" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="담당자"
                                                        autofocus="true" />
                                            <div class="invalid-feedback">
                                                <form:errors path="fullName" />
                                            </div>
                                        </div>
                                    </spring:bind>
                                    
                                    <spring:bind path="phone">
                                        <div class="form-group required">
                                            <label>담당자 휴대폰</label>
                                            <form:input type="text" path="phone" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="숫자만 입력해주세요"
                                                        autofocus="true" />
                                            <div class="invalid-feedback">
                                                <form:errors path="phone" />
                                            </div>
                                        </div>
                                    </spring:bind>

                                    <spring:bind path="username">
                                        <div class="form-group required">
                                            <label>아이디</label>
                                            <form:input type="text" path="username" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="4자 이상 영문 또는 숫자만 사용 가능"
                                                        autofocus="true" />
                                            <div class="invalid-feedback">
                                                <form:errors path="username" />
                                            </div>
                                        </div>
                                    </spring:bind>

                                    <spring:bind path="password">
                                        <div class="form-group required">
                                            <label>비밀번호</label>
                                            <form:input type="password" path="password" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="6자 이상 영문, 숫자 조합" />
                                            <div class="invalid-feedback">
                                                <form:errors path="password" />
                                            </div>
                                        </div>
                                    </spring:bind>

                                    <spring:bind path="passwordConfirm">
                                        <div class="form-group required">
                                            <label>비밀번호 확인</label>
                                            <form:input type="password" path="passwordConfirm" class="form-control ${status.error ? 'is-invalid' : ''}"
                                                        placeholder="비밀번호를 다시 입력해주세요." />
                                            <div class="invalid-feedback">
                                                <form:errors path="passwordConfirm" />
                                            </div>
                                        </div>
                                    </spring:bind>

                                    <spring:bind path="bio">
                                        <div class="form-group">
                                            <label>비고</label>
                                            <form:input type="text" path="bio" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="내용을 입력해주세요."
                                                        autofocus="true" />
                                            <div class="invalid-feedback">
                                                <form:errors path="bio" />
                                            </div>
                                        </div>
                                    </spring:bind>

                                    <div class="form-group mb-4">
                                        <div class="custom-control custom-checkbox">
                                            <input type="checkbox" class="custom-control-input"
                                                   id="checkbox-signup" checked>
                                            <label class="custom-control-label" for="checkbox-signup">
                                                I accept <a href="javascript: void(0);">Terms and Conditions</a>
                                            </label>
                                        </div>
                                    </div>

                                    <div class="form-group mb-0 text-center">
                                        <button class="btn btn-primary btn-block" type="submit">Sign Up</button>
                                    </div>
                                </form:form>
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
                        <p class="text-muted">Already have account? <a href="${contextPath}/login" class="text-primary font-weight-bold ml-1">Login</a></p>
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