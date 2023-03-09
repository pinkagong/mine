
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/headerFooter.css">
</head>
<body>
<nav class="navbar nav-first navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="/com.solponge/main"> <img src="${pageContext.request.contextPath}/img/sponge.png" alt="Logo" style="width: 100px;">
      <%--            <img src="${pageContext.request.contextPath}/resources/static/img/sponge.png" style="width: 100px;" alt="Logo">--%>
    </a>
    <ul class="navbar-nav ml-auto">
      <li>
        <C:if test="${loginMember==null}">
          <a href="/com.solponge/login" class="btn btn-primary btn-sm">로그인</a>
          <a href="/com.solponge/join" class="btn btn-primary btn-sm">회원가입</a>
          <a href="/com.solponge/login" class="btn btn-primary btn-sm"><img src="${pageContext.request.contextPath}/img/basket.png" style="width: 20px;" alt="basket">장바구니</a></li>
        </C:if>

      <c:if test="${loginMember.MEMBER_GRADE=='BASIC'}">
          <p>${loginMember.MEMBER_NAME}님 환영합니다.</p>
          <a href="/com.solponge/logout" class="btn btn-primary btn-sm">로그아웃</a>
          <a href="/com.solponge/member/${loginMember.MEMBER_NO}/myPage" class="btn btn-primary btn-sm">마이페이지</a>
          <a href="/com.solponge/member/${loginMember.MEMBER_NO}/myPage/cart" class="btn btn-primary btn-sm"><img src="${pageContext.request.contextPath}/img/basket.png" style="width: 20px;" alt="basket">&nbsp;장바구니</a></li>
        </c:if>

      <c:if test="${loginMember.MEMBER_GRADE=='ADMIN'}">
        <p>${loginMember.MEMBER_NAME}님 환영합니다.</p>
        <a href="/com.solponge/logout" class="btn btn-primary btn-sm">로그아웃</a>
        <a href="/com.solponge/admin/member" class="btn btn-primary btn-sm">회원관리</a>
        <a href="/com.solponge/admin/order" class="btn btn-primary btn-sm">주문관리</a>
        <a href="/com.solponge/admin/product" class="btn btn-primary btn-sm">상품관리</a></li>
      </c:if>
    </ul>
  </div>
</nav>


<nav
        class="nav-second navbar custom-navbar navbar-expand-sm navbar-dark bg-dark sticky-top">
  <div class="container">
    <button class="navbar-toggler ml-auto" type="button"
            data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navnav-linkbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li><a class="nav-link" href="/com.solponge/productList">BOOK</a>
        </li>
        <li><a class="nav-link" href="/com.solponge/jobinfolist">JOB</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</body>
</html>
