
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="h" tagdir="/WEB-INF/tags"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
${loginMember.MEMBER_NAME}
장바구니
<br>
리스트:${cartList}<br>
total:${totalPrice}

</body>
</html>
