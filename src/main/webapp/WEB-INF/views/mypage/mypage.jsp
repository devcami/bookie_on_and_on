<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<script src='${pageContext.request.contextPath}/resources/js/main.js'></script>
<script>
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth'
        });
        calendar.render();
      });

</script>

<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내서재" name="title"/>
</jsp:include>

<!-- 프로필 -->
<section style="background-color: #fcfbf9;">
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
	<h1 style="display:inline;">내서재</h1>
	<a href="${pageContext.request.contextPath}/mypage/mypageSetting.do" style="color: grey;"><i class="fa-solid fa-gear" style="float: right; font-size: 25;  padding-top: 6px;"></i></a>
</div> 
<div class="container">
	<div class="profile">
	<!-- 	
		<div class="profile-image">
			<img src="${pageContext.request.contextPath}/resources/images/icon/none-profile.png" alt="">
		</div>
	-->
		<div class="profile-image">
			<img src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces" alt="">
		</div> 
		<div class="profile-user-settings">
			<h1 class="profile-user-name">꼬두마리</h1>
			<button class="btn profile-edit-btn" style="font-size: 1em;">Edit Mini Profile</button>
			<button class="btn profile-settings-btn" aria-label="profile settings" style="margin-left: 0;"><i class="fas fa-cog" aria-hidden="true"></i></button>
		</div>
		<div class="profile-stats">
			<ul>
				<li><span class="profile-stat-count follower">10000</span> followers</li>
				<li><span class="profile-stat-count following">10000</span> following</li>
			</ul>
		</div>
	</div>
	<!-- End of profile section -->
</div>
<!-- End of container -->
<!-- 말풍선 라인 -->
<%-- <c:if test="${empty introduce}"> --%>
<div class="myprofile-body">
	<p style="max-width: 32em;">[여기맴버아이디 가져온다!]님은 어떤 분이신가요?<br />
	<a href="${pageContext.request.contextPath}/mypage/myMiniProfile.do">공개프로필</a>을 꾸며보세요.
	</p>
</div>
<%-- </c:if> --%>
<%-- 
<c:if test="${not empty introduce}">
	<div class="myprofile-body">
		<p style="max-width: 32em;">여기떠들어 ㅇㅋ?</p>
	</div>
</c:if> 
--%>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 기록 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>기록</h1>
</div>
<div>
	<a class="record" href="${pageContext.request.contextPath}" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/mypage_booking.png" alt="내서재책"/ style="width: 70px; height : 80px;">
		<span>책</span>
    </a>
    <a class="record" href="${pageContext.request.contextPath}" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/scrap.png" alt="스크랩"/ style="width: 70px; height : 80px;">
		<span>스크랩</span>
    </a>
    <a class="record" href="${pageContext.request.contextPath}" style="color:black">
		<img src="${pageContext.request.contextPath}/resources/images/icon/bookclub.png" alt="북클럽"/ style="width: 70px; height : 80px;">
		<span>북클럽</span>
    </a>
</div>


<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 읽고 있는 책 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>읽고 있는 책</h1>
</div>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 마이픽 -->
<div class="start-mypage" style="white-space: nowrap; padding: 10 20 10 20;">
<h1>마이픽</h1>
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

<script>
document.querySelector(".profile-settings-btn").addEventListener("click", (e) => {
	location.href = "${pageContext.request.contextPath}/mypage/myMiniProfile.do";
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>