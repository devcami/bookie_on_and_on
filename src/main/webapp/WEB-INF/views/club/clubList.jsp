<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽리스트" name="title"/>
</jsp:include>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<section id="content">
	<div id="menu">
		<h1>북클럽리스트</h1>
		<div id="menu-left">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
			    <button 
			    	id="btn-enroll"
			    	class="btn btn-sm mr-1" 
			    	onclick="location.href='${pageContext.request.contextPath}/club/enrollClub.do';">북클럽 등록</button>	 
			    <button 
			    	id="btn-enroll"
			    	class="btn btn-sm mr-1" 
			    	onclick="location.href='${pageContext.request.contextPath}/club/oldClubList.do';">마감된 북클럽</button>   	
			</sec:authorize>
			<sec:authorize access="isAuthenticated() && !hasRole('ADMIN')"> 
			    <button 
			    	id="btn-enroll"
			    	class="btn btn-sm mr-1" 
			    	onclick="location.href='${pageContext.request.contextPath}/mypage/myClubList.do';">나의 북클럽</button>
			</sec:authorize>
				   	
			<select id="sortType" name="sortType" class="form-control d-inline form-select ml-2">
		      <option ${sortType eq null ? 'selected' : ''} value="newList">최신순</option>
		      <option ${sortType eq "oldList" ? 'selected' : ''} value="oldList">마감순</option>
		    </select>

		</div>	
	</div>
	<div id="clubListDiv">
	<jsp:useBean id="today" class="java.util.Date" />
	<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' var="nowDate"/>
	<c:forEach items="${list}" var="club" varStatus="vs">
		<%-- 모집중인 경우 --%>
		<c:if test="${club.recruitEnd ge nowDate && club.maximumNop ne club.currentNop}">
			<div class="bookCard" id="card${club.clubNo}" data-no="${club.clubNo}">
				<div class="card-top" style="background-color: #ffa50021;">
					<div class='badge-div'>
						<h6><span class="badge badge-pill badge-light">모집중</span></h6>
						<c:if test="${club.maximumNop - 1 == currentNop}">
							<h6><span class="badge badge-pill badge-danger alert-badge">마감임박</span></h6>						
						</c:if>
					</div>
					<div class="img-div">
						<c:forEach items="${club.bookList}" var="clubBook" varStatus="bs">
							<img src="${clubBook.imgSrc}" />												
						</c:forEach>
					</div>
					<sec:authorize access="hasRole('ROLE_USER')">
						<div class="nop-div">
							<span class="fa-stack fa-lg" id='h-span'>
							  <i class="fa fa-heart fa-regular fa-stack-1x front" data-club-no="${club.clubNo}"></i>
							  <c:if test="${fn:contains(likesStr, club.clubNo)}">
							  	<i class="fa fa-heart fa-solid fa-stack-1x h-behind" data-club-no="${club.clubNo}"></i>
							  </c:if>
							</span>
							<span class="fa-stack fa-lg" id='h-span'>
							  <i class="fa fa-bookmark fa-regular fa-stack-1x front" data-club-no="${club.clubNo}"></i>
							  <c:if test="${fn:contains(wishStr, club.clubNo)}">
							  	<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind" data-club-no="${club.clubNo}"></i>
							  </c:if>
							</span>
						</div>
					 </sec:authorize>				
				</div>
				<div class="text-div">
					<div class='text-div-top'>
						<h5>${club.title}</h5>
						<div class='likes-div'>						
							<span>좋아요</span>&nbsp;
							<span class='likes' id="likesCnt${club.clubNo}">${club.likesCnt}</span>
							<span>개</span>					
						</div>
					</div>
						<span class="text-status">진행중</span>	
					<div class="date-div">
						<span class="text-date">${club.recruitStart}</span>
						<span class="text-date">~</span>
						<span class="text-date">${club.recruitEnd}</span>
					</div>
				</div>
			</div>
		</c:if>
		<%-- 모집중인 경우 끝 --%>
		
		<%-- 마감된 경우 --%>
		<c:if test="${club.recruitEnd lt nowDate || club.maximumNop eq club.currentNop}">
			<div class="bookCard" id="card${club.clubNo}" data-no="${club.clubNo}">
				<div class="card-top" style="background-color: #dee2e6;">
					<div class='badge-div'>
						<h6><span class="badge badge-pill badge-secondary alert-badge">인원마감</span></h6>
					</div>
					<div class="img-div">
						<c:forEach items="${club.bookList}" var="clubBook" varStatus="bs">
							<img src="${clubBook.imgSrc}" />												
						</c:forEach>
					</div>
					<sec:authorize access="hasRole('ROLE_USER')">
						<div class="nop-div" style="visibility: hidden;">
							<span class="fa-stack fa-lg" id='h-span'>
							  <i class="fa fa-heart fa-regular fa-stack-1x front" ></i>
							</span>
							<span class="fa-stack fa-lg" id='h-span'>
							  <i class="fa fa-bookmark fa-regular fa-stack-1x front"></i>
							</span>
						</div>									
					</sec:authorize>
				</div>
				<div class="text-div">
					<div class='text-div-top'>
						<h5>${club.title}</h5>
						<div class='likes-div'>						
							<span>좋아요</span>&nbsp;
							<span class='likes' id="likesCnt${club.clubNo}">${club.likesCnt}</span>
							<span>개</span>					
						</div>
					</div>
						<span class="text-status">인원마감</span>			
					<div class="date-div">
						<span class="text-date">${club.recruitStart}</span>
						<span class="text-date">~</span>
						<span class="text-date">${club.recruitEnd}</span>
					</div>
				</div>
			</div>
		</c:if>
		<%-- 마감된 경우 끝 --%>
			
	</c:forEach>			
	</div>
		<nav>${pagebar}</nav>

