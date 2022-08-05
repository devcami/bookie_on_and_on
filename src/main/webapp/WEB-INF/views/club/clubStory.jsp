<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubStory.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽스토리" name="title"/>
</jsp:include>
${clubNo}
${club}
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<section id="content">
	<div id="menuDiv">
		<ul>
			<li id="first-li" class="menu-li" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
			<li id="second-li" class="menu-li nowPage" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
			<li id="third-li" class="menu-li" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do/${clubNo}">게시판</a></li>
			<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
			<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/club/clubChat.do/${clubNo}">채팅..?</a></li>		
		</ul>
	</div>
	
	<%-- 대갈 --%>
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
				<!-- <i class="fa-solid fa-user-group"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">‍‍😊 모집된 인원</label>
			</div>
			<div>
				<span>${club.currentNop}명 / ${club.maximumNop}명</span>
				<c:if test="${club.maximumNop eq club.currentNop}">
					<span class="redText" style="margin-left: 10px;">!마감되었습니다!</span>				
				</c:if>
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
	<div id="mDiv">
		<div id="mission-head">
			<strong>미션</strong>
			<span id="heart-span">🧡</span>
			<span id="mini-info">미션을 수행하고 포인트를 받으세요!</span>
		</div>	
		<div id="mission-div">
			
			<c:forEach items="${club.bookList}" var="book" varStatus="vs">
				<div class="mCard" data-no="${book.itemId}" onclick="openDetailMission(this);">
					<div class='m-img-div' data-no="${vs.count}">
						<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}" value="${book.itemId}">								
					</div>
					<div class="m-text-div">
						<table>
							<tbody id="tbody${book.itemId}">
								<c:forEach items="${book.missionList}" var="mission" varStatus="vs">
									<tr id="bookMission${book.itemId}">
										<td>🌼${mission.title}</td>									
										<td><fmt:formatNumber value="${mission.point}" pattern="#,###" />원</td>									
								        <td>${mission.mendDate}</td>
									</tr>									         								
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>								
			</c:forEach>
			
		</div>
	
	</div>
	<%-- 미션 끝 --%>
	
</section>

	<%-- 미션 모달 --%>
	<div class="modal fade" id="missionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">📕월급쟁이 부자로 은퇴하라</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body" id="modalMissionWrapper">
	      <%--
	      	여기에 미션이 하나씩 추가됨
	       --%>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%-- 미션 모달 끝 --%>

<script>

/********** 미션 디테일 모달 열어 ***************/
const openDetailMission = (e) => {
	const container = document.querySelector('#modalMissionWrapper');	
	
	// 미션 모달 안에 내용 전부 비워
	while (container.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
			container.removeChild(
				container.firstChild
		  );
		}
	
	const itemId = e.dataset.no;
	const eNo = e.firstElementChild.dataset.no - 1;
	const tbodyId = "#tbody" + itemId;
	const mCnt = $(e).find(tbodyId).children().length;
	// console.log(eNo);
	// console.log(mCnt);
	
	const clubNo = '${club.clubNo}';	

	$.ajax({
		url: "${pageContext.request.contextPath}/club/getMission.do",
		data : {
			itemId : itemId,
			clubNo : clubNo
		},
		method : "GET",
		success(mList){
			// console.log(mList);
			
			const {missionList} = mList;
			// console.log(missionList);
			
			if(missionList.length == 0){
				// 미션없는 경우
			} 
			else {
				missionList.forEach((mission, index) => {
					const year = mission.mendDate.year;
					const month = mission.mendDate.monthValue;
					const day = mission.mendDate.dayOfMonth;
					const mEndDate = year + "." + month + "." + day;
					
					const div = `
				        <div id="m\${mission.missionNo}" class="modalDiv">
					    	<span class="missionNo">미션 \${index + 1}</span>
					    	<p class="mTitle">\${mission.title}</p>
					    	<span class="mDate mSpan">~ \${mEndDate}</span>
					    	<span class="mDeposit mSpan">\${mission.point}원</span>
					    	<span class="mContent">\${mission.content}</span>
				    	</div>`;	
				    
				    container.insertAdjacentHTML('beforeend', div);
				    	
				})
				
			}
			
		},
		error: console.log
	});
	
	$('#missionModal').modal('show');

}

/************** 상단 제목 바 **************/
let imgDiv = document.querySelector("#head");
let header = document.querySelector("#header-container")
let headerHeight = header.clientHeight;
let imgDivHeight = imgDiv.clientHeight;
const titlebar = document.querySelector("#title-header");
window.onscroll = function () {
	let windowTop = window.scrollY;
	if (windowTop >= imgDivHeight + headerHeight) {
		titlebar.classList.add("drop");
		titlebar.style.display = "inline";
	} 
	else {
		titlebar.classList.remove("drop");
		titlebar.style.display = "none";
	}
};




</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>