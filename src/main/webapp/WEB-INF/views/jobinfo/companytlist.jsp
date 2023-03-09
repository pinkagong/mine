<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="h" tagdir="/WEB-INF/tags"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description"
          content="Start your development with Pigga landing page.">
    <meta name="author" content="Devcrud">
    <title>Home Shopping Site</title>
    <link rel="stylesheet" href="/css/hdcss.css">
    <style>
        .heart {
            width: 25px;
            font-size: 15px;
            color: gray;
            cursor: pointer;
            background-color: transparent;
            border: none;
        }

        .heart.red {
            width: 25px;
            font-size: 15px;
            color: red;
            background-color: transparent;
            border: none;
        }
        .star {
            width: 25px;
            font-size: 15px;
            color: gray;
            cursor: pointer;
            background-color: transparent;
            border: none;
        }

        .star.yellow {
            width: 25px;
            font-size: 15px;
            color: sandybrown;
            background-color: transparent;
            border: none;
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
    </script>

    <style>
        /* Pagination container */
        .url{
            float: left;
        }
        .url:hover {
            cursor: pointer;
        }
        #paging {
            margin-top: 20px;
            text-align: center;
        }

        /* Pagination links */
        .pagination {
            display: inline-block;
            margin-bottom: 0;
        }

        .pagination .page-item {
            display: inline;
        }

        .pagination .page-link {
            color: #007bff;
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            padding: 6px 12px;
            margin: 0 4px;
        }

        .pagination .page-item.disabled .page-link {
            color: #6c757d;
            pointer-events: none;
            cursor: default;
        }

        .pagination .page-item.active .page-link {
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .pagination {
            display: inline-block;
            margin: 0 auto;
        }

        .pagination li {
            display: inline;
            margin: 0 1px;
        }

        .pagination li.active a {
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .pagination li a {
            color: #007bff;
            border: 1px solid #007bff;
            padding: 6px 12px;
        }

        .pagination li a:hover {
            background-color: #007bff;
            color: #fff;
            border-color: #007bff;
        }

        .pagination li.disabled a {
            color: #6c757d;
            cursor: not-allowed;
            background-color: #fff;
            border-color: #6c757d;
        }
        #container_booklist{
            width: 1050px;
            margin: 0 auto;
        }
        #row2{
            width: 1050px;
            margin-bottom: 40px;
        }
    </style>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="40" id="home">
<header>
    <%@include file="../../tags/header.jsp"%>
</header>

