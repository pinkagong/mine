<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/proStyle.css?ver=1">

    <style>
        .container {
            max-width: 560px;
        }
    </style>
</head>
<body>
<header>
    <%@include file="../../tags/header.jsp"%>
</header>
<div class="container" style="max-width: 600px">
    <div class="py-5 text-center">
        <h2>회원 수정</h2>
    </div>
        <form method="post" action="/com.solponge/admin/member/${member_No}/update">
          <div>
             <label for="member_id">아이디</label>
             <input type="text" id="member_Id" name="member_Id" value="${member.MEMBER_ID}" readonly/>
          </div>
          <div>
             <label for="member_pwd">비밀번호</label>
             <input type="password" id="member_Pwd" name="member_Pwd" value="${member.MEMBER_PWD}"/>
          </div>
          <div>
             <label for="member_name">이름</label>
             <input type="text" id="member_Name" name="member_Name" value="${member.MEMBER_NAME}" />
          </div>
          <div>
             <label for="member_address">주소</label>
             <input type="text" id="member_Address" name="member_Address" value="${member.MEMBER_ADDRESS}" />
          </div>
          <div>
             <label for="member_phone">전화번호</label>
             <input type="text" id="member_Phone" name="member_Phone" value="${member.MEMBER_PHONE}" />
          </div>
          <div>
             <label for="member_email">이메일</label>
              <input type="email" id="member_Email" name="member_Email" value="${member.MEMBER_EMAIL}" />
          </div>
          <hr class="my-4">
          <div class="row">
              <div class="col">
                    <button type="submit">저장</button>
              </div>
              <div class="col">

                    <button onclick="location.href='/com.solponge/admin/member'" type="button">목록</button>
              </div>
              <div class="col">
                    <button onclick="location.href='/com.solponge/admin/member/${member.MEMBER_NO}/delete'" type="button">삭제</button>
              </div>
          </div>
        </form>
</div> <!-- /container -->
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>
