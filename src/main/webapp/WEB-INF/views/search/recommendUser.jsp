<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recommendUser.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="유저 추천" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<section id="content">
	<div id="recommend-header" class="text-center mt-3 mb-3 p-3">
		<h1><span style="color:#FE9801;">${loginMember.nickname}</span>님과 취향이 쏙 닮은 분들을 추천해드려요 !</h1>
	</div>
	<div id="container-div">
		<c:if test="${empty interests}">
			<div id="none-interest" class="text-center">
				<h2>아직 관심사를 선택하지 않으셨네요 !</h2>
				<h2>내 프로필에서 좋아하는 분야를 설정해보세요. </h2>
				<button type="button" class="btn custom-btn btn-5" id="btn-mypage" onclick="location.href='${pageContext.request.contextPath}/mypage/mypage.do';">관심사 등록하러 가기</button>
			</div>
		</c:if>
		<c:if test="${not empty interests}">
		<c:forEach items="${interests}" var="interest" varStatus="vs">
		
		<div id="interest-div${interest}" class="mt-5">
			<div class="title-div">
				<h2>"<span style="color:#697C37;">${interest}</span>"에 관심이 있는 분들이에요</h2>
			</div>	
			<div id="people-container${interest}" class="article-div">
			</div>
		</div>		
		
		</c:forEach>
		</c:if>
	</div>
</section>

<script>

window.addEventListener('load', () => {
	const interest = '${member.interest}';
	const interests = interest.split(','); // 배열
	// 로드될 때 취미가 똑같은 멤버 리스트 가져와 (내아이디 빼고)
	<c:if test="${not empty member.interest}">	
		interests.forEach((i) => {
			$.ajax({
				url : '${pageContext.request.contextPath}/search/selectMemberListByInterest.do',
				method : 'get',
				data : {
					interest : i,
					memberId : '${loginMember.memberId}'
				},
				success(resp){
					// console.log(i);
					// 취미가 언어인 애들만 언어 div에 넣어
					resp.forEach((member) => {
						const {memberId, nickname, introduce, renamedFilename, interests}= member;
						const arr = interests.interests; //[언어, 취미]
						//console.log(memberId, nickname, introduce, renamedFilename, arr);
						
						const container = document.querySelector(`#people-container\${i}`);
						
						let div = `
						<div class="people-div">
							<div class="card shadow">
								<div class="card-body text-center">
									<div class="card-title">
										<div class="card-profile">`;
										
								if(renamedFilename != null){
									div += `<img src="${pageContext.request.contextPath}/resources/upload/profile/\${renamedFilename}" alt="프로필이미지"/>
										</div>`;
								}
								else{
									div += `<i class="fa-solid fa-user-large user-icon"></i>
										</div>`;
								}
							div += `<a href="${pageContext.request.contextPath}/mypage/mypage.do?memberId=\${memberId}" class="card-link ml-3">\${nickname}</a>
									</div>`;
							if(introduce != null){
								if(introduce.length > 20){
									div += `<p class="card-text">\${introduce.substr(0,20)}...</p>`;
								} else{
									div += `<p class="card-text">\${introduce}</p>`;
								}
							} else {
								div += `<p class="card-text"></p>`;
							}
							div += `<label>
								    	<input type="checkbox" name="follow-btn" class="follow-btn" onclick="followEvent(this);" data-follower-id="\${memberId}"`; //card-title end
						
							const followers = '${followers}'; // tmddbs,tester,..
							const followerArr = followers.split(','); // 배열
							followerArr.forEach((f) => {
								//console.log(f);
								if(memberId == f){
									div += `checked`;
								}
							});	   
							div += `/>
								    	<span class="mypickSpan">follow</span>
									</label>`; 
							
							div += `
								</div>
							</div>
						</div>
						`;
						
						container.insertAdjacentHTML('beforeend', div);
					});
				},
				error: console.log
				
			});
		});
	
	</c:if>
});

const followEvent = (e) => {
	console.log(e);
	const followingMemberId = e.dataset.followerId;
	console.log(followingMemberId);
	
	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송
	
	// 팔로우 되어있는 사람 취소
	if(!e.checked){
		$.ajax({
			url : '${pageContext.request.contextPath}/search/deleteFollower.do',
			method : 'post',
			headers,
			data : {
				memberId:'${loginMember.memberId}',
				followingMemberId
			},
			success(resp){
				console.log(resp);
				e.checked = false;
			},
			error: console.log
		});
	}
	// 팔로우 안되어있는 사람 등록
	else{
		$.ajax({
			url : '${pageContext.request.contextPath}/search/insertFollower.do',
			method : 'post',
			headers,
			data : {
				memberId:'${loginMember.memberId}',
				followingMemberId
			},
			success(resp){
				console.log(resp);
				e.checked = true;
			},
			error: console.log
		});
	}

}

	

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>