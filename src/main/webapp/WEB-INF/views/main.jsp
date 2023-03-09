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

    <style>
        .url{
            float: left;
        }
        .url:hover {
            cursor: pointer;
        }
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

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/headerFooter.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script language="JavaScript">
        // $(document).ready(function() {
        // var formData = $('#myForm').serialize();
        // console.log('데이터틀'+formData)
        // $("#myButton").click(function() {
        //     $.ajax({
        //         url: "/myAjaxRequest",
        //         type: "POST",
        //         contentType: "application/json",
        //         data: JSON.stringify({ "myData": "Hello world!" }),
        //         success: function(responseData) {
        //             alert(responseData);
        //         },
        //         error: function(jqXHR, textStatus, errorThrown) {
        //             alert("Error: " + textStatus + " - " + errorThrown);
        //         }
        //     });
        // });
        // });
        //
        // function submitForm2() {
        //     let abandonedAnimal = JSON.stringify({ "myData": "Hello world!" });
        //     $.ajax({
        //         type: "POST"
        //         , url: "/abandoned/tag"
        //         , contentType: "application/json"
        //         , data: abandonedAnimal
        //         , success: function(data) {
        //                 alert('성공');
        //         }
        //         , error: function(e) {
        //             alert('찜 등록에 실패했습니다. 관리자에게 문의해주세요.');
        //         }
        //     });
        // }
        // const button = document.getElementById('my-button');
        //
        // button.addEventListener('click', function() {
        //     const buttonId = this.id;
        //     console.log('Button id: ' + buttonId);
        // });

        <%--infoname_${NewJopInfo.infonum}"--%>
        <%--companyName_${NewJopInfo.infonum--%>

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

        // function submitForm() {
        //     var formData = $('#myForm').serialize();
        //     var messageDTO={
        //         result:formData
        //     };
        //     console.log('데이터틀'+formData)
        //     $.ajax({
        //         type: 'POST',
        //         url: './myControllerEndpoint',
        //         data: messageDTO
        //     }).done(function () {
        //         console.log('보내기 성공')
        //     });
        // }

        // function sendAjaxRequest(event) {
        //     var buttonId = event.target.id;
        //     var responeId = "data_"+buttonId
        //     var data = document.getElementById(responeId).value;
        //     console.log('보낼 값: ' + data);
        //     $.ajax({
        //         type: "POST",
        //         url: "http://localhost:9081/com.solponge/ajax",
        //         contentType: "application/json",
        //         data: JSON.stringify({num: data}),
        //         success: function(response) {
        //             console.log("데이터보냄:", response);
        //         },
        //         error: function(xhr, status, error) {
        //             console.error("Error:", error);
        //         }
        //     });
        // }

        $(document).ready(function () {
            // var currentPosition = parseInt($(".quickmenu").css("top"));
            // $(window).scroll(function() {
            //     var position = $(window).scrollTop();
            //     $(".quickmenu").stop().animate({"top":position+currentPosition+"px"},10);
            // });
            //
            // var $banner = $(".container_right");
            // var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
            // var $bannerHeight = $banner.children().outerHeight(); // 높이
            // var $length = $banner.children().length;//이미지의 갯수
            // var rollingId;
            //
            // //정해진 초마다 함수 실행
            // rollingId = setInterval(function () {
            //     rollingStart();
            // }, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

            function rollingStart() {
                $banner.css("width", $bannerWidth * $length + "px");
                $banner.css("height", $bannerHeight + "px");
                //alert(bannerHeight);
                //배너의 좌측 위치를 옮겨 준다.
                $banner.animate({left: -$bannerWidth + "px"}, 1500, function () { //숫자는 롤링 진행되는 시간이다.
                    //첫번째 이미지를 마지막 끝에 복사(이동이 아니라 복사)해서 추가한다.
                    $(this).append("<li>" + $(this).find("li:first").html() + "</li>");
                    //뒤로 복사된 첫번재 이미지는 필요 없으니 삭제한다.
                    $(this).find("li:first").remove();
                    //다음 움직임을 위해서 배너 좌측의 위치값을 초기화 한다.
                    $(this).css("left", 0);
                    //이 과정을 반복하면서 계속 롤링하는 배너를 만들 수 있다.
                });
            }
        });
        //-->
    </script>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="40" id="home">
<header>
    <%@include file="../tags/header.jsp"%>
</header>
<div id="container">
    <div class="container_left">
        <div class="banner">
            <ul>
                <li>
                    <img
                            src="https://www.i-boss.co.kr/og-BD3207-413-gif"
                            width="760px"
                            height="320px"
                    />
                </li>
                <li>
                    <img
                            src="https://cdn.imweb.me/thumbnail/20210514/30c731865b9c8.png"
                            width="760px"
                            height="320px"
                    />
                </li>
                <li>
                    <img
                            src="https://publy.imgix.net/images/2021/05/18/1621306911_AsZ4ZT3kNYYDZ9zMgb3BTdFTlCZuJsr5P8LhqOaD.jpeg?fm=pjpg"
                            width="760px"
                            height="320px"
                    />
                </li>
            </ul>
        </div>

        <div id="row">
            <h3 id="newbook">
                새로나온책!!!<span><a href="/com.solponge/productList">전체보기</a></span>
            </h3>
            <c:forEach var="productNew" items="${getproductNewTop8List}">
                <div class="column">
                    <a href="/com.solponge/product/${productNew.product_num}"><img
                            src="${productNew.product_img}"
                            alt="${productNew.product_title}"
                            style="width: 197px; height: 266px;"
                    /></a>
                    <c:set var="title" value="${productNew.product_title}"/>
                    <c:choose>
                        <c:when test="${fn:length(title) > 12}">
                            <a href="/com.solponge/product/${productNew.product_num}"><h2>${fn:substring(title, 0, 9)}...</h2></a>
                        </c:when>
                        <c:otherwise>
                            <a href="/com.solponge/product/${productNew.product_num}"><h2>${title}</h2></a>
                        </c:otherwise>
                    </c:choose>
                    <a href="/com.solponge/product/${productNew.product_num}"><p>${productNew.product_price}원</p></a>
                </div>
            </c:forEach>
            <hr style="clear:both;">
            <h3 id="newbook">
                새로 등록된 공고!!!<span><a href="/com.solponge/jobinfolist">전체보기</a></span>
            </h3>
            <form id="my-form">
                <table id="Newjob8" style="font-size: 13px;">
                    <tr id="Newjob8th" style="text-align: center; background: #f2f9fe">
                        <td style="width: 160px; height: 44px">기업명</td>
                        <td style="width: 360px; height: 44px">제목</td>
                        <td style="width: 160px; height: 44px">지원자격</td>
                        <td style="width: 150px; height: 44px">근무조건</td>
                        <td>마감일</td>
                    </tr>
                    <c:forEach var="NewJopInfo" items="${getJopInfoNewTop8List}" varStatus="status" >
                        <input type="hidden" id="infoname_${NewJopInfo.infonum}" value="${NewJopInfo.infoname}"/>
                        <input type="hidden" id="companyName_${NewJopInfo.infonum}" value="${NewJopInfo.companyname}"/>
                        <tr id="Newjob8td">
                            <c:set var="comname" value="response_${NewJopInfo.companyname}"/>
                            <c:choose>
                                <c:when test="${JobScrap.containsKey(comname)}">
                                    <td class="infonum" style="height: 54px"><div class="url" OnClick="location.href ='/com.solponge/jobinfolist/${NewJopInfo.companyname}'">${NewJopInfo.companyname}</div><button class="heart red" id="${NewJopInfo.infonum}" type="button" onclick="submitForm(this.id)" value="Clicked">&#10084;</button></td>
                                </c:when>
                                <c:otherwise>
                                    <td class="infonum" style="height: 54px"><div class="url" OnClick="location.href ='/com.solponge/jobinfolist/${NewJopInfo.companyname}'">${NewJopInfo.companyname}</div><button class="heart" id="${NewJopInfo.infonum}" type="button" onclick="submitForm(this.id)" value="Click">&#10084;</button></td>
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
        </div>
    </div>
    <div class="container_right">
        <br/>
        <h3 class="newbook">
            인기 상품<span><a href="#">전체보기</a></span>
        </h3>
        <table>
            <c:forEach var="popularTop" items="${getproductpopularTop8List}" varStatus="status" >
                <tr>
                    <td><a href="/com.solponge/product/${popularTop.product_num}"><img src="${popularTop.product_img}"/></a></td>
                    <td>
                        <table>
                            <tr>
                                <td class="book_rank"><a href="/com.solponge/product/${popularTop.product_num}">${status.count}위</a></td>
                            </tr>
                            <tr>
                                <c:set var="pwriter" value="${popularTop.product_writer}"/>
                                <c:choose>
                                    <c:when test="${fn:length(pwriter) > 10}">
                                        <td class="book_rank_writer"><a href="/com.solponge/product/${popularTop.product_num}">${fn:substring(pwriter, 0, 9)}...</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td class="book_rank_writer"><a href="/com.solponge/product/${popularTop.product_num}">${pwriter}</a></td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
                            <tr>
                                <td class="book_rank_title">
                                    <c:set var="ptitle" value="${popularTop.product_title}"/>
                                    <c:choose>
                                        <c:when test="${fn:length(ptitle) > 12}">
                                            <a href="/com.solponge/product/${popularTop.product_num}">${fn:substring(ptitle, 0, 9)}...</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/com.solponge/product/${popularTop.product_num}">${ptitle}</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td class="book_rank_sales"><a href="/com.solponge/product/${popularTop.product_num}">${popularTop.product_sale}개 판매!</a></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<footer class="border border-dark border-left-0 border-right-0 border-bottom-0 p-4 bg-dark">
    <%@include file="../tags/footer.jsp"%>
</footer>
</body>
</html>