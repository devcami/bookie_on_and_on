<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<script src='${pageContext.request.contextPath}/resources/js/main.js'></script>
<style>
.popular-posts {
    max-width: 900px;
    margin: 0 auto;
    font-size:24px;
}
.f-title {
    /* background-color: #484848; */
    padding: 10px 20px 10px 20px;
    /* margin-bottom: 20px; */
    text-align:left;
    box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
}
.f-title h1 {
    margin: 0px;
    color: #000;
    font-weight:100;
}
/*-------------------------*/
.popular-posts ul {
    padding: 0;
    border-radius: 2px;
    border: 0;
    /* box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12); */
    position: relative;
    overflow: hidden;
    margin-bottom:0
}
.popular-posts ul li {
    box-sizing: border-box;
    list-style-type: none;
    margin: 0;
    padding: 10px 10px 10px 72px !important;
    min-height: 68px;
    line-height: 1.5rem;
    height: inherit; 
    position: relative;
}

.item-thumbnail {
   line-height: 42px;
}

.popular-posts ul li { 
    background-color: F2F2F2;
}
.popular-posts ul li:hover {
    background-color: #D9D9D9;
}
.popular-posts ul li a {
    color: #000;
    text-decoration: none;
}
.popular-posts ul li a:hover {
    color: #EEE;
}
.popular-posts ul li img {
    width: 32px;
    height: 32px;
    position: absolute;
    padding: inherit;
    border-radius: 50%;
    overflow: hidden;
    left: 15px;
    border: 0;
    display: inline-block;
    vertical-align: middle;
    margin-top: 4px;
}
</style>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="세팅" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<!-- 뒤로가기 -->
<div id="title-header" class="" >
	<div id="header-div">
		<div id="title-header-left">
			<i class="fa-solid fa-angle-left" onclick="location.href='/bookie/mypage/mypage.do?memberId=${loginMember.memberId}'"></i>		
		</div>
	</div>
</div>
<!-- 메뉴 -->
<section style="background-color: #fcfbf9;">
   <div style="min-height: 800px;">
      <!-- 계정관리 start -->
      <div class="f-title">
        <h1> 계정관리 </h1>
      </div>
      <div class="widget-content popular-posts">
        <ul>
          <li>
         <div class="item-thumbnail">
              <a title="" href="${pageContext.request.contextPath}/mypage/myMainProfile.do" target="_blank">
               <img alt="상세프로필설정" class="circle" 
               src="${pageContext.request.contextPath}/resources/images/icon/smile.png" title="상세프로필설정" border="0" height="72" width="72"> </a> 
               <span class="title"><a title="" href="${pageContext.request.contextPath}/mypage/myMainProfile.do?">상세프로필설정</a></span> </div>
            <div style="clear: both;"></div>
          </li>
          <li>
         <div class="item-thumbnail"  onclick="moveToPointPage()">
              <a title="" href="${pageContext.request.contextPath}/mypage/myPasswordUpdateFrm.do" target="_blank">
               <img alt="비밀번호변경" class="circle" 
               src="${pageContext.request.contextPath}/resources/images/icon/smile.png" title="비밀번호변경" border="0" height="72" width="72"> </a> 
               <span class="title"><a title=" " href="${pageContext.request.contextPath}/mypage/myPasswordUpdateFrm.do">비밀번호변경</a></span> </div>
            <div style="clear: both;"></div>
          </li>
          <li onclick="moveToPointPage()">
         <div class="item-thumbnail">
              <a title="" href="http://www.fostrap.com/2016/04/free-material-design-template-blogger-md-fostrap.html" target="_blank">
               <img alt="포인트관리" class="circle" 
               src="${pageContext.request.contextPath}/resources/images/icon/smile.png" title="포인트관리" border="0" height="72" width="72"> </a> 
               <span class="title"><a title=" " href="">포인트관리</a></span> </div>
            <div style="clear: both;"></div>
          </li>
          <li>
         <div class="item-thumbnail">
              <a title="" href="${pageContext.request.contextPath}/mypage/deleteMember.do" target="_blank">
               <img alt="회원탈퇴" class="circle" 
               src="${pageContext.request.contextPath}/resources/images/icon/smile.png" title="회원탈퇴" border="0" height="72" width="72"> </a> 
               <span class="title"><a title=" " href="${pageContext.request.contextPath}/mypage/deleteMember.do">회원탈퇴</a></span> </div>
            <div style="clear: both;"></div>
          </li>
        </ul>
      </div>
      <!-- 계정관리 end -->
         
      <!-- 고객센터 start -->
      <div class="f-title">
        <h1> 고객센터 </h1>
      </div>
      <div class="widget-content popular-posts">
        <ul>
          <li>
	         <div class="item-thumbnail" style="line-height: 42px;">
				<img alt="나의 Q&A 목록" class="circle" src="${pageContext.request.contextPath}/resources/images/icon/smile.png" title="나의 Q&A 목록" border="0" height="72" width="72"> 
				<span class="title">
					<a href="${pageContext.request.contextPath}/mypage/qnaList.do?memberId=${loginMember.memberId}">나의 Q&A 목록</a>
				</span> 
			 </div>
			 <div style="clear: both;"></div>
          </li>
        </ul>
      </div>   
      <!-- 기능설정 end --> 
   </div>

</section>
<!-- 포인트페이지 -->
<form:form
	name="pointFrm"
	method="post" 
	action="${pageContext.request.contextPath}/point/myPoint.do"/>

<script>
moveToPointPage = () => {
	const frm = document.pointFrm
    frm.submit();
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>