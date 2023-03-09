<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/success.css">
</head>
<body>
<div id="block">
    <header>
        <%@include file="../../tags/header.jsp"%>
    </header>

    <h2>결제 성공!</h2>
    <table>
        <tr>
            <td onclick="location.href='/com.solponge/main'">메인으로</td>
            <td onclick="location.href='/com.solponge/member/${member.MEMBER_NO}/paymentList'">주문내역</td>
        </tr>

    </table>
    <footer>
        <%@include file="../../tags/footer.jsp" %>
    </footer>

</div>
</body>
</html>
