<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        #infocontainer {
            width: 870px;
            display: block;
            margin: auto;
        }
        #jv_header {
            width: 870px;
            margin-left: 20px;
            margin-top: 30px;
        }
        #jv_header_left{
            width: 570px;
            height: 90px;
            float: left;
        }
        #companyName{
            float: left;
            font-size: 18px;
        }
        #jv_header_right {
            width: 260px;
            height: 90px;
            float: left;
        }
        #info_url {
            width: 186px;
            height: 60px;
            top: 10px;
            position: relative;
            left: 10px;
            background-color: rgb(102,153,255);
            color: white;
            border: solid 1px #007bff;
        }
        #jv_summary {
            clear: both;
            padding-top: 20px;
            width: 870px;
        }
        #jv_cont {
            padding-top: 20px;
            width: 800px;
        }
        #jv_cont div{
            width: 800px;
        }

        .heart span{
            color: black;
        }

        .heart {
            margin-left: 10px;
            width: 130px;
            font-size: 15px;
            color: gray;
            cursor: pointer;
            background-color: transparent;
            border: solid 1px gray;
        }

        .heart.red {
            margin-left: 10px;
            width: 130px;
            font-size: 15px;
            color: red;
            background-color: transparent;
            border: solid 1px gray;
        }
        .infoNameScrap_star {
            text-align: center;
            font-size: 35px;
            color: gray;
            cursor: pointer;
            background-color: transparent;
            border: solid 1px gray;
            width: 60px;
            height: 60px;
            top: 18px;
            position: relative;

        }

        .infoNameScrap_star.yellow {
            text-align: center;
            font-size: 35px;
            color: sandybrown;
            background-color: transparent;
            border: solid 1px gray;
            width: 60px;
            height: 60px;
            top: 18px;
            position: relative;

        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>


        function submitForm(clicked_id) {
            var buttonElement = document.getElementById(clicked_id);
            var usercheck = '${member.MEMBER_ID}';
            let MEMBER_NO = parseInt(${member.MEMBER_NO});
            var companyName = "companyName_"+clicked_id;
            var data2 = document.getElementById(companyName).value;
            if (buttonElement.value === 'Click') {
                buttonElement.value = 'Clicked';
                buttonElement.classList.add('red');
                if (usercheck.length !== 0) {
                    console.log('보낼 값: ' + data2);
                    console.log('용자사 번호: ' + MEMBER_NO);
                    console.log(typeof(MEMBER_NO))
                    let scrapCompany = JSON.stringify({"member_No": MEMBER_NO,"companyName": data2});
                    $.ajax({
                        type: "POST"
                        , url: "/scrap/company"
                        , contentType: "application/json"
                        , data: scrapCompany
                        , success: function() {
                            alert('성공');
                        }
                        , error: function() {
                            alert('찜 등록에 실패했습니다. 관리자에게 문의해주세요.');
                        }
                    });
                } else {
                    alert('찜 등록에 실패했습니다. 로그인을 해주세요');
                    location.href = "/main";
                }
            } else {
                buttonElement.value = 'Click';
                buttonElement.classList.remove('red');
                if (usercheck.length !== 0) {
                    console.log('보낼 값: ' + data2);
                    console.log('용자사 번호: ' + MEMBER_NO);
                    console.log(typeof(MEMBER_NO))
                    let scrapCompany = JSON.stringify({"member_No": MEMBER_NO,"companyName": data2});
                    $.ajax({
                        type: "POST"
                        , url: "/scrap/company/delete"
                        , contentType: "application/json"
                        , data: scrapCompany
                        , success: function() {
                            alert('성공');
                        }
                        , error: function() {
                            alert('찜 삭제 실패했습니다. 관리자에게 문의해주세요.');
                        }
                    });
                }
            }
        }
        function submitForm2(clicked_id) {
            var buttonElement = document.getElementById(clicked_id);
            var usercheck = '${member.MEMBER_ID}';
            let MEMBER_NO = parseInt(${member.MEMBER_NO});
            var infoname = "infoname_"+clicked_id;
            console.log(infoname)
            var infoname_re = infoname.replace("_star","");
            console.log(infoname_re)
            var data2 = document.getElementById(infoname_re).value;
            if (buttonElement.value === 'Click') {
                buttonElement.value = 'Clicked';
                buttonElement.classList.add('yellow');
                if (usercheck.length !== 0) {
                    console.log('보낼 값: ' + data2);
                    console.log('용자사 번호: ' + MEMBER_NO);
                    console.log(typeof(MEMBER_NO))
                    let scrapinfo = JSON.stringify({"member_No": MEMBER_NO,"infoname": data2});
                    $.ajax({
                        type: "POST"
                        , url: "/scrap/job"
                        , contentType: "application/json"
                        , data: scrapinfo
                        , success: function() {
                            alert('성공');
                        }
                        , error: function() {
                            alert('찜 등록에 실패했습니다. 관리자에게 문의해주세요.');
                        }
                    });
                } else {
                    alert('찜 등록에 실패했습니다.');
                    location.href = "/main";
                }
            } else {
                buttonElement.value = 'Click';
                buttonElement.classList.remove('yellow');
                if (usercheck.length !== 0) {
                    console.log('보낼 값: ' + data2);
                    console.log('용자사 번호: ' + MEMBER_NO);
                    console.log(typeof(MEMBER_NO))
                    let scrapinfo = JSON.stringify({"member_No": MEMBER_NO,"infoname": data2});
                    $.ajax({
                        type: "POST"
                        , url: "/scrap/job/delete"
                        , contentType: "application/json"
                        , data: scrapinfo
                        , success: function() {
                            alert('성공');
                        }
                        , error: function() {
                            alert('찜 삭제 실패했습니다. 관리자에게 문의해주세요.');
                        }
                    });
                }
            }
        }

        $(document).ready(function() {
            const aTags = document.querySelectorAll('a');
            aTags.forEach(a => {
                a.target = '_self';
            });
            console.log(aTags)
        });

    </script>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="40" id="home">
<header>
    <%@include file="../../tags/header.jsp"%>
</header>


<div id="infocontainer">
    <form id="my-form">
        <div id="jv_header">
            <div id="jv_header_left">
                <div id="companyName">${JopInfoVo.companyname}</div>
                <input type="hidden" id="infoname_${JopInfoVo.infonum}" value="${JopInfoVo.infoname}"/>
                <input type="hidden" id="companyName_${JopInfoVo.infonum}" value="${JopInfoVo.companyname}"/>
                <c:set var="comname" value="response_${JopInfoVo.companyname}"/>
                <c:choose>
                    <c:when test="${JobScrap.containsKey(comname)}">
                        <button class="heart red" id="${JopInfoVo.infonum}" type="button" onclick="submitForm(this.id)" value="Clicked">&#10084;<span>관심기업 등록</span></button>
                    </c:when>
                    <c:otherwise>
                        <button class="heart" id="${JopInfoVo.infonum}" type="button" onclick="submitForm(this.id)" value="Click">&#10084;<span>관심기업 등록</span></button>
                    </c:otherwise>
                </c:choose>
                <h2>
                    ${JopInfoVo.infoname}
                </h2>
            </div>
            <div id="jv_header_right">
                <c:set var="infoname" value="response_${JopInfoVo.infoname}"/>
                <c:choose>
                    <c:when test="${JobScrap2.containsKey(infoname)}">
                        <button class="infoNameScrap_star yellow" id="${JopInfoVo.infonum}_star" type="button" onclick="submitForm2(this.id)" value="Clicked">&#10029;</button>
                    </c:when>
                    <c:otherwise>
                        <button class="infoNameScrap_star" id="${JopInfoVo.infonum}_star" type="button" onclick="submitForm2(this.id)" value="Click">&#10029;</button>
                    </c:otherwise>
                </c:choose>
                <button id="info_url" onclick="location.href='${JopInfoVo.infolink}'">
                    모집 공고 사이트 이동
                </button>
            </div>
        </div>
    </form>
    <div id="jv_summary">
        <hr />
        <table cellpadding="5" cellspacing="0" style="margin-left: 15px;">
            <tr>
                <td>지원자격</td>
                <td style="width: 150px;">${JopInfoVo.qualificat}</td>
                <td style="width: 100px;">근무조건</td>
                <td>${JopInfoVo.worktype}</td>
            </tr>
            <tr>
                <td style="width: 100px;">근무지역</td>
                <td style="width: 250px;">${JopInfoVo.workarea}</td>
                <td>마감일</td>
                <td>${JopInfoVo.deadline}</td>
            </tr>
            <tr>
                <td>직업군</td>
                <td style="width: 150px;">${JopInfoVo.jinfoField}</td>
                <td>기술태그</td>
                <td>
                    ${JopInfoVo.ftaglist}
                </td>
            </tr>
        </table>
        <hr />
    </div>
    <div id="jv_cont" style="margin: 0 auto">${JopInfoVo.pagecode}</div>
</div>

<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>