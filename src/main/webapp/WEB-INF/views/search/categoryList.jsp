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
			<h1>분야별 도서리스트</h1>
			
		</div>
		<div id="category-list">
			<!-- 첫번째줄 -->
			<div class="row">
				<!-- #1 -->
				<div class="col-sm-3 ">
				<div class="accordion " id="ad1">
					<div class="card">
						<div class="card-header btn" id="heading1" data-toggle="collapse"
									data-target="#collapse1" aria-expanded="true"
									aria-controls="collapse1">경제</div>
						<div id="collapse1" class="collapse"
							aria-labelledby="heading1" data-parent="#ad1">
							<div class="card-body">
						        <p class="card-text" data-category="economy">경제/경영</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #2 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad2">
					<div class="card">
						<div class="card-header btn" id="heading2" data-toggle="collapse"
									data-target="#collapse2" aria-expanded="true"
									aria-controls="collapse2">공학</div>
						<div id="collapse2" class="collapse"
							aria-labelledby="heading2" data-parent="#ad2">
							<div class="card-body">
						        <p class="card-text" data-category="computer">컴퓨터/모바일</p>
						        <p class="card-text" data-category="science">과학</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #3 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad3">
					<div class="card">
						<div class="card-header btn" id="heading3" data-toggle="collapse"
									data-target="#collapse3" aria-expanded="true"
									aria-controls="collapse3">문학</div>
						<div id="collapse3" class="collapse"
							aria-labelledby="heading3" data-parent="#ad3">
							<div class="card-body">
						        <p class="card-text" data-category="novel">소설/시/희곡</p>
						        <p class="card-text" data-category="classic">고전</p>
						        <p class="card-text" data-category="fiction">장르소설</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #4 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad4">
					<div class="card">
						<div class="card-header btn" id="heading4" data-toggle="collapse"
									data-target="#collapse4" aria-expanded="true"
									aria-controls="collapse4">자기계발</div>
						<div id="collapse4" class="collapse"
							aria-labelledby="heading4" data-parent="#ad4">
							<div class="card-body">
						        <p class="card-text" data-category="selfImprovement">자기계발</p>
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
			<!-- 두번째줄 -->
			<div class="row">
				<!-- #5 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad5">
					<div class="card">
						<div class="card-header btn" id="heading5" data-toggle="collapse"
									data-target="#collapse5" aria-expanded="true"
									aria-controls="collapse5">언어</div>
						<div id="collapse5" class="collapse"
							aria-labelledby="heading5" data-parent="#ad5">
							<div class="card-body">
						        <p class="card-text" data-category="language">외국어</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #6 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad6">
					<div class="card">
						<div class="card-header btn" id="heading6" data-toggle="collapse"
									data-target="#collapse6" aria-expanded="true"
									aria-controls="collapse6">취미</div>
						<div id="collapse6" class="collapse"
							aria-labelledby="heading6" data-parent="#ad6">
							<div class="card-body">
						        <p class="card-text" data-category="travel">여행</p>
						        <p class="card-text" data-category="home">가정/요리/뷰티</p>
						        <p class="card-text" data-category="health">건강/취미/레저</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #7 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad7">
					<div class="card">
						<div class="card-header btn" id="heading7" data-toggle="collapse"
									data-target="#collapse7" aria-expanded="true"
									aria-controls="collapse7">에세이</div>
						<div id="collapse7" class="collapse"
							aria-labelledby="heading7" data-parent="#ad7">
							<div class="card-body">
						        <p class="card-text" data-category="essay">에세이</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #8 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad8">
					<div class="card">
						<div class="card-header btn" id="heading8" data-toggle="collapse"
									data-target="#collapse8" aria-expanded="true"
									aria-controls="collapse8">예술</div>
						<div id="collapse8" class="collapse"
							aria-labelledby="heading8" data-parent="#ad8">
							<div class="card-body">
						        <p class="card-text" data-category="art">예술/대중문화</p>
							</div>
						</div>
					</div>
				</div>
				</div>
			</div>
			
			<!-- 세번째줄 -->
			<div class="row">
				<!-- #9 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad9">
					<div class="card">
						<div class="card-header btn" id="heading9" data-toggle="collapse"
									data-target="#collapse9" aria-expanded="true"
									aria-controls="collapse9">교육</div>
						<div id="collapse9" class="collapse"
							aria-labelledby="heading9" data-parent="#ad9">
							<div class="card-body">
						        <p class="card-text" data-category="baby">유아</p>
						        <p class="card-text" data-category="children">어린이</p>
						        <p class="card-text" data-category="teenager">청소년</p>
						        <p class="card-text" data-category="parent">좋은부모</p>
						        <p class="card-text" data-category="certification">수험서/자격증</p>
						        <p class="card-text" data-category="professional">대학교재/전문서적</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #10 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad10">
					<div class="card">
						<div class="card-header btn" id="heading10" data-toggle="collapse"
									data-target="#collapse10" aria-expanded="true"
									aria-controls="collapse10">인문학</div>
						<div id="collapse10" class="collapse"
							aria-labelledby="heading10" data-parent="#ad10">
							<div class="card-body">
						        <p class="card-text" data-category="history">역사</p>
						        <p class="card-text" data-category="humanities">인문학</p>
						        <p class="card-text" data-category="socialScience">사회과학</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #11 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad11">
					<div class="card">
						<div class="card-header btn" id="heading11" data-toggle="collapse"
									data-target="#collapse11" aria-expanded="true"
									aria-controls="collapse11">종교</div>
						<div id="collapse11" class="collapse"
							aria-labelledby="heading11" data-parent="#ad11">
							<div class="card-body">
						        <p class="card-text" data-category="religion">종교/역학</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- #12 -->
				<div class="col-sm-3">
				<div class="accordion" id="ad12">
					<div class="card">
						<div class="card-header btn" id="heading12" data-toggle="collapse"
									data-target="#collapse12" aria-expanded="true"
									aria-controls="collapse12">기타</div>
						<div id="collapse12" class="collapse"
							aria-labelledby="heading12" data-parent="#ad12">
							<div class="card-body">
						        <p class="card-text" data-category="cartoon">만화</p>
						        <p class="card-text" data-category="magazine">잡지</p>
						        <p class="card-text" data-category="etc">사전/기타</p>
							</div>
						</div>
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
document.querySelectorAll(".card-text").forEach((p) => {
	p.addEventListener('click', (e) => {
		console.log(e.target.dataset.category);
		const category = e.target.dataset.category;
		location.href = "${pageContext.request.contextPath}/search/bookListByCategory.do?category=" + category;
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>