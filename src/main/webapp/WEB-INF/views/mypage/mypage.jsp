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
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
table tr td{
	width: 4rem;
	text-align: center;
}
.table-bottom{
	border-top: 1px solid black;
}
</style>
<sec:authentication property="principal" var="loginMember" scope="page"/>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내서재" name="title"/>
</jsp:include>

<!-- 프로필 -->
<section style="background-color: #fcfbf9;">
<c:if test="${member.memberId eq loginMember.memberId}">
<div class="start-mypage d-flex m-0 w-100" style="white-space: nowrap; padding: 10 30; justify-content: space-between;">
	<h1 style="display:inline;">[${member.nickname}] 님의 서재</h1>
	<a href="${pageContext.request.contextPath}/mypage/mypageSetting.do" style="color: grey;" class="float-right">
		<i class="fa-solid fa-bars" style="font-size: 25; padding-top: 6px;"></i>
	</a>
</div> 
</c:if>
<c:if test="${member.memberId ne loginMember.memberId}">
<div class="start-mypage d-flex m-0 w-100" style="white-space: nowrap; padding: 10 30; justify-content: space-between;">
	<h1 style="display:inline;">[${member.nickname}] 님의 서재</h1>
</div> 
</c:if>

<div class="container">
	<div class="profile">
		<c:if test="${empty member.originalFilename}">
			<div class="profile-image">
				<img src="${pageContext.request.contextPath}/resources/images/icon/none-profile-img.png" alt="사진이없어요~"  width="150" height="150">
			</div>
		</c:if>
		<c:if test="${not empty member.originalFilename}">
			<div class="profile-image">
				<img src="${pageContext.request.contextPath}/resources/upload/profile/${member.renamedFilename}" alt="멋지고이쁜내사진"  width="200" height="200">
			</div> 
		</c:if>
		<div class="profile-user-settings d-flex" style="flex-direction: column;">
			<h1 class="profile-user-name">${member.nickname}</h1>
			<c:if test="${loginMember.memberId eq param.memberId}">
			<button class="btn profile-settings-btn m-0 p-0 text-left" style="font-size: 1em;" aria-label="profile settings">공개프로필 수정<i class="fas fa-cog ml-2" aria-hidden="true"></i></button>
			</c:if>
		</div>
		<div class="profile-stats">
			<ul>
				<li onclick="location.href='${pageContext.request.contextPath}/mypage/followList.do?memberId=${member.memberId}&follower=follower';"><span class="profile-stat-count follower" id="followers-cnt"></span> followers</li>
				<li onclick="location.href='${pageContext.request.contextPath}/mypage/followList.do?memberId=${member.memberId}&follower=following';"><span class="profile-stat-count following" id="following-cnt"></span> following</li>
			</ul>
		</div>
		<c:if test="${loginMember.memberId ne member.memberId}">
		<div class="w-100">
			<label>
				<input type="checkbox" name="follow-btn" id="follow-btn" class="follow-btn" onclick="followEvent(this);" data-follower-id="${member.memberId}"/>
				<span class="mypickSpan">follow</span>
			</label>
		</div>
		</c:if>
	</div>
	<!-- End of profile section -->
</div>
<!-- End of container -->
<!-- 말풍선 라인 -->
<c:if test="${empty member.introduce}">
<div class="myprofile-body">
	<p style="max-width: 32em;">${member.nickname}님은 어떤 분이신가요?<br />
	<c:if test="${loginMember.memberId eq member.memberId}">
		<a href="${pageContext.request.contextPath}/mypage/myMiniProfile.do?memberId=${member.memberId}">공개프로필</a>을 꾸며보세요.
	</c:if>
	</p>
</div>
</c:if>
<c:if test="${not empty member.introduce}">
	<div class="myprofile-body">
		<p style="max-width: 32em;">${member.introduce}</p>
	</div>
</c:if> 

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">


<!-- 기록 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>기록</h1>
</div>
<div class="d-flex" id="record">
	<a class="record" href="${pageContext.request.contextPath}/mypage/myBook.do?memberId=${member.memberId}" style="color:black">
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
		<span>포인트</span>
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
<div class="start-mypage" id="graph-container" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>읽은 책 그래프</h1>
<div id="book-graph">
	<table id="book-grapt-table" style="margin-top: 10rem;">
	    <tbody id="book-grapt-table-body">
	        <tr id="month0" >
	            <td style="width:0px"></td>
	            <td class="table-bottom">1월</td>
	            <td class="table-bottom">2월</td>
	            <td class="table-bottom">3월</td>
	            <td class="table-bottom">4월</td>
	            <td class="table-bottom">5월</td>
	            <td class="table-bottom">6월</td>
	            <td class="table-bottom">7월</td>
	            <td class="table-bottom">8월</td>
	            <td class="table-bottom">9월</td>
	            <td class="table-bottom">10월</td>
	            <td class="table-bottom">11월</td>
	            <td class="table-bottom">12월</td>
	        </tr>
	    </tbody>
	</table>
