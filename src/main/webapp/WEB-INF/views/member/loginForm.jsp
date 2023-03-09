<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="h" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
    <form:form method="post" modelAttribute="loginForm">
        <label for="memberId">아이디</label>
        <form:input path="memberId" id="memberId" placeholder="아이디를 입력하세요" />
        <form:errors path="memberId"  cssStyle="color: red" />


        <label for="memberPwd">패스워드</label>

        <form:password path="memberPwd" id="memberPwd" placeholder="비밀번호를 입력하세요" />
        <form:errors path="memberPwd" cssStyle="color: red"/>

        <button type="submit">로그인</button>
    </form:form>
    <spring:hasBindErrors name="loginForm">
        <c:if test="${errors.hasGlobalErrors()}">
            <div class="error" style="color: red; text-align: center;">
                <c:forEach items="${errors.globalErrors}" var="error">
                    ${error.defaultMessage}
                </c:forEach>
            </div>
        </c:if>
    </spring:hasBindErrors>
</div>
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>
