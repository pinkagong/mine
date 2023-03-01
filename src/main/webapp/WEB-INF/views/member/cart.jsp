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
    <c:forEach items="${cartItems}" var="cartItem">
        <div class="cart__item">
            <img class="cart__item-img" src="${cartItem.product.product_img}" alt="${cartItem.product.product_title}">
            <div class="cart__item-info">
                <div class="cart__item-title">${cartItem.product.product_title}</div>
                <div class="cart__item-price">가격: ${cartItem.product.product_price}원</div>
                <div class="cart__item-quantity">수량: ${cartItem.CART_ITEM_STOCK}개</div>
                <div class="cart__item-total-price">총 가격: ${cartItem.totalPrice}원</div>
            </div>
            <div class="cart_Item_check">
                <input type="checkbox" name="order">[담기]
            </div>
            <div class="cart__item-remove">[삭제]</div>
        </div>
    </c:forEach>
</div>
</body>
</html>
