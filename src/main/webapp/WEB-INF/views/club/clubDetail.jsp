<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubDetail.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽디테일" name="title"/>
</jsp:include>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>

<section id="content">
	<div id="menuDiv">
		<ul>
			<li id="first-li" class="menu-li nowPage" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
			<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
			<li id="third-li" class="menu-li" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}">게시판</a></li>
			<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
			<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/chat/clubChat.do/${clubNo}">채팅</a></li>		
		</ul>
	</div>

	<div id="menu">
		<h1>📙북클럽 [${club.title}]</h1>
		<span>${club.content}</span>
		<div class="badge-div">
			<c:set var="item" value="${fn:split(club.interest,',')}"/>
			<c:forEach items="${item}" var="interest" varStatus="vs">
				<span class="badge badge-pill myBadge">#${interest}</span>	
			</c:forEach>
		</div>
	</div>
	
	<div id="dateDiv">
		<div class="dateSubDiv">
			<span>🕐&nbsp;북클럽이 시작한지</span>
			<span>D+${dStart}</span>			
		</div>
		<div class="dateSubDiv">
			<span>🕢&nbsp;북클럽 종료까지</span>
			<span>D-${dEnd}</span>
		</div>
	</div>
	
	<div id="infoDiv">
		<div id="bookDiv" class="divs">
			<p>읽을 책</p>
			<div id="bookImgDiv" class="mb-4">
				<c:forEach items="${club.bookList}" var="book">
					<img 
						src="${fn:replace(book.imgSrc, 'covermini', 'cover')}" 
						style="width: 100px; cursor: pointer;"
						data-item-id="${book.itemId}"
						onclick="bookEnroll(this);">				
				</c:forEach>
			</div>
		</div>
		<div id="memberDiv" class="divs">
			<p>활동 멤버</p>
			<div id="memberImgDiv" class="mb-4">
			<c:forEach items="${club.clubMember}" var="member">
				<img src="${pageContext.request.contextPath}/resources/upload/profile/${member.renamedFilename}" 
					 class="rounded-circle shadow-1-strong"
					 style="width: 80px;"/>
			</c:forEach>
			</div>
		</div>
		<div id="missionDiv" class="divs">
			<p>미션</p>
			<span>총 ${club.totalMission}개의 미션이 있으며, 각 미션당 걸린 포인트는 <fmt:formatNumber value="${club.deposit / club.totalMission}" pattern="#,###" />원 입니다.</span>
		</div>
	</div>
	
	<div id="missionDiv">
	</div>
	
	<div id="boardDiv">
		<div id="tableTop">
			<span>게시판 최신글</span>
			<div id="boardBtnDiv">
				<a href="${pageContext.request.contextPath}/club/clubBoardForm.do?memberId=${loginMember.username}&clubNo=${clubNo}">글쓰기</a>
				<a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}">더보기</a>			
			</div>	
		</div>
		
		<div id="tableDiv">
			<table>
				<tbody>
 					<c:forEach items="${club.clubBoard}" var="clubBoard">
						<tr data-chat-no="${clubBoard.chatNo}" onclick="showDetailClubBoard(this)">
							<td>${clubBoard.title}</td>
							<td>${clubBoard.nickname}</td>
							<td>
								<fmt:parseDate value="${clubBoard.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm" var="enrollDate"/>
				      			<fmt:formatDate value="${enrollDate}" pattern="yy/MM/dd"/>
				      		</td>	
						</tr>					
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="depositDiv">
		<span style="font-size: 30px; color:#fe9801;">디파짓</span>
		<p>이 북클럽에는 <b>총 <fmt:formatNumber value="${club.deposit}" pattern="#,###" />원</b>의 디파짓이 있습니다.</p>
		<p class="mt-2">목적</p>
		<span>무언가를 결심하기는 쉽지만 그것을 지속해 나가는 것은 쉽지 않습니다. 이 때문에 가장 간단하면서 효과적인 방법인 디파짓이 적용되어 있습니다. 디파짓은 미션마다 모두 동일한 금액이 책정되어 있습니다.</span>
		<p class="mt-2">환급 시기</p>
		<span>북클럽이 종료되는 시점에, 정산하여 캐시로 환급됩니다. 환급된 캐시는 언제든지 마이페이지 ><b>출금하기</b>를 통해 계좌로 환급 받으실 수 있습니다.</span>
	</div>
	
	<div id="bottomDiv">
		<h3>북클럽은 어떻게 다를까요?</h3>
		<span>책을 입체적으로 제대로 읽을 수 있도록 구성 되었어요.</span>
		<div id="cardDiv">
			<div id="left-card" class="subCard" onclick="$('#paceMakerModal').modal('show');">
				<div class="cardTop">
					<span>👩‍👩‍👦</span>
					<h4>함께 읽어나가는 페이스메이커</h4>
					<span>좋은 사람들과 함께 합니다</span>
				</div>
				<div class="cardBottom">
					<span>자세히보기</span>				
				</div>
			</div>
			<div id="right-card" class="subCard" onclick="$('#depositModal').modal('show');">
				<div class="cardTop">
					<span>‍💰</span>
					<h4>의지를 지속하는 가장 강력한 방법, 디파짓</h4>
					<span>북클럽 디파짓과 효과를 알아봅니다.</span>			
				</div>
				<div class="cardBottom">
					<span>자세히보기</span>				
				</div>
			</div>
		</div>	
	</div>
