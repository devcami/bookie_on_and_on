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
${clubNo}
<section id="content">
	<div id="menuDiv">
		<ul>
			<li id="first-li" class="menu-li nowPage" style="background-color: #F76E11;"><a href="${pageContext.request.contextPath}/club/clubDetail.do/${clubNo}">메인페이지</a></li>
			<li id="second-li" class="menu-li" style="background-color: #FF9F45;"><a href="${pageContext.request.contextPath}/club/clubStory.do/${clubNo}">북클럽 스토리</a></li>
			<li id="third-li" class="menu-li" style="background-color: #FFBC80;"><a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}">게시판</a></li>
			<li id="fourth-li" class="menu-li" style="background-color: #FC4F4F;"><a href="${pageContext.request.contextPath}/club/clubMission.do/${clubNo}/${loginMember.username}">미션</a></li>
			<li id="fifth-li" class="menu-li" style="background-color: #D9534F;"><a href="${pageContext.request.contextPath}/club/clubChat.do/${clubNo}">채팅..?</a></li>		
		</ul>
	</div>

	<div id="menu">
		<h1>📙북클럽 [북클럽 제목 넣는 곳]</h1>
		<span>북클럽 설명 적는 곳입니다. 아직도 하루온종일 지루하기만 한 morning. 언제까지나 진전이 없는 너와의 거린. so far away. 아직도 예전의 나에 머무는지 그래 아마도 작은 너의 눈엔 아직 어린 아이의 못브으로 보이겠지 뭐 하루 이틀의 일은 아니니 근데 뭐 어떡해 내 앞에서 웃는게 신경쓰이는데. 그냥 가만히 있을 사오항으 아닌ㄴ데 아원ㄴ츄투비마마마인 날 생각하는</span>
		<div class="badge-div">
			<span class="badge badge-pill myBadge">#경제</span>	
			<span class="badge badge-pill myBadge">#자기계발</span>	
			<span class="badge badge-pill myBadge">#취미</span>	
		</div>
	</div>
	
	<div id="dateDiv">
		<div class="dateSubDiv">
			<span><i class="fa-solid fa-hourglass-start"></i>&nbsp;북클럽이 시작한지</span>
			<span>D+3</span>
		</div>
		<div class="dateSubDiv">
			<span><i class="fa-solid fa-hourglass-end"></i>&nbsp;북클럽 종료까지</span>
			<span>D-20</span>
		</div>
	</div>
	
	<div id="infoDiv">
		<div id="bookDiv" class="divs">
			<p>읽을 책</p>
			<div id="bookImgDiv">
				<img src="" alt="" />
				<img src="" alt="" />
				<img src="" alt="" />
			</div>
		</div>
		<div id="memberDiv" class="divs">
			<p>활동 멤버</p>
			<div id="memberImgDiv">
				<img src="" alt="" />
				<img src="" alt="" />
				<img src="" alt="" />
			</div>
		</div>
		<div id="missionDiv" class="divs">
			<p>미션</p>
			<span>총 8개의 미션 중 2개를 완료했습니다!</span>
		</div>
	</div>
	
	<div id="missionDiv">
	</div>
	
	<div id="boardDiv">
		<div id="tableTop">
			<span>게시판 최신글</span>
			<div id="boardBtnDiv">
				<a href="">글쓰기</a>
				<a href="${pageContext.request.contextPath}/club/clubBoard.do?clubNo=${clubNo}">더보기</a>			
			</div>	
		</div>
		
		<div id="tableDiv">
			<table>
				<tbody>
					<tr>
						<td>이거 책 내용 에바 아닌가요?</td>
						<td>강승윤닉네임변경</td>
						<td>22/08/09</td>	
					</tr>
					<tr>
						<td>이거 책 내용 에바 아닌가요?</td>
						<td>썬구리고양이</td>
						<td>22/08/09</td>	
					</tr>
					<tr>
						<td>이거 책 내용 에바 아닌가요?</td>
						<td>강승윤닉네임변경</td>
						<td>22/08/09</td>	
					</tr>
					<tr>
						<td>이거 책 내용 에바 아닌가요?</td>
						<td>썬구리고양이</td>
						<td>22/08/09</td>	
					</tr>
					<tr>
						<td>이거 책 내용 에바 아닌가요?</td>
						<td>썬구리고양이</td>
						<td>22/08/09</td>	
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="depositDiv">
		<span style="font-size: 30px; color:#fe9801;">디파짓</span>
		<p>이 북클럽에는 <b>총 10,000원</b>의 디파짓이 있습니다.</p>
		<p class="mt-2">목적</p>
		<span>무언가를 결심하기는 쉽지만 그것을 지속해 나가는 것은 쉽지 않습니다. 이 때문에 가장 간단하면서 효과적인 방법인 디파짓이 적용되어 있습니다. 디파짓은 미션마다 모두 동일한 금액이 책정되어 있습니다.</span>
		<p class="mt-2">환급 시기</p>
		<span>북클럽이 종료되는 시점에, 정산하여 캐시로 환급됩니다. 환급된 캐시는 언제든지 마이페이지 ><b>출금하기</b>를 통해 계좌로 환급 받으실 수 있습니다.</span>
	</div>
	
	<div id="bottomDiv">
		<h3>북클럽은 어떻게 다를까요?</h3>
		<span>책을 입체적으로 제대로 읽을 수 있도록 구성 되었어요.</span>
		<div id="cardDiv">
			<div id="left-card" class="subCard">
				<div class="cardTop">
					<span>👩‍👩‍👦</span>
					<h4>함께 읽어나가는 페이스메이커</h4>
					<span>좋은 사람들과 함께 합니다</span>
				</div>
				<div class="cardBottom">
					<span>자세히보기</span>				
				</div>
			</div>
			<div id="right-card" class="subCard">
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

<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>