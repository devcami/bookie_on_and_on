<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽리스트" name="title"/>
</jsp:include>
<section id="content">
	

	<div id="head">
		<div id="head-img">
			<c:forEach items="${club.bookList}" var="book" varStatus="vs">
				<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}">
			</c:forEach>
		</div>
		<div id="head-text">
			<h3>${club.title}</h3>
			<h6>${club.content}</h6>
		</div>
	</div>
	<div class="badge-div">
		<c:set var="item" value="${fn:split(club.interest,',')}"/>
		<c:forEach items="${item}" var="interest" varStatus="vs">
			<span class="badge badge-pill myBadge">#${interest}</span>	
		</c:forEach>
	</div>
	
	<%-- 기본정보 --%>
	<div id="info-div">
		<div class="divs-head">
			<strong>기본 정보</strong>
			<span id="heart-span">🧡</span>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-calendar-days"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">📆 모집 기간</label>
			</div>
			<div>
				<span>${club.recruitStart} ~ ${club.recruitEnd}</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-calendar-days"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">📅 북클럽 기간</label>
			</div>
			<div>
				<span>${club.clubStart} ~ ${club.clubEnd}</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-user"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">🙍‍♀️ 최소 인원</label>
			</div>
			<div>
				<span>${club.minimumNop}명</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-user-group"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">‍‍👨‍👩‍👦‍👦 최대 인원</label>
			</div>
			<div>
				<span>${club.maximumNop}명</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-sack-dollar"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">💰 디파짓</label>
			</div>
			<div>
				<fmt:formatNumber value="${club.deposit}" pattern="#,###" />
				<i class="fa-solid fa-won-sign"></i>
			</div>
		</div>
	</div>
	<%-- 기본정보 끝 --%>
	
	<%-- 읽는 책 --%>
	<div id="book-div">
		<div class="divs-head">
			<strong>읽는 책</strong>
			<span id="heart-span">🧡</span>
			<span id="mini-info">북클럽에서 ${club.bookList.size()}권의 책을 읽어요.</span>
		</div>	
		<div id="book-imgs">
			<c:forEach items="${club.bookList}" var="book" varStatus="vs">
				<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}" value="${book.itemId}" onclick="bookEnroll(this);">
				
			</c:forEach>
		</div>
	</div>
	<%-- 읽는 책 끝 --%>
	
	

	<%-- 미션 --%>
	<div>
		<div id="mission-head">
			<strong>미션</strong>
			<span id="heart-span">🧡</span>
			<span id="mini-info">미션을 수행하고 포인트를 받으세요!</span>
		</div>	
		<div id="mission-div">
			
			<c:forEach items="${club.bookList}" var="book" varStatus="vs">
				<div class="mCard" data-no="${book.itemId}" onclick="openDetailMission(this);">
					<div class='m-img-div'>
						<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}" value="${book.itemId}" onclick="bookEnroll(this);">								
					</div>
					<div class="m-text-div">
						<table>
							<tbody>
								<tr id="bookMission${book.itemId}">
									<td></td>
								</tr>
								
							</tbody>
						</table>
					</div>
				</div>								
			</c:forEach>
			
		</div>
	
	</div>
	<%-- 미션 끝 --%>
	
	<c:forEach items="${club.missionList}" var="mission">
		${mission.title}
	</c:forEach>
	
	
	<br />
	
	<%-- 미션 모달 --%>
	<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      ...
	    </div>
	  </div>
	</div>
	<%-- 미션 모달 끝 --%>

	

		${club}
</section>

<script>


const bookEnroll = (e) => {
	const isbn13 = $(e).attr('value');
	location.href = "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13;
};


/********** 미션 디테일 모달 열어 ***************/
window.addEventListener('load', (e) => {
	document.querySelectorAll(".mCard").forEach((mission) => {
		mission.addEventListener('click', (e) => {
			console.log(e);
		});
	});



	
	
	
});



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>