</section>


		<!-- 페이스메이커 모달 시작 -->
		<div class="modal fade" id="paceMakerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-scrollable" role="document">
		    <div class="modal-content">
		      <div class="modal-header book-modal-header">
		      	<div class="modal-head-text">
			        <h3 class="modal-title" id="exampleModalCenterTitle">👩‍👩‍👦함께 읽어나가는 페이스메이커</h3>
			        <span>좋은 사람들과 함께 합니다.</span>						      	
		      	</div>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>	
		      </div>
		      <div class="modal-body">		        
				<div class="subText" style="">
					<span>달리기 친구가 있으면 더 멀리 갈 수 있듯,</span>
					<span>북클럽에는 정해진 기간, 정해진 책을 목표로 함께 읽어나가는 멤버이자 페이스메이커가 있습니다.</span>
				</div>
				<div class="paragraphs">
					<span>페이스메이커 장점 ➀</span>
					<p>독서를 자극하는 페이스메이커</p>
					<span>페이스메이커는 북클럽 기간동안 책을 펼 수 있게 도와주고 서로 완독을 알리며 독서를 자극합니다.</span>
					<span>덕분에 아무리 두꺼운 책도 완독할 수 있죠.</span>
				</div>
				<div class="paragraphs">
					<span>페이스메이커 장점 ➁</span>
					<p>한 권의 책, N개의 관점</p>
					<span>읽으면서 딴생각하기도 하고, '나'라는 안경을 쓰고 본 책.</span>
					<span class="mb-3">함께 읽으면 다릅니다.</span>
					<span>&lt;투자&gt;북클럽을 예로 들어볼까요?</span>
					<span>&lt;보도 섀퍼의 돈&gt;을 읽고</span>
					<span>누군가는 돈을 바라보는 관점이 변하고</span>
					<span>누군가는 돈을 재무 목표를 설정하고</span>
					<span>누군가는 투자관을 세웁니다.</span>
					<span>어쩌면 책보다 더 흥미로운 멤버 생각에서 무심코 지나쳤던 부분을 붙잡고 책을 입체적으로 이해합니다.</span>
				</div>
				<div class="paragraphs">
					<span>페이스메이커 장점 ➂</span>
					<p>다르기에 즐겁습니다.</p>
					<span>다양한 배경의, 다른 페이스메이커가 있습니다.</span>
					<span>다른 배경, 직업, 견해를 가진 그들과 채팅으로, 혹은 게시판에서 대화를 나눠보세요.</span>
					<span>나와 페이스메이커의 다름은 독서 과정을 흥미롭게 만들고 생각을 확장시킵니다.</span>
				</div>
				<div class="subText" style="">
					<span>함께이기에 혼자 못하던 것을 할 수 있으며,</span>
					<span>함께이기에 더 많은 것을 배울 수 있고</span>
					<span>함께이기에 더 즐거울 수 있습니다.</span>
				</div>
		      </div> 
		  </div>
		</div>
	  </div>
	  <!-- 모달 끝 -->	
	  
	  <!-- 디파짓 모달 시작 -->
		<div class="modal fade modal-dialog-scrollable" id="depositModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header book-modal-header">
		      	<div class="modal-head-text">
			        <h3 class="modal-title" id="exampleModalCenterTitle">💰의지를 지속하는 가장 강력한 방법, 디파짓</h3>
			        <span>북클럽 디파짓과 효과를 알아봅시다.</span>						      	
		      	</div>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>	
		      </div>
		      <div class="modal-body">		        
				<div class="subText" style="">
					<span>의지를 지속하기 가장 강력하고 쉬운 방법은 행위에 금전/비금전적 인센티브를 거는 것입니다.</span>
					<span>인센티브 효과를 차용하여 리더스 북클럽에는 완독으로 이끄는 인센티브, 디파짓 제도가 있습니다.</span>
					<span class="mt-3">미션을 수행하면 환급받는 금액인 디파짓은 미션마다 동일하게 책정되어 있습니다.</span>
					<span>미션을 모두 수행하면 북클럽 등록시에 냈던 디파짓을 전부 돌려받을 수 있습니다.</span>
				</div>
				<div class="paragraphs">
					<span>[디파짓 운영방식]</span>
					<p>디파짓은 미션마다, 종료일에 자동환급.</p>
					<span>북클럽 참여 기간 동안 미션을 수행하면 북클럽 종료일에 디파짓이 환급됩니다.</span>
					<span>각 미션에는 데드라인이 있고 데드라인 전까지 미션 가이드에 맞게 수행하면 미션 완료입니다.</span>
					<span>북클럽 기간 동안 수행한미션 기록을 바탕으로 환급액이 결정되며 북클럽 종료일 다음날, 리더스 계정 내 포인트로 환급됩니다.</span>
					<span>환급된 캐시는 언제든지 마이페이지>나의 포인트 메뉴에서 계좌로 환급받을 수 있습니다.</span>
				</div>
				<div class="paragraphs">
					<span>[디파짓 기대효과]</span>
					<p>사피엔스도 10명 중 8명을 완독하게 만드는 디파짓.</p>
					<span>꾸준한 독서를 위해 필요한 것은 조금의 의지와 잘 설계된 환경, 2가지 입니다.</span>
					<span>책 읽고 싶은 마음만 가져오시면 됩니다.</span>
					<span>독서 동기부여 장치, 디파짓이 있습니다.</span>
					<span class="mt-3">디파짓 시스템 안에서 책을 읽으면, 636페이지에 달하는 &lt;사피엔스&gt;도 10명 중 8명 이상 완독합니다.</span>
				</div>
				<div class="subText" style="">
					<span>책을 읽고 싶은데 마음처럼 읽게 되지 않는다면,</span>
					<span>디파짓을 믿어보세요.</span>
				</div>
		      </div> 
		  </div>
		</div>
	  </div>
	  <!-- 모달 끝 -->	

<script>

$(".modal").on("click", function(e){
    posY = $(window).scrollTop();
    
    $("html, body").addClass("not_scroll");
/*     $(".nav").css("display","block");
    $(".cont").css("top",-posY); */
});

$(".modal").on("click", function(){
    $("html, body").removeClass("not_scroll");
/*     $(".nav").css("display","none"); */
/*     posY = $(window).scrollTop(posY); */
});

const bookEnroll = (e) => {
	const isbn13 = e.dataset.itemId;
	location.href = "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13;
};

const showDetailClubBoard = (e) => {
	const chatNo = e.dataset.chatNo;
	location.href = `${pageContext.request.contextPath}/club/clubBoardDetail.do?chatNo=` + chatNo;  
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>