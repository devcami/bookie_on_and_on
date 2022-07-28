<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/intro.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽리스트" name="title"/>
</jsp:include>

<section>
	<div id="intro-header" class="" style="display:none">
		<p id="title-p">
			<i class="fa-solid fa-angle-left" onclick="location.href='${pageContext.request.contextPath}/dokoo/dokooList.do'"></i>
		</p>
	</div>
	<div id="intro-container">
		<img src="${pageContext.request.contextPath}/resources/images/intro.png" alt="소개배너" />
		<div class="line"></div>
		<img class="image" id="image" src="${pageContext.request.contextPath}/resources/images/intro-banner.png" alt="소개배너" />
	</div>
	<div class="line"></div>
	<div id="intro-article1" class="article">
		<h1>독서 기록 ✍️</h1>
		<h4>
		내가 읽었던, 읽고 있는 책들을 더 완벽하게 읽기를 도와주는 북이온앤온 입니다.
		</h4>
		<h4>
		내 서재의 기록을 돌아보며 한 주, 1개월, 1년을 특별하게 채워보세요.
		</h4>
		<h4>
		어떤 책이 읽고 싶은지, 읽고 있는지 혹은 여태까지 무슨 책을 읽었는지 <br />
		</h4>
		<h4>
		책을 검색하고 상태에 따른 정리를 할 수 있어요.
		</h4>
		<span>🧡 읽고 싶은, 읽는 중, 읽음, 잠시 멈춤, 중단 🧡</span>
		<h4>
		다섯가지의 상태로 나누어 , 책을 내 서재에 저장하고 관리해요.
		</h4>
		<h4>
		저장된 책들은 읽기 시작한 날짜와 완료한 날짜를 지정하여 정리할 수 있어요.
		</h4>
		
	</div>
	<div class="line"></div>
	<div id="intro-article2" class="article">
		<h1>피드 🤳</h1>
		<h3>어서오세요, 가상서재 북이온앤온</h3>		
		<h4>
		책을 읽다가 인상깊게 남은 부분이 한번쯤 있을 것이라고 생각해요.
		</h4>
		<h4>
		기록하고 싶은 말, 다시 보고싶은 부분에 표시하고 사람들과 공유할 수 있어요.
		</h4>
	</div>
	<div class="line"></div>
	<div id="intro-article2" class="article">
		<h1>북클럽 👨‍👨‍👦</h1>
		<h3>함께 읽어요</h3>
		<h4>단순히 기록의 기능을 넘어서 누군가와 같이 읽는 책.</h4>
		<h4>책을 함께 읽어가는 감성을 채워봐요</h4>
		<h4>나와 독서 취향이 비슷한 사람들과 모여 미션을 달성하며 북클럽 활동을 할 수 있어요.</h4>
	</div>
</section>

<script>
		
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>