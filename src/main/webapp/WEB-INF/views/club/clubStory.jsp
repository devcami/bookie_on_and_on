<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubStory.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<script src='${pageContext.request.contextPath}/resources/js/main.js'></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽스토리" name="title"/>
</jsp:include>
<script>
/* 달력출력 스크립트 */
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth'
  });
  calendar.render();
});

</script>
${club}
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<section id="content">
	<div id="menuDiv">
		<ul>
			<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
			<li id="second-li" class="menu-li nowPage" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
			<li id="third-li" class="menu-li" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do/${clubNo}">게시판</a></li>
			<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
			<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/club/clubChat.do/${clubNo}">채팅..?</a></li>		
		</ul>
	</div>

	
	<%-- 대갈 --%>
	<div id="head">
		<div id="head-text">
			<h1>📚${club.title}📚</h1>
			<h4>${club.content}</h4>
		</div>
		<div class="badge-div">
			<c:set var="item" value="${fn:split(club.interest,',')}"/>
			<c:forEach items="${item}" var="interest" varStatus="vs">
				<span class="badge badge-pill myBadge">#${interest}</span>	
			</c:forEach>
		</div>
		<div id="category">
			<span>목차</span>
			<ul>
				<li><a href="#book-container">📙선정 도서</a></li>
				<li><a href="#clubMember-container"> 👩‍👩‍👦활동 멤버</a></li>
				<li><a href="#mission-container">🏆미션</a></li>
				<li><a href="#schedule-container">📅스케줄</a></li>
			</ul>
		</div>
	</div>
	<%-- 대갈 끝 --%>
	
	
	<%-- 선정 도서 --%>
	<div class="divs" id="book-container">
		<div style="transform: translateX(-20px); margin-bottom: 30px;">
			<h1>🧡선정도서🧡</h1>
		</div>
		<div class="b-wrapper">
			<div id="bar-first" class="book-bar">
				<i class="fa-solid fa-circle fa-circle-border"></i>
				<i class="fa-solid fa-circle fa-circle-inside" style="color: #3AB4F2"></i>
			</div>
			<div class="bookDiv">
				<span class="bookTag" style="background-color: #3AB4F2;">시작!</span>
				<span id="book-cnt" class="mt-1">북클럽에서 총 ${club.bookList.size()}권의 책을 읽어요.</span>
			</div>
		</div>
		<c:forEach items="${club.bookList}" var="book" varStatus="vs">
		<div class="b-wrapper">
			<div class="book-bar" id="bookBar${vs.count}">
				<i class="fa-solid fa-circle fa-circle-border"></i>
				<i class="fa-solid fa-circle fa-circle-inside" id="circle${vs.count}"></i>
			</div>
			
			<div class="bookDiv">
				<span class="bookTag" id="bookTag${vs.count}">첫 번째 책</span>
				<div class="eachBook">
					<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}">
					<div class="book-info">
						<span class="title">${book.bookTitle}</span>
						<span class="nextTitle">데루야 하나코, 오카다 게이코 (지은이)</span>
						<span class="nextTitle">비즈니스 북스 2019.07.29</span>
					</div>			
				</div>
				<p class="bookDescription">
					설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명
				</p>
			</div>
		</div>

		</c:forEach>
		<div class="b-wrapper">
			<div id="bar-last" class="">
				<i class="fa-solid fa-circle fa-circle-border"></i>
				<i class="fa-solid fa-circle fa-circle-last" style="color: #3AB4F2"></i>
			</div>
			<div class="bookDivLast">
				<span class="bookTag" style="background-color: #3AB4F2;">끝</span>
			</div>
		</div>
	</div>
	<%-- 선정 도서 끝 --%>
	
	
	<%-- 활동 멤버 --%>
	<div id="clubMember-container" class="divs">
		<div class="subTitle" >
			<h1 style="margin-bottom: 25px;">🧡활동 멤버🧡</h1>
		</div>
		<div id="clubMemberDiv">
			<c:forEach items="${club.applicantList}" var="applicant" varStatus="vs">
				<div class="memberWrap">
					<img src="${pageContext.request.contextPath}/resources/upload/profile/${applicant.renamedFilename}" 
						 class="rounded-circle shadow-1-strong"/>
					<span class="nicknames">${applicant.nickname}</span>
					<span style="font-size: 20px;">${applicant.introduce}</span>
				</div>
			</c:forEach>
		</div>
	</div>
	<%-- 활동 멤버 끝 --%>
	
	<%-- 스케줄 --%>
	<div id="schedule-container" class="divs">
		<div class="subTitle" >
			<h1>🧡스케줄🧡</h1>
		</div>
		<!-- calendar 태그 -->
		<div id='calendar-container'>    
			<div id='calendar'></div>  
		</div>  
	</div>
	<%-- 스케줄 끝 --%>

	<%-- 미션 --%>
	<div id="mission-container" class="divs">
		<div class="subTitle" >
			<h1 style="margin-bottom: 25px;">🧡미션🧡</h1>
		</div>
	</div>
	<%-- 미션 끝 --%>
	


	
</section>

	

<script type="text/javascript" src="https://rawcdn.githack.com/mburakerman/prognroll/0feda211643153bce2c69de32ea1b39cdc64ffbe/src/prognroll.js"></script> 

<script>


/************ 상단 progress 바 **************/
 $(function() {
 $("section").prognroll(
			{color:"#FF9800"}
			); 
$(".content").prognroll({
			custom:true});
});


/**************** 로드될 때 할 일 ***********************/
window.addEventListener('load', (e) => {
	const bookListSize = "${club.bookList.size()}";
	
	
	// 마지막 bookBar는 좀 길게 해
	const bookBarId = "#bookBar" + bookListSize;
	$(bookBarId).css('height', '325px');
	
	// 첫 번째 책, 두 번째 책, 세 번재 책, 네 번재 책 뿌려
	for(let i = 0; i < bookListSize; i++){
		
		let bookTagId = "#bookTag" + (i+1);
		
		switch(i){
		case(0): 
			console.log('0일때');
			$(bookTagId)[0].innerText = "첫 번째 책";
			break;
		case(1): 
			console.log('1일때');
			$(bookTagId)[0].innerText = "두 번째 책";
			break;
		case(2): 
			console.log('2일때');
			$(bookTagId)[0].innerText = "세 번째 책";
			break;
		case(3): 
			console.log('2일때');
			$(bookTagId)[0].innerText = "네 번째 책";
			break;
		}
		

	}
	
	
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>