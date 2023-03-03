<%--
  Created by IntelliJ IDEA.
  User: qkrdydxk
  Date: 2023-02-20
  Time: 오후 12:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="h" tagdir="/WEB-INF/tags"%>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/loginForm.css">
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div>
</div>
<div class="login-form">
    <h2>로그인</h2>
    <form action="/com.solponge/login" method="post">
        <label for="memberId">아이디</label>
        <input type="text" name="memberId" id="memberId" placeholder="아이디를 입력하세요"
        class="${bindingResult.hasFieldErrors('memberId') ? 'order' : ''}" style="${bindingResult.hasFieldErrors('memberId') ? 'border-color: red' : ''}">
        <label for="memberPwd">패스워드</label>
        <input type="password" name="memberPwd" id="memberPwd" placeholder="비밀번호를 입력하세요"
               class="${bindingResult.hasFieldErrors('memberPwd') ? 'error' : ''}">
        <button type="submit">로그인</button>
    </form>
    <c:if test="${not empty bindingResult.globalErrors}">
        <div class="error" style="color: red; text-align: center" >
            <c:forEach items="${bindingResult.globalErrors}" var="error">
                ${error.defaultMessage}
            </c:forEach>
        </div>
    </c:if>
  <%--  <c:if test="${not empty bindingResult.fieldErrors}">
        <div class="error">
            <c:forEach items="${bindingResult.fieldErrors}" var="error">
                ${error.field} : ${error.defaultMessage}<br/>
            </c:forEach>
        </div>
    </c:if>--%>
</div>
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>
