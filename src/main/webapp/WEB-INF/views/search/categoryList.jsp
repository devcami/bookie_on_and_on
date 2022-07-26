<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/category.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="분야별 도서리스트" name="title"/>
</jsp:include>
<section id="content">
	<div id="category-container">
		<div id="category-header" class="text-center">
			<h1>분야별 베스트 도서</h1>
		</div>
		<div id="category-list">
				<div class="row">
	<div class="col-sm-4">
		<div class="card">
			<div class="card-body">
				<h5 class="card-title">Special title treatment</h5>
		        <p class="card-text"></p>
		        <a href="#" class="btn btn-primary">카테고리 바로가기</a>
			</div>
		</div>
	</div>
</div>	
		</div>
	
	</div>
</section>

<script>
window.addEventListener('load', () => {
	const list = document.querySelector("#category-list");
	for(let i = 1; i <= 12; i++){
		const div = `

		`;
		list.insertAdjacentHTML('beforeend', div);
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>