<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상품 상세 정보</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/proStyle.css?ver=2">
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
    <div style="max-width: 1500px">
        <div class="py-5 text-center">
            <h2>상품 상세 정보</h2>
        </div>
        <hr>
        <div class="row">
                    <div class="col">
                        <button onclick="location.href='/com.solponge/admin/product'" type="button">상품 목록 </button>
                    </div>
                    <div class="col">
                        <button onclick="location.href='${product.product_num}/edit'" type="button">상품 수정 </button>
                    </div>
                    <div class="col">
                        <form id="delete" action="${product.product_num}/delete" method="post">
                            <input type="hidden" name="_method" value="DELETE"/>
                            <button onclick="return confirm('정말 삭제하시겠습니까?')" type="submit">상품 삭제 </button>
                        </form>
                    </div>
                </div>
            </div> <!-- /container -->
        <div>
            <table>
                <tr>
                    <th>번호</th>
                    <td>${product.product_num}</td>
                </tr>
                <tr>
                    <th>상품명</th>
                    <td>${product.product_title}</td>
                </tr>
                <tr>
                    <th>부제목</th>
                    <td>${product.product_subtitle}</td>
                </tr>
                <tr>
                    <th>작가</th>
                    <td>${product.product_writer}</td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td>${product.product_price}</td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td><img src=${product.product_img} alt="img"></td>
                </tr>
                <tr>
                    <th>출간일</th>
                    <td>${product.product_date}</td>
                </tr>
                <tr>
                    <th>페이지 수</th>
                    <td>${product.product_page}</td>
                </tr>
                <tr>
                    <th>재고</th>
                    <td>${product.product_stock}</td>
                </tr>
                <tr>
                    <th>판매량</th>
                    <td>${product.product_sale}</td>
                </tr>
                <tr>
                    <th>방문 수</th>
                    <td>${product.product_visit}</td>
                </tr>
                 <tr>
                    <th>내용</th>
                    <td width = "70%">${product.product_code}</td>
                 </tr>
            </table>
        </div>
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>