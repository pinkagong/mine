<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/proStyle.css">

    <style>
        .container {
            max-width: 1000px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//cdn.ckeditor.com/4.20.2/standard/ckeditor.js"></script>
    <script>
        function postData() {
            // alert("시도중")
            // Get the CKEditor instance
            var editor = CKEDITOR.instances['product_code'];
            var content = editor.getData();
            // console.log(typeof(content)); // Print the content to the console
            // alert(content)
            // Set the value of the hidden input field
            document.getElementById("myInput").value = content;
            // Submit the form
            document.getElementById("myForm").submit();
        }

    </script>
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div class="container">
    <div class="py-5 text-center">
        <h2>상품 수정 폼</h2>
    </div>
    <form id="myForm" action="../${product.product_num}/edit" method="post">
            <div>
                <label for="product_num">번호</label>
                <input type="text" id="product_num" name="product_num" class="form-control" value="${product.product_num}"
                       readonly>
            </div>
            <div>
                <label for="product_title">상품명</label>
                <input type="text" id="product_title" name="product_title" class="form-control" value="${product.product_title}">
            </div>
            <div>
                <label for="product_subtitle">부제목</label>
                <input type="text" id="product_subtitle" name="product_subtitle" class="form-control" value="${product.product_subtitle}">
            </div>
            <div>
                <label for="product_writer">작가</label>
                <input type="text" id="product_writer" name="product_writer" class="form-control" value="${product.product_writer}">
            </div>
            <div>
                <label for="product_price">가격</label>
                <input type="text" id="product_price" name="product_price" class="form-control" value="${product.product_price}">
            </div>
            <div>
              <img src=${product.product_img} alt="img">
            </div><br>
            <div class="mb-3">
              <label for="product_img" class="form-label">이미지</label>
              <input type="text" id="product_img" name="product_img" class="form-control" value="${product.product_img}">
            </div>
            <div>
               <label for="product_date">출간일</label>
               <input type="text" id="product_date" name="product_date" class="form-control" value=${product.product_date}>
            </div>
            <div>
                <label for="product_page">페이지 수</label>
                <input type="text" id="product_page" name="product_page" class="form-control" value="${product.product_page}">
            </div>
            <div>
                <label for="product_stock">재고</label>
                <input type="text" id="product_stock" name="product_stock" class="form-control" value="${product.product_stock}">
            </div>
             <div>
                <label for="product_sale">판매량</label>
                <input type="text" id="product_sale" name="product_sale" class="form-control" value="${product.product_sale}">
             </div>
             <div>
                <label for="product_visit">방문 수</label>
                <input type="text" id="product_visit" name="product_visit" class="form-control" value="${product.product_visit}">
             </div>
        <div id="product_code">
                             <p>${product.product_code}</p>
                         </div>
                         <input type="hidden" id="myInput" name="myInput">
                         <script>
                             $(function () {
                                 CKEDITOR.replace('product_code', {
                                     filebrowserUploadUrl : '${pageContext.request.contextPath}/adm/fileupload.do'
                                 });
                             });
                         </script>

            <hr class="my-4">
            <div class="row">
                <div class="col">
                    <button class="w-100 btn btn-primary btn-lg" type="submit" onclick="postData()">저장</button>
                </div>
                <div class="col">
                    <c:url value="/admin/${product.product_num}" var="itemUrl"/>
                    <button class="w-100 btn btn-secondary btn-lg" onclick="location.href='${itemUrl}'" type="button">취소</button>
                </div>
                <div class="col">
                    <c:url value="/admin/product/${product.product_num}/delete" var="itemUrl"/>
                    <button class="w-100 btn btn-secondary btn-lg" onclick="location.href='${itemUrl}'" type="button">삭제</button>
                </div>
            </div>
    </form>
</div> <!-- /container -->
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>
