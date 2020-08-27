<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="request" value="${pageContext.request}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
                <div class="media-body">
                    <a href="/company">
                        <h4 class="pro-user-name mt-0 mb-0">${companyName}</h4>
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
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/orders')}">class="mm-active"</c:if>>
                            <a href="/orders">주문 목록</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/order_products')}">class="mm-active"</c:if>>
                            <a href="/order_products">상품별 주문 목록</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/return_orders')}">class="mm-active"</c:if>>
                            <a href="/return_orders">반품 내역</a>
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
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/shipping')}">class="mm-active"</c:if>>
                            <a href="/shipping">발주 관리</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/suppliers')}">class="mm-active"</c:if>>
                            <a href="/suppliers">매입처 관리</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/balance')}">class="mm-active"</c:if>>
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
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/products')}">class="mm-active"</c:if>>
                            <a href="/products">상품 관리</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/categories')}">class="mm-active"</c:if>>
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
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/price-groups')}">class="mm-active"</c:if>>
                            <a href="/price-groups">단가 그룹 관리</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/special-prices')}">class="mm-active"</c:if>>
                            <a href="/special-prices">특 단가 관리</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/prices') || fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/fixed_price_rate')}">class="mm-active"</c:if>>
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
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/stock_rest')}">class="mm-active"</c:if>>
                            <a href="/stock_rest">입/출고 관리</a>
                        </li>
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/stock-history')}">class="mm-active"</c:if>>
                            <a href="/stock-history">입/출고 내역</a>
                        </li>
                    </ul>
                </li>
                <security:authorize access="hasAnyAuthority('admin', 'sales')">
                    <li>
                        <a href="javascript: void(0);">
                            <i class="fa fa-folder"></i>
                            <span> 거래처 관리 </span>
                            <span class="menu-arrow"></span>
                        </a>

                        <ul class="nav-second-level" aria-expanded="false">
                            <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/shops')}">class="mm-active"</c:if>>
                                <a href="/shops">거래처 목록</a>
                            </li>
                            <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/credits')}">class="mm-active"</c:if>>
                                <a href="/credits">외상잔액/예치금 관리</a>
                            </li>

                        </ul>
                    </li>
                </security:authorize>
                <li>
                    <a href="javascript: void(0);">
                        <i class="fa fa-folder"></i>
                        <span> 서비스 관리 </span>
                        <span class="menu-arrow"></span>
                    </a>

                    <ul class="nav-second-level" aria-expanded="false">
                        <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/notices')}">class="mm-active"</c:if>>
                            <a href="/notices">공지사항</a>
                        </li>
                        <security:authorize access="hasAuthority('admin')">
                            <li <c:if test="${fn:startsWith(requestScope['javax.servlet.forward.request_uri'], '/users')}">class="mm-active"</c:if>>
                                <a href="/users">직원 관리</a>
                            </li>
                        </security:authorize>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- End Sidebar -->

        <div class="clearfix"></div>
    </div>
    <!-- Sidebar -left -->

</div>