<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내서재" name="title"/>
</jsp:include>

<!-- 프로필 -->

<div class="start-mypage" style="white-space: nowrap; padding: 10 10 10 10;">
	<h1 style="display:inline;">내서재</h1>
	<a href="" style="color: grey"><i class="fa-solid fa-gear" onclick="" style="float: right; font-size: 25;"></i></a>
</div> 


<div class="container">
	<div class="profile">
		<div class="profile-image">
			<img src="https://images.unsplash.com/photo-1513721032312-6a18a42c8763?w=152&h=152&fit=crop&crop=faces" alt="">
		</div>
		<div class="profile-user-settings">
			<h1 class="profile-user-name">꼬두마리</h1>
			<button class="btn profile-edit-btn">Edit Profile</button>
			<button class="btn profile-settings-btn" aria-label="profile settings"><i class="fas fa-cog" aria-hidden="true"></i></button>
		</div>
		<div class="profile-stats">
			<ul>
				<li><span class="profile-stat-count">188</span> followers</li>
				<li><span class="profile-stat-count">206</span> following</li>
			</ul>
		</div>
	</div>
	<!-- End of profile section -->
</div>
<!-- End of container -->

<!-- 말풍선 라인 -->
<div class="myprofile-body">
	<p>[여기맴버아이디 가져온다!]님은 어떤 분이신가요?<br />
	<a href="">공개프로필</a>을 꾸며보세요.
	</p>
</div>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 기록 -->
<h1>기록</h1>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 읽고 있는 책 -->
<h1>읽고 있는 책</h1>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 마이픽 -->
<h1>마이픽</h1>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 독서달력 -->
<h1>독서달력</h1>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">

<!-- 읽은 책 그래프 -->
<h1>읽은 책</h1>

<hr class="bar" style="border: solid 10px #f6f5f5; margin-top: 3rem;">



<script>

<%-- 상단 피드 헤더 바 --%>
let header = document.querySelector("#header-container")
let headerHeight = header.clientHeight;

const pheedHeader = document.querySelector("#pheed-header");
window.onscroll = function () {
	let windowTop = window.scrollY;
	if (windowTop >= headerHeight) {
		pheedHeader.classList.add("drop");
	} 
	else{
		pheedHeader.classList.remove("drop");
	}
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>