</div>
</div>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 취향 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
	<h1 style="text-align: center;">주 독서 분야</h1>
</div>
<div style="position: relative; height:50rem; width:800px;">
  <canvas id="myChart" width="500" height="500" style="margin: 0 auto;"></canvas>
</div>
<br />
<br />
<br />
<br />
<br />
<br />
<br />

</section>

<form:form
	name="pointFrm"
	method="post" 
	action="${pageContext.request.contextPath}/point/myPoint.do"/>

<script>

/* 마이페이지 로딩 시 팔로우 내역과 팔로우 수 가져오기 */
window.addEventListener('load', () => {
	const memberId = '${member.memberId}';
	$.ajax({
		url : "${pageContext.request.contextPath}/mypage/getFollow.do",
		method : 'get',
		data : {
			memberId
		},
		success(resp){
			console.log(resp);	
			const {followersCnt, followingCnt, followers} = resp;
			document.querySelector("#followers-cnt").innerText = followersCnt;
			document.querySelector("#following-cnt").innerText = followingCnt;
			
			// 팔로워 체크 처리
			if(followers){
				const followerArr = followers.split(','); 
				followerArr.forEach((f) => {
					if(memberId == f){
						document.querySelector("#follow-btn").checked = true;
					}
				});
			}
		},
		error:console.log
	});
});

/* 팔로우 버튼 클릭 시 팔로잉 이벤트 */
const followEvent = (e) => {
	const followingMemberId = e.dataset.followerId;
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	
	// 팔로우 되어있는 사람 취소
	if(!e.checked){
		$.ajax({
			url : '${pageContext.request.contextPath}/search/deleteFollower.do',
			method : 'post',
			headers,
			data : {
				memberId:'${loginMember.memberId}',
				followingMemberId
			},
			success(resp){
				e.checked = false;
				let cnt = Number(document.querySelector("#followers-cnt").innerText);
				document.querySelector("#followers-cnt").innerText = cnt - 1;
			},
			error: console.log
		});
	}
	// 팔로우 안되어있는 사람 등록
	else{
		$.ajax({
			url : '${pageContext.request.contextPath}/search/insertFollower.do',
			method : 'post',
			headers,
			data : {
				memberId:'${loginMember.memberId}',
				followingMemberId
			},
			success(resp){
				e.checked = true;
				let cnt = Number(document.querySelector("#followers-cnt").innerText);
				document.querySelector("#followers-cnt").innerText = cnt + 1;
			},
			error: console.log
		});
	}

}

moveToPointPage = () => {
	const frm = document.pointFrm
    frm.submit();
};

if(document.querySelector(".profile-edit-btn")){
	document.querySelector(".profile-edit-btn").addEventListener("click", (e) => {
		location.href = "${pageContext.request.contextPath}/mypage/myMiniProfile.do?memberId=${member.memberId}";
	});	
}

if(document.querySelector(".profile-settings-btn")){
	document.querySelector(".profile-settings-btn").addEventListener("click", (e) => {
		location.href = "${pageContext.request.contextPath}/mypage/myMiniProfile.do?memberId=${member.memberId}";
	});
}

