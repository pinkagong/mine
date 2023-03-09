<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.solponge.domain.admin.AdminOrderVo" %>
<%@ page import="java.util.List" %>


<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <script>
        function submitForm(button) {
            const form = document.querySelector('#contact-form');
            form.action = "/admin/order/${order.payment_num}/update";
            form.method = "post";
            form.submit();
        }
    </script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/proStyle.css?ver=1">
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div class="container" style="max-width: 100%; padding-right: 0px; padding-left: 0px;">
    <div class="py-5 text-center">
        <h2>주문목록</h2>
    </div>
    <div class="row">
        <div class="col">
            <li class="btn btn-primary float-end">
                <input type="text" name="Search" size="20">
                <a href="components.html"><img src="/img/Magnifier.png" style="width: 20px;" alt="Search"></a>
            </li>
        </div>
    </div>
    <hr class="my-4">
    <div>
        <table class="table">
            <thead>
            <tr>
                <th width="10%"></th>
                <th>주문번호</th>
                <th>회원번호</th>
                <th>상품번호</th>
                <th>수량</th>
                <th>주문일자</th>
                <th>주문자번호</th>
                <th>주소</th>
                <th>배송메세지</th>
                <th>운송장번호</th>
                <th>상태</th>
                <th></th>
                <th width="10%"></th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="order" items="${paymentEntities}">
                <c:if test="${order.success == 1}">
                    <form method="post" action="/com.solponge/admin/order/${String.valueOf(order.payment.paymentNum)}/update">
                        <td width="10%"></td>
                        <td>${order.payment.paymentNum}</td>
                        <td>${order.member.MEMBER_ID}</td>
                        <td>${order.product.product_title}</td>
                        <td>${order.payment.paymentStockNumber}</td>
                        <td>${order.payment.paymentDate}</td>
                        <td>${order.payment.paymentPhone}</td>
                        <td>${order.payment.paymentAddress}</td>
                        <td>${order.delivery.deliveryInfo}</td>
                        <td id = "contact-form">
                        <input type="hidden" name="paymentNum" value="${order.payment.paymentNum}">
                        <input type="text" name="deliveryNum" value="${order.delivery.deliveryNum}">
                        </td>
                        <td>
                        <p id="demo">
                            <c:choose>
                                <c:when test="${order.success==1}">결제완료</c:when>
                                <c:when test="${order.success==2}">배송시작</c:when>
                                <c:otherwise>알수없음</c:otherwise>
                            </c:choose>
                        </p></td>
                        <td><button type="submit">수정</button></td>
                        <td width="10%"></td>
                    </tr>
                    </form>
                </c:if>
            </c:forEach>

            </tbody>
        </table>
        <br>
    </div>
    <div>
        <table class="table">
            <thead>
            <tr>
                <th width="10%"></th>
                <th>주문번호</th>
                <th>회원번호</th>
                <th>상품번호</th>
                <th>수량</th>
                <th>주문일자</th>
                <th>주문자번호</th>
                <th>주소</th>
                <th>배송메세지</th>
                <th>운송장번호</th>
                <th>상태</th>
                <th width="10%"></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="order" items="${paymentEntities}">
                <c:if test="${order.success == 2}">
                    <tr>
                        <td width="10%"></td>
                        <td>${order.payment.paymentNum}</td>
                        <td>${order.member.MEMBER_ID}</td>
                        <td>${order.product.product_title}</td>
                        <td>${order.payment.paymentStockNumber}</td>
                        <td>${order.payment.paymentDate}</td>
                        <td>${order.payment.paymentPhone}</td>
                        <td>${order.payment.paymentAddress}</td>
                        <td>${order.delivery.deliveryInfo}</td>
                        <td>${order.delivery.deliveryNum}</td>
                        <td>
                            <p id="Completion">
                                <c:choose>
                                    <c:when test="${order.success==1}">결제완료</c:when>
                                    <c:when test="${order.success==2}">배송시작</c:when>
                                    <c:otherwise>알수없음</c:otherwise>
                                </c:choose>
                            </p></td>
                        <td width="15%"></td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
        <br>
    </div>
</div> <!-- /container -->
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>