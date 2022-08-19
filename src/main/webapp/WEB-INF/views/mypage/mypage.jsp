<%@page import="com.kh.bookie.member.model.dto.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<script src='${pageContext.request.contextPath}/resources/js/main.js'></script>
<%
	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	Member loginMember = (Member) authentication.getPrincipal();
	System.out.println(loginMember.getNickname());
	String nickname = loginMember.getNickname();
%>
<style>
#myPick-book-div{
	border-bottom: 1px dashed grey;
    padding-bottom: 35px;
}
</style>
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
<sec:authentication property="principal" var="loginMember" scope="page"/>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내서재" name="title"/>
</jsp:include>

<!-- 프로필 -->
<section style="background-color: #fcfbf9;">
<c:if test="${param.memberId eq loginMember.memberId}">
<div class="start-mypage d-flex m-0 w-100" style="white-space: nowrap; padding: 10 30;     justify-content: space-between;">
	<h1>내서재</h1>
	<a href="${pageContext.request.contextPath}/mypage/mypageSetting.do" style="color: grey;" class="float-right">
		<i class="fa-solid fa-bars" style="font-size: 25;  padding-top: 6px;"></i>
	</a>
</div> 
</c:if>
<c:if test="${param.memberId ne loginMember.memberId}">
<div class="start-mypage d-flex m-0 w-100" style="white-space: nowrap; padding: 10 30;     justify-content: space-between;">
	<h1>님의 피드</h1>
	<a href="${pageContext.request.contextPath}/mypage/mypageSetting.do" style="color: grey;" class="float-right">
		<i class="fa-solid fa-bars" style="font-size: 25;  padding-top: 6px;"></i>
	</a>
</div> 
</c:if>

<div class="container">
	<div class="profile">
		<c:if test="${empty loginMember.originalFilename}">
		<div class="profile-image">
			<img src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png" alt="사진이없어요~"  width="150" height="150">
		</div>
		</c:if>
		<c:if test="${not empty loginMember.originalFilename}">
		<div class="profile-image">
			<img src="${pageContext.request.contextPath}/resources/upload/profile/${loginMember.renamedFilename}" alt="멋지고이쁜내사진"  width="200" height="200">
		</div> 
		</c:if>
		<div class="profile-user-settings d-flex" style="flex-direction: column;">
			<h1 class="profile-user-name">${loginMember.nickname}</h1>
			<c:if test="${loginMember.memberId eq param.memberId}">
			<button class="btn profile-settings-btn m-0 p-0 text-left" style="font-size: 1em;" aria-label="profile settings">공개프로필 수정<i class="fas fa-cog ml-2" aria-hidden="true"></i></button>
			</c:if>
		</div>
		<div class="profile-stats text-center">
			<ul>
				<li><span class="profile-stat-count follower">0</span> followers</li>
				<li><span class="profile-stat-count following">0</span> following</li>
			</ul>
		</div>
		<div class="w-100 text-center">
			<label>
				<input type="checkbox" name="follow-btn" class="follow-btn" onclick="followEvent(this);" data-follower-id="\${memberId}"/>
				<span class="mypickSpan">follow</span>
			</label>
		</div>
	</div>
	<!-- End of profile section -->
</div>
<!-- End of container -->
<!-- 말풍선 라인 -->
<c:if test="${empty loginMember.introduce}">
<div class="myprofile-body">
	<p style="max-width: 32em;">${loginMember.nickname}님은 어떤 분이신가요?<br />
	<a href="${pageContext.request.contextPath}/mypage/myMiniProfile.do">공개프로필</a>을 꾸며보세요.
	</p>
</div>
</c:if>
<c:if test="${not empty loginMember.introduce}">
	<div class="myprofile-body">
		<p style="max-width: 32em;">${loginMember.introduce}</p>
	</div>
</c:if> 

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">


