
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="h" tagdir="/WEB-INF/tags"%>
<html>
<head>
    <title>Title</title>
</head>
<style>
    .success{
        text-align: center;
        height: 600px;
        /*display: flex;*/
        justify-content: center;
        align-items: center;
    }
    h1 {
        font-size: 28px;
        margin-top: 50px;
        margin-bottom: 20px;
    }

    button:hover {
        background-color: #0062cc;
    }

    .my-btn {
        padding: 10px 20px;
        background-color: rgb(102,153,255); /* 헤더와 같은 색상 */
        color: white;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
    }
</style>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div class="success">
    <h1>${member.MEMBER_NAME}님의 가입을 축하합니다!</h1>

    <button class="my-btn" onclick="location.href='/com.solponge/main';">메인으로 가기</button>
</div>
<footer>
    <%@include file="../../tags/footer.jsp"%>
</footer>
</body>
</html>