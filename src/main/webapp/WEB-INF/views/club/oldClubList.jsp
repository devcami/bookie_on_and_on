<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽리스트" name="title"/>
</jsp:include>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<section id="content">
	<div id="menu">
		<h1>북클럽리스트</h1>
		<div id="menu-left">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
			    <button 
			    	id="btn-enroll"
			    	class="btn btn-sm" 
			    	onclick=""
			    	style="margin-right: 5px;">북클럽 삭제</button>	    	
			</sec:authorize>
			<button 
		    	id="btn-enroll"
		    	class="btn btn-sm mr-1" 
		    	onclick="location.href='${pageContext.request.contextPath}/club/clubList.do';">모집중인 클럽</button>

		</div>	
	</div>
	<div id="clubListDiv">
	<jsp:useBean id="today" class="java.util.Date" />
	<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' var="nowDate"/>
	<c:forEach items="${list}" var="club" varStatus="vs">
		<div class="bookCard" id="card${club.clubNo}" data-no="${club.clubNo}">
			<div class="card-top" style="background-color: #dee2e6;">
				<div class='badge-div'>
					<h6><span class="badge badge-pill badge-secondary alert-badge">종료</span></h6>
				</div>
				<div class="img-div">
					<c:forEach items="${club.bookList}" var="clubBook" varStatus="bs">
						<img src="${clubBook.imgSrc}" />												
					</c:forEach>
				</div>
				<sec:authorize access="hasRole('ROLE_USER')">
					<div class="nop-div" style="visibility: hidden;">
						<span class="fa-stack fa-lg" id='h-span'>
						  <i class="fa fa-heart fa-regular fa-stack-1x front" ></i>
						</span>
						<span class="fa-stack fa-lg" id='h-span'>
						  <i class="fa fa-bookmark fa-regular fa-stack-1x front"></i>
						</span>
					</div>									
				</sec:authorize>
			</div>
			<div class="text-div">
				<div class='text-div-top'>
					<h5>${club.title}</h5>
					<div class='likes-div'>						
						<span>좋아요</span>&nbsp;
						<span class='likes' id="likesCnt${club.clubNo}">${club.likesCnt}</span>
						<span>개</span>					
					</div>
				</div>
					<span class="text-status">종료된 북클럽</span>			
				<div class="date-div">
					<span class="text-date">${club.recruitStart}</span>
					<span class="text-date">~</span>
					<span class="text-date">${club.recruitEnd}</span>
				</div>
			</div>
		</div>
		<%-- 마감된 경우 끝 --%>
			
	</c:forEach>			
	</div>
		<nav>${pagebar}</nav>

</section>

<script>


	window.addEventListener('load', (e) => {
		
		// click 이벤트 등록해 몽땅
		document.querySelectorAll(".bookCard").forEach((card) => {
			card.addEventListener('click', (e) => {
				const target = e.target;
				const currentCard = $(target).parents('.bookCard');
				const clubNo = $(currentCard).attr('data-no');
				
				console.log(currentCard);
				console.log(clubNo);
				
				let memberId = ''; 
 				if('${loginMember}'){
					memberId = "${loginMember.username}";
					console.log(memberId);
					location.href = '${pageContext.request.contextPath}/club/clubAnn.do?clubNo=' + clubNo + "&memberId=" + memberId;
				} else {
					location.href = '${pageContext.request.contextPath}/club/clubAnn.do?clubNo=' + clubNo;					
				}
				
			});	
		})			

	});
	
	
	const myBookClubDetail = (e) => {
		console.log(e);
		console.log(e.dataset.clubNo);
		
		const clubNo = e.dataset.clubNo;

		location.href = `${pageContext.request.contextPath}/club/clubDetail.do/\${clubNo}`;
	}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>