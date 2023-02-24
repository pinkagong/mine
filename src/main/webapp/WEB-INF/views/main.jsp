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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/headerFooter.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script language="JavaScript">
        $(document).ready(function () {
            var $banner = $(".banner").find("ul");
            var $bannerWidth = $banner.children().outerWidth();//이미지의 폭
            var $bannerHeight = $banner.children().outerHeight(); // 높이
            var $length = $banner.children().length;//이미지의 갯수
            var rollingId;

            //정해진 초마다 함수 실행
            rollingId = setInterval(function () {
                rollingStart();
            }, 3000);//다음 이미지로 롤링 애니메이션 할 시간차

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
                새로나온책<span><a href="/com.solponge/productList">전체보기</a></span>
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