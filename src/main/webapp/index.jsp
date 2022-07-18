<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css" />
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북이온앤온" name="title"/>
</jsp:include>
	<section id="content">
		<div class="article main-banner">
			<img src="${pageContext.request.contextPath}/resources/images/main-banner.png" alt="메인배너" />
		</div>
		<div class="article book-club-ann">
			<img src="${pageContext.request.contextPath}/resources/images/book-club-8.png" alt="북클럽공고" />
			<div class="button d-grid col-10 mx-auto">
				<button type="button" class="btn btn-lg ">북클럽 더보기 + </button>
			</div>
		</div>
		<div class="article goto">
			<div class="button d-grid col-12 mx-auto">
				<p>ddd</p>
				<p>함께 읽어요!</p>
				<p>북클럽</p><span>></span>
			</div>
		</div>
	</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
