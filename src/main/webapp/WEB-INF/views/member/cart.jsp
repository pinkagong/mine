<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="h" tagdir="/WEB-INF/tags"%>
<html>
<head>
    <title>장바구니</title>
    <style>
        /* 장바구니 스타일 */
        .cart {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .cart__item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ccc;
        }

        .cart__item-img {
            width: 100px;
            height: 100px;
            margin-right: 20px;
        }

        .cart__item-info {
            flex-grow: 1;
        }

        .cart__item-title {
            font-weight: bold;
            font-size: 1.2rem;
        }

        .cart__item-price {
            margin-top: 10px;
        }

        .cart__item-quantity {
            margin-top: 10px;
        }

        .cart__item-total-price {
            margin-top: 10px;
            font-weight: bold;
        }

        .cart__item-remove {
            margin-left: 20px;
            cursor: pointer;
        }

    </style>
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div class="cart">
    <h1>${loginMember.MEMBER_NAME}님의 장바구니</h1>
    <hr>
    <form method="post" action="/com.solponge/member/${loginMember.MEMBER_NO}/myPage/cart">
        <c:forEach items="${cart.cartItems}" var="entry">
            <c:set var="product" value="${entry.value.product}" />
            <div class="cart__item">
                <img class="cart__item-img" src="${product.product_img}" alt="${cartItem.product.product_title}">
                <div class="cart__item-info">
                    <div class="cart__item-title">${product.product_title}</div>
                    <div class="cart__item-price">가격: ${product.product_price}원</div>
                    <div class="cart__item-quantity">상태: <input type="text" value="${entry.value.CART_ITEM_STOCK}" style="width: 20px;"></div>
                    <input type="hidden" name="cartItems" value="${product.product_num},${entry.value.CART_ITEM_STOCK},${loginMember.MEMBER_NO}">
                </div>
                <div class="cart_Item_check">
                    <input type="checkbox" name="order"><img src="${pageContext.request.contextPath}/img/basket.png" alt="cart.ico" style="width: 25px;">
                </div>
                <div class="cart__item-remove">
                    <button type="submit" formaction="/com.solponge/member/${loginMember.MEMBER_NO}/myPage/cart/deleteCartItem" name="cartItemNum" value="${entry.value.CART_ITEM_NUM}">
                        <img src="${pageContext.request.contextPath}/img/delete.png" alt="delete.ico" style="width: 25px;"/>
                    </button>
                </div>
            </div>
        </c:forEach>
        <br>
        <div id="cart_total_price" style="align-content: center">
            총 결제 금액 : ${cart.totalPrice} 원
        </div>
        <br>

        <button type="submit" formaction="/com.solponge/member/${loginMember.MEMBER_NO}/myPage/cart">주문하기</button>
    </form>



</div>
</body>
</html>