/* 마이페이지 로딩시 내 책 정보 뿌려주기 */
window.addEventListener('load', () => {
	const picture = "${member.renamedFilename}";
	console.log(picture);
	const memberId = "${member.memberId}";
	const container = document.querySelector("#book-div");
	const myPickContainer = document.querySelector("#myPick-book-div");
	var itemId = [];
	var myPickItemId = [];
	/* 읽는 중인 itemId를 찾아오기 */
	$.ajax({
		url: `${pageContext.request.contextPath}/mypage/getIngItemId.do`,
		method : "get",
		data : {memberId : memberId},
		success(data){
			itemId = data;
			/* console.log(itemId); */
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
						/* console.log(item); */
						/* console.log(item.length); */
						item.forEach((book)=>{
							const {isbn13, title, author, publisher, pubDate, cover} = book;
							/* console.log(isbn13,cover); */
							const div = `
										<div id="book-imgs" class="d-inline">
											<c:choose>
												<c:when test="${loginMember.memberId eq member.memberId}">
													<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);">
												</c:when>
												<c:otherwise>
													<img src=\${cover}  value=\${isbn13}>	
												</c:otherwise>
											</c:choose>
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
		data : {memberId : memberId},
		success(data){
			/* console.log(data); */
			myPickItemId = data;
			/* console.log("myPickItemId : " + myPickItemId); */
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
						/* console.log(item); */
						/* console.log(item.length); */
						item.forEach((book)=>{
							const {isbn13, title, author, publisher, pubDate, cover} = book;
							const div = `
										<div id="book-imgs" class="d-inline">
											<c:choose>
												<c:when test="${loginMember.memberId eq member.memberId}">
													<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);">
												</c:when>
												<c:otherwise>
													<img src=\${cover}  value=\${isbn13}>	
												</c:otherwise>
											</c:choose>
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
});

const bookEnroll = (e) => {
	const isbn13 = $(e).attr('value');
	location.href = "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13;
};

/* 달력출력 스크립트 */
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var bookIngList = [];
	var itemId = [];
	var list = [];
	var coverList = [];
	const memberId = "${member.memberId}";
	$.ajax({
		url: `${pageContext.request.contextPath}/mypage/myBookIngList.do`,
		data : {memberId : memberId},
		async:false,
		method : "get",
		success(data){
			bookIngList = data;
			/* 읽은 책 찾아 뿌리기 */
		 	bookIngList.forEach((value, index, array)=>{
				if(value.endedAt){
					$.ajax({
						url: `${pageContext.request.contextPath}/mypage/myEndedAtBook.do`,
						async:false,
						data: {
							itemId : value.itemId
						},
						method : "get",
						success(data){
							const {item} = data;
							//console.log(item);
							//console.log(item.length);
							item.forEach((bookIng)=>{
								const {cover, isbn13} = bookIng;
								const year = value.endedAt.year;
								const month = value.endedAt.monthValue.toString().length == 1 ? '0'+value.endedAt.monthValue : value.endedAt.monthValue;
								const day = value.endedAt.dayOfMonth.toString().length == 1 ? '0'+value.endedAt.dayOfMonth : value.endedAt.dayOfMonth;
								list.push(
									{
									start : year + '-' + month + '-' + day,
									end : year + '-' + month + '-' + day,
									url : "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13,
									borderColor : '#fcfbf9',
									backgroundColor : '#fcfbf9',
									cover : cover,
									}
								);
							})
				 		},
						error : console.log
					});	
				}
 			}); 
		},
		error : console.log
	}); 
	
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
		headerToolbar : { // 헤더에 표시할 툴 바
			start : 'prev next today',
			center : 'title',
			end : 'dayGridMonth,dayGridWeek,dayGridDay'
		},
		titleFormat : function(date) {
			return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
		},
		//initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
		selectable : true, // 달력 일자 드래그 설정가능
		droppable : true,
		editable : true,
		nowIndicator: true, // 현재 시간 마크
		locale: 'ko', // 한국어 설정
		events: list,
		eventContent: function(arg) {
			let coverImg = document.createElement('img')
			//console.log("위치확인");
			//console.log(arg.event._def.extendedProps.cover);
			if (arg.event._def.extendedProps.cover) {
				coverImg.setAttribute("src", "" + arg.event._def.extendedProps.cover + "");
				coverImg.setAttribute("style", "width: 3.5rem; height: 5rem");
			}
			let arrayOfDomNodes = [ coverImg ]
			return { domNodes: arrayOfDomNodes }
		}
	});
	calendar.render();
});