<div id="container_booklist">
    <div id="row2">
        <form action = "/com.solponge/jobinfolist/search" accept-charset="utf-8" name = "book_info" method = "get">
        <h3 id="newbook">
            <c:choose>
                <c:when test="${status.equals('Yes')}">
                    검색된 공고<span>
                </c:when>
                <c:when test="${!status.equals('Yes')}">
                    새로 등록된 공고<span>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>
                    <select name="SearchSelect">
                      <option value="all">전체</option>
                      <option value="JopInfo_COMPANYNAME">회사명</option>
                      <option value="JopInfo_INFONAME">공고명</option>
                      <option value="JopInfo_FTAGLIST">기술 태그</option>
                      <option value="JopInfo_QUALIFICAT">지원자격</option>
                      <option value="JopInfo_WORKTYPE">고용 형태</option>
                    </select>
                    <input type="text" name="SearchValue" size="15" value="검색 내용">
                    <button type="submit"><img src="/img/Magnifier.png" style="width: 20px;" alt="Search"></button>
            </span>
        </h3>
        </form>

        <form id="my-form">
            <table id="Newjob8" style="font-size: 13px;">
                <tr id="Newjob8th" style="text-align: center; background: #f2f9fe">
                    <td style="width: 220px; height: 44px">기업명</td>
                    <td style="width: 420px; height: 44px">제목</td>
                    <td style="width: 180px; height: 44px">지원자격</td>
                    <td style="width: 150px; height: 44px">근무조건</td>
                    <td>마감일</td>
                </tr>
                <c:forEach var="NewJopInfo" items="${paginatedjobinfo}" varStatus="status" >
                    <input type="hidden" id="infoname_${NewJopInfo.infonum}" value="${NewJopInfo.infoname}"/>
                    <input type="hidden" id="companyName_${NewJopInfo.infonum}" value="${NewJopInfo.companyname}"/>
                    <tr id="Newjob8td">
                        <c:set var="comname" value="response_${NewJopInfo.companyname}"/>
                        <c:choose>
                            <c:when test="${JobScrap.containsKey(comname)}">
                                <td class="infonum" style="height: 54px"><div class="url" OnClick="location.href ='/com.solponge/jobinfo/${NewJopInfo.infonum}'">${NewJopInfo.companyname}</div><button class="heart red" id="${NewJopInfo.infonum}" type="button" onclick="submitForm(this.id)" value="Clicked">&#10084;</button></td>
                            </c:when>
                            <c:otherwise>
                                <td class="infonum" style="height: 54px"><div class="url" OnClick="location.href ='/com.solponge/jobinfo/${NewJopInfo.infonum}'">${NewJopInfo.companyname}</div><button class="heart" id="${NewJopInfo.infonum}" type="button" onclick="submitForm(this.id)" value="Click">&#10084;</button></td>
                            </c:otherwise>
                        </c:choose>
                        <c:set var="infoname" value="response_${NewJopInfo.infoname}"/>
                        <c:choose>
                            <c:when test="${JobScrap2.containsKey(infoname)}">
                                <td style="height: 54px"><div class="url" OnClick="location.href ='/com.solponge/jobinfo/${NewJopInfo.infonum}'">${NewJopInfo.infoname}</div><button class="star yellow" id="${NewJopInfo.infonum}_star" type="button" onclick="submitForm2(this.id)" value="Clicked">&#10029;</button><br><span style="font-size: 10px">${NewJopInfo.ftaglist}</span></td>
                            </c:when>
                            <c:otherwise>
                                <td style="height: 54px"><div class="url" OnClick="location.href ='/com.solponge/jobinfo/${NewJopInfo.infonum}'">${NewJopInfo.infoname}</div><button class="star" id="${NewJopInfo.infonum}_star" type="button" onclick="submitForm2(this.id)" value="Click">&#10029;</button><br><span style="font-size: 10px">${NewJopInfo.ftaglist}</span></td>
                            </c:otherwise>
                        </c:choose>
                        <td style="height: 54px">${NewJopInfo.qualificat}</td>
                        <td style="text-align: center; height: 54px">${NewJopInfo.worktype}<br>${NewJopInfo.workarea}</td>
                        <td style="height: 54px">${NewJopInfo.deadline}</td>
                    </tr>
                </c:forEach>
            </table>
        </form>


        <nav id="paging" aria-label="Page navigation example" style="clear: both;">
            <ul class="pagination justify-content-center" style="padding: 0">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${url}page=${currentPage - 1}" tabindex="-1"
                       aria-disabled="${currentPage == 1}">Previous</a>
                </li>
                <c:choose>
                    <c:when test="${totalPages <= 10}">
                        <c:set var="startPage" value="1"/>
                        <c:set var="endPage" value="${totalPages}"/>
                    </c:when>
                    <c:when test="${currentPage <= 6}">
                        <c:set var="startPage" value="1"/>
                        <c:set var="endPage" value="10"/>
                    </c:when>
                    <c:when test="${currentPage > totalPages - 6}">
                        <c:set var="startPage" value="${totalPages - 9}"/>
                        <c:set var="endPage" value="${totalPages}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="startPage" value="${currentPage - 5}"/>
                        <c:set var="endPage" value="${currentPage + 4}"/>
                    </c:otherwise>
                </c:choose>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <li class="page-item ${currentPage == pageNum ? 'active' : ''}">
                        <a class="page-link" href="${url}page=${pageNum}">${pageNum}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}" style="margin-right: 44px">
                    <a class="page-link" href="${url}page=${currentPage + 1}" aria-disabled="${currentPage == totalPages}">Next</a>
                </li>
            </ul>
        </nav>
    </div>
</div>
<footer>
    <%@include file="../../tags/footer.jsp" %>
</footer>
</body>
</html>