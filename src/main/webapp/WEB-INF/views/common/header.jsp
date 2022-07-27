<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">


<script src="https://kit.fontawesome.com/1c396dc14f.js" crossorigin="anonymous"></script>

<!-- 글꼴 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />

<script>
<c:if test="${not empty msg}">
	alert('${msg}');
</c:if>
</script>
</head>
<body>
<div id="body-container">
	<header>
		<div id="header-container">
			<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="북이온앤온로고" width="100px" onclick="location.href='${pageContext.request.contextPath}'"/>
			<!-- 상단에 이름 표시  -->
			<c:if test="${not empty loginMember no }">
			  <span><a href="#">${loginMember.name }</a>님, 안녕하세요</span>
			  &nbsp;&nbsp;
			  <!-- 로그아웃 -->
			  <button 
			  type="button" class="btn btn-warning"
			  onclick="location.href='${pageContext.request.contextPath}/member/memberlogout.do'">로그아웃</button>
			</c:if>
			<c:if test="${empty loginMember no }">
			</c:if>
			<i class="fa-solid fa-user-plus i-login" onclick="location.href='${pageContext.request.contextPath}/member/memberlogin.do'"></i>
			<img class="sh-right" src="${pageContext.request.contextPath}/resources/images/icon/search.png" alt="검색" onclick="location.href='${pageContext.request.contextPath}/search/searchForm.do'" />
			<%-- <img class="sh-right" src="${pageContext.request.contextPath}/resources/images/icon/alarm.png" alt="알림"  /> --%>
		</div>
		<nav class="navbar fixed-bottom navbar-expand-lg navbar-light">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon "></span>
		  	</button>
			<div class="collapse navbar-collapse " id="navbarNav">
				<ul class="navbar-nav mr-auto">
			    	<li class="nav-item">
			    		<%-- 현재 URI --%>
						<c:set var="uri" value="${pageContext.request.requestURI}"/>
						
			    		<!-- 홈 링크 -->
			    		<a class="nav-link" href="${pageContext.request.contextPath}">
			    			<c:if test="${uri eq '/bookie/'}">
			    			<img src="${pageContext.request.contextPath}/resources/images/icon/i_home_on.png" alt="homeicon" />홈
			    			</c:if>
			    			<c:if test="${uri ne '/bookie/'}">
			    			<img src="${pageContext.request.contextPath}/resources/images/icon/i_home.png" alt="homeicon" />홈
			    			</c:if>
		    			</a>
	    			</li>
                    <li class="nav-item">
			    		<!-- 독후감 링크 /dokoo/로 시작 dokooFlList : follwer list / dokooCrList : 발견 list -->
                    	<a class="nav-link" href="${pageContext.request.contextPath}/dokoo/dokooList.do">
			    			<c:if test="${fn:contains(uri, '/bookie/WEB-INF/views/dokoo/')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_dokoo_on.png" alt="dokooicon" />독후감
			    			</c:if>
			    			<c:if test="${!fn:contains(uri, '/bookie/WEB-INF/views/dokoo/')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_dokoo.png" alt="dokooicon" />독후감
			    			</c:if>
                    	</a>
                    </li>
                    <li class="nav-item">
			    		<!-- 피드 링크 /pheed/로 시작 pheedFlList : follower list / pheedCrList : 발견 list -->
                    	<a class="nav-link" href="${pageContext.request.contextPath}/pheed/pheedFList.do">
                    		<script>console.log('${uri}')</script>
			    			<c:if test="${fn:contains(uri, '/bookie/WEB-INF/views/pheed/')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_pheed_on.png" alt="pheedicon" />피드
			    			</c:if>
			    			<c:if test="${!fn:contains(uri, '/bookie/WEB-INF/views/pheed/')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_pheed.png" alt="pheedicon" />피드
			    			</c:if>
                    	</a>
                    </li>
                    <li class="nav-item">
			    		<!-- 북클럽 링크 /club/로 시작 -->
                    	<a class="nav-link" href="${pageContext.request.contextPath}/club/clubList.do">
			    			<c:if test="${fn:contains(uri, '/bookie/WEB-INF/views/club/')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_club_on.png" alt="clubicon" />북클럽
			    			</c:if>
			    			<c:if test="${!fn:contains(uri, '/bookie/WEB-INF/views/club/')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_club.png" alt="clubicon" />북클럽
			    			</c:if>
                    	</a>
                    </li>
                    <li class="nav-item">
			    		<!-- 내서재 링크 /mypage/로 시작 -->
                    	<a class="nav-link" href="${pageContext.request.contextPath}/mypage">
			    			<c:if test="${fn:contains(uri, '/bookie/WEB-INF/views/mypage')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_mypage_on.png" alt="mypageicon" />내서재
			    			</c:if>
			    			<c:if test="${!fn:contains(uri, '/bookie/WEB-INF/views/mypage/')}">
                    		<img src="${pageContext.request.contextPath}/resources/images/icon/i_mypage.png" alt="mypageicon" />내서재
			    			</c:if>
                    	</a>
                    </li>
			    </ul>
			 </div>
		</nav>
	</header>