/* 읽은책 그래프 만들기 */
window.addEventListener('load', () => {
	const container = document.querySelector("#book-grapt-table-body")
	var bookIngList = [];
	var itemId = [];
	var list = [];
	const memberId = "${member.memberId}";
	let i = 1;
	let l = 1;
	
	$.ajax({
		url: `${pageContext.request.contextPath}/mypage/myBookIngList.do`,
		data : {memberId : memberId},
		async:false,
		method : "get",
		success(data){
			bookIngList = data;
			//console.log(i);
			/* 읽은 책 찾아 뿌리기 */
		 	bookIngList.forEach((value, index, array)=>{
		 		if(!value.endedAt){
		 			l--;
		 		}
				if(value.endedAt){
					console.log("여기야");
					console.log(value);
					$.ajax({
						url: `${pageContext.request.contextPath}/mypage/myEndedAtBook.do`,
						async:false,
						data: {
							itemId : value.itemId
						},
						method : "get",
						success(data){
							const {item} = data;
							item.forEach((bookIng)=> {
								const {isbn13, title, author, publisher, pubDate, cover} = bookIng;
								//console.log("여긴어디냐");
								console.log(value.endedAt.monthValue);
								//console.log(i);
								const month = value.endedAt.monthValue;
								//console.log(bookIng);
								console.log(l);
								
								const div = `<tr id="month\${l}">
									            <td style="width:0px"></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									            <td></td>
									        </tr>`;
								container.insertAdjacentHTML('afterbegin', div);
								if(i > 1){
								 	for(let k = 1; k <= i; k++){
										for(let j = 1; j < 13; j++){
											if(document.querySelector(`#month\${k}`).children[j].children.length != 1
													&& month == j) { i = k; break;}
						 				}
									}
								}
								console.log("여긴옴?");
					        	if(month == 1)
					        		document.querySelector(`#month\${i}`).children[1].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 2)
					        		document.querySelector(`#month\${i}`).children[2].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 3)
					        		document.querySelector(`#month\${i}`).children[3].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 4)
					        		document.querySelector(`#month\${i}`).children[4].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 5)
					        		document.querySelector(`#month\${i}`).children[5].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 6)
					        		document.querySelector(`#month\${i}`).children[6].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 7)
					        		document.querySelector(`#month\${i}`).children[7].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 8)
					        		document.querySelector(`#month\${i}`).children[8].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 9)
					        		document.querySelector(`#month\${i}`).children[9].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 10)
					        		document.querySelector(`#month\${i}`).children[10].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 11)
					        		document.querySelector(`#month\${i}`).children[11].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
					        	if(month == 12)
					        		document.querySelector(`#month\${i}`).children[12].innerHTML = `<img src=\${cover}  value=\${isbn13} onclick="bookEnroll(this);" style="width: 3.5rem; height: 5rem">`;
							})
				 		},
						error : console.log
					});	
				}
				i++;  
				l++;
 			}); 
		},
		error : console.log
	}); 
});

/* 취향차트부분 */
window.addEventListener('load', () => {
	const memberId = "${member.memberId}";
	/* 랜덤칼라 생성하기 함수 */
	function colorize() {
		var r = Math.floor(Math.random()*200);
		var g = Math.floor(Math.random()*200);
		var b = Math.floor(Math.random()*200);
		var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
		return color;
	}
	
	var itemId = [];
	var categoryList = [];
	var colorList = [];
	
	/* 내 책 전체정보 가져오기 */
	$.ajax({
		url : '${pageContext.request.contextPath}/mypage/myBookAllItemId.do',
		data : { memberId :memberId },
		async:false,
		success(data){
			//console.log(data);
			//console.log(data[0]);
			itemId = data;
			/* 읽고 있는 책 찾아 뿌리기 */
			itemId.forEach((value, index, array)=>{
				$.ajax({
					url: `${pageContext.request.contextPath}/mypage/statusBook.do`,
					data: {
						itemId : value
					},
					async:false,
					method : "get",
					success(data){
						const {item} = data;
						// console.log(item);
						// console.log(item.length);
						item.forEach((book) => {
							const {isbn13, title, author, publisher, pubDate, cover, categoryName} = book;
							categoryList.push(categoryName.split('>', 2)[1]);
						});
			 		},
					error : console.log
				});	
	 		})
		},
		error : console.log,
	});

	/* 찾아온 카테고리 중복값 제거 */
	const result = {};
	categoryList.forEach((x) => { 
	  result[x] = (result[x] || 0)+1; 
	});
	console.log(result);
	
	/* 랜덤한 색깔 개수만큼 쌓아 */
	for(let i = 0; i < Object.keys(result).length; i++){
		colorList.push(colorize());
	}
	const labelData = [];
	for(let i = 0; i < Object.keys(result).length; i++){
		labelData.push(Object.keys(result)[i] + "(" + Object.values(result)[i] + ")");
	}
	
	const data = {
		  
		  labels: labelData,
		  datasets: [{
		    label: 'My Book Category Dataset',
		    data: Object.values(result),
		    backgroundColor: colorList,
		    hoverOffset: 4
		  }]
		};
	
	 const config = {
		  type: 'pie',
		  data: data,
		  options: {
			  responsive: false, // 차트크기변경할때 꼭 false
			  legend:{
			  	position: 'left',
			  },
			  title:{
				diplay: true,
				text : 'My Book Category',
			  },
			  animation:{
				  animateScale: true,
				  animateRotate: true
			  },
		  }
		};
	
	 const myChart = new Chart(
		    document.getElementById('myChart'),
		    config
		  );
})
</script>
 
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>