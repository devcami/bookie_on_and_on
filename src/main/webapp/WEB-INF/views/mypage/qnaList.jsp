<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaList.css" />
<script src='${pageContext.request.contextPath}/resources/js/main.js'></script>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="나의QNA목록" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<!-- 뒤로가기 -->
<div id="title-header">
	<div id="header-div">
		<div id="title-header-left">
			<i class="fa-solid fa-angle-left" onclick="location.href='${pageContext.request.contextPath}/mypage/mypageSetting.do'"></i>		
		</div>
	</div>
</div>
<section id="content" style="min-height:800px;">
	<div class="text-center m-4" id="subtitle-div">
		<h1>1:1 문의</h1>
		<p>궁금하신 점이 있으신가요?</p>
	</div>
	<%-- qna 등록버튼 --%>
	<button type="button"
			class="btn btn-5 custom-btn" 
			onclick="location.href='${pageContext.request.contextPath}/mypage/qnaEnroll.do'">Q&A 등록하기</button>
	<div class="mt-2">
		<div>
			<ul class="list-group p-3">
			<c:forEach items="${list}" var="qna">
				<%-- qna 하나 --%>
				<li class="list-group-item m-1 qna-li" 
					onclick="location.href='${pageContext.request.contextPath}/mypage/qnaDetail.do?qnaNo=${qna.qnaNo}'">
					${qna.title} 
					<span class="float-right text-secondary mt-1">[${qna.status eq 'U' ? '답변대기중' : '답변완료'}]</span>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>