</section>

<script>
	
	
	document.querySelector("#sortType").addEventListener('change', (e) => {
		console.log(e.target.value);
		
		const selected = e.target.value;
		
		if(selected == 'oldList'){
			location.href = `${pageContext.request.contextPath}/club/clubList.do?sortType=\${selected}`;
		}
		else{
			location.href = "${pageContext.request.contextPath}/club/clubList.do";
		}
	});
	
	
	// hello-spring boardList.jsp에서 가져와


	window.addEventListener('load', (e) => {
		
		// click 이벤트 등록해 몽땅
		document.querySelectorAll(".bookCard").forEach((card) => {
			card.addEventListener('click', (e) => {
				console.log('디브실행');
				const target = e.target;
				const currentCard = $(target).parents('.bookCard');
				const clubNo = $(currentCard).attr('data-no');
				
				let memberId = ''; 
				if('${loginMember}'){
					memberId = "${loginMember.username}";
					location.href = '${pageContext.request.contextPath}/club/clubAnn.do?clubNo=' + clubNo + "&memberId=" + memberId;
				} else {
					location.href = '${pageContext.request.contextPath}/club/clubAnn.do?clubNo=' + clubNo;					
				}

				
				
				
			});	
		})		
		
		// 로드할때 하트 클릭 이벤트 줘
		document.querySelectorAll(".fa-heart").forEach((heart) => {
			heart.addEventListener('click', (e) => {
				
				// 부모한테 이벤트 전파하지마셈
				e.stopPropagation(); 
				
				// 클릭할때마다 상태왔다갔다
				changeIcon(e.target, 'heart');
			});	
		});	
		
		// 로드할때 북마크 클릭 이벤트 줘
		document.querySelectorAll(".fa-bookmark").forEach((heart) => {
			heart.addEventListener('click', (e) => {
				
				// 부모한테 이벤트 전파하지마셈
				e.stopPropagation(); 
				
				// 클릭할때마다 상태왔다갔다
				changeIcon(e.target, 'bookmark');
			});	
		});	
		
		
	});
	
	const changeIcon = (icon, shape) => {

		let cnt = icon.parentElement.childElementCount;
		
		let clubNo = icon.dataset.clubNo;
		
		const iHeart = `<i class="fa fa-heart fa-solid fa-stack-1x h-behind"></i>`;
		const iBookMark = `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind"></i>`;
		let memberId = "";
		
		if("${loginMember}"){
	         memberId = "${loginMember.username}";			
		}
		 
		console.log(memberId);
		
		// 비동기 처리할 때 security 땜시 token 보내야 함. 
		const csrfHeader = '${_csrf.headerName}';
		const csrfToken = '${_csrf.token}';
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		if(cnt==1){
			// 비었는데 눌렀는 경우 -> insert
			$.ajax({
				url : "${pageContext.request.contextPath}/club/insertLikesWish.do",
				data : {
					shape : shape,
					memberId : memberId,
					clubNo : clubNo
				},
				headers,
				method : "POST",
				success(data) {
					console.log('하트/찜 insert 성공');
					
					if(shape=='heart'){
						icon.parentElement.insertAdjacentHTML('beforeend', iHeart);
						
						// 좋아요 수 1 올려
						const likesCntId = "#likesCnt" + clubNo;
						const likesCnt = document.querySelector(likesCntId);
						likesCnt.innerHTML = Number(likesCnt.innerHTML) + 1;
					}
					else{
						icon.parentElement.insertAdjacentHTML('beforeend', iBookMark);						
					}
					
				},
				error: console.log
			});
			
		}
		else {
			// 채워졌었는데 해제한 경우 -> delete
			$.ajax({
				url : "${pageContext.request.contextPath}/club/deleteLikesWish.do",
				data : {
					shape : shape,
					memberId : memberId,
					clubNo : clubNo
				},
				headers,
				method : "POST",
				success(data) {
					
					icon.parentElement.removeChild(icon.parentElement.lastElementChild);
					
					if(shape=="heart"){
						// 좋아요 수 1 내려
						const likesCntId = "#likesCnt" + clubNo;
						const likesCnt = document.querySelector(likesCntId);
						likesCnt.innerHTML = Number(likesCnt.innerHTML) - 1;
					}
					console.log('하트/찜 delete 완료');
					
				},
				error: console.log
			});
		
		}
	
	}
	
	const myBookClubDetail = (e) => {
		console.log(e);
		console.log(e.dataset.clubNo);
		
		const clubNo = e.dataset.clubNo;
		
		
		// location.href = '${pageContext.request.contextPath}/club/myClubDetail.do' + "?clubNo=" + clubNo;
		location.href = `${pageContext.request.contextPath}/club/clubDetail.do/\${clubNo}`;
	}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>