<!-- 기록 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>기록</h1>
</div>
<div>
	<a class="record" href="${pageContext.request.contextPath}/mypage/myBook.do" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/mypage_booking.png" alt="내서재책"/ style="width: 70px; height : 80px;">
		<span>책</span>
    </a>
    <a class="record" href="${pageContext.request.contextPath}/mypage/myScrap.do" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/scrap.png" alt="스크랩"/ style="width: 70px; height : 80px;">
		<span>스크랩</span>
    </a>
    <a class="record" href="${pageContext.request.contextPath}/mypage/myDokooList.do" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/dokoo_icon.png" alt="독후감"/ style="width: 70px; height : 80px;">
		<span>독후감</span>
    </a>
    <a class="record" href="${pageContext.request.contextPath}/mypage/myPheedList.do" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/pheed_icon.png" alt="피드"/ style="width: 70px; height : 80px;">
		<span>피드</span>
    </a>
    <a class="record" href="${pageContext.request.contextPath}/mypage/myClubList.do" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/bookclub.png" alt="북클럽"/ style="width: 70px; height : 80px;">
		<span>북클럽</span>
    </a>
    <a class="record" onclick="moveToPointPage();" style="color:black; cursor: pointer;">
		<img src="${pageContext.request.contextPath}/resources/images/icon/point-icon.png" alt="포인트" style="width: 70px; height : 80px;">
		<span>일단 여기쓰세요 포인!!!!!!트</span>
    </a>
</div>


<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 읽고 있는 책 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>읽고 있는 책</h1>
</div>
<div id="book-div" style="border: none; padding-bottom: 0px;">
</div>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 마이픽 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>마이픽</h1>
</div>
<div id="myPick-book-div" style="border: none; padding-bottom: 0px;">
</div>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 독서달력 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>독서달력</h1>
</div>
<!-- calendar 태그 -->
<div id='calendar-container'>    
	<div id='calendar'></div>  
</div>  

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 읽은 책 그래프 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>읽은 책</h1>
</div>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">


</section>

<form:form
	name="pointFrm"
	method="post" 
	action="${pageContext.request.contextPath}/point/myPoint.do"/>

<script>

moveToPointPage = () => {
	const frm = document.pointFrm
    frm.submit();
}

document.querySelector(".profile-settings-btn").addEventListener("click", (e) => {
	location.href = "${pageContext.request.contextPath}/mypage/myMiniProfile.do";
});

/* 마이페이지 로딩시 내 책 정보 뿌려주기 */
window.onload = function(){
	const container = document.querySelector("#book-div");
	const myPickContainer = document.querySelector("#myPick-book-div");
	var itemId = [];
	var myPickItemId = [];
	/* 읽는 중인 itemId를 찾아오기 */
	$.ajax({
		url: `${pageContext.request.contextPath}/mypage/getItemId.do`,
		method : "get",
		success(data){
			itemId = data;
			console.log(itemId);
			/* 읽고 있는 책 찾아 뿌리기 */
			itemId.forEach((value, index, array)=>{
				$.ajax({
					url: `${pageContext.request.contextPath}/mypage/myReadingBook.do`,
					data: {
						itemId : value
					},
					method : "get",
					success(data){
						const {item} = data;
						console.log(item);
						console.log(item.length);
						item.forEach((book)=>{
							const {isbn13, title, author, publisher, pubDate, cover} = book;
							console.log(isbn13,cover);
							const div = `
										<div id="book-imgs" class="d-inline">
											<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);">
										</div>`;
							container.insertAdjacentHTML('beforeend', div);
						})
			 		},
					error : console.log
				});	
 			});
		},
		error : console.log
	});
			
	/* 마이픽 itemId 가져오기 */
	$.ajax({
		url: '${pageContext.request.contextPath}/mypage/getmyPickItemId.do',
		method: 'get',
		success(data){
			console.log(data);
			myPickItemId = data;
			console.log("myPickItemId : " + myPickItemId);
			myPickItemId.forEach ((value, index, array) =>{
				/* 마이픽 뿌려주기 */
				$.ajax({
					url: `${pageContext.request.contextPath}/mypage/myPickBook.do`,
					method : "get",
					data : {
						itemId : value
					},
					success(data){
						const {item} = data;
						console.log(item);
						console.log(item.length);
						item.forEach((book)=>{
							const {isbn13, title, author, publisher, pubDate, cover} = book;
							console.log(isbn13,cover);
							const div = `
										<div id="book-imgs" class="d-inline">
											<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);">
										</div>`;
							myPickContainer.insertAdjacentHTML('beforeend', div);
						})
			 		},
					error : console.log
				});
			});
		},
		error : console.log
	});
	
};

const bookEnroll = (e) => {
	const isbn13 = $(e).attr('value');
	location.href = "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13;
};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>