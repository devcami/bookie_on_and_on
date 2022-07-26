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
<section id="content">

	<div id="menu">
		<h1>북클럽리스트</h1>
		<div id="menu-left">
			<select id="searchType" name="searchType" class="form-control d-inline form-select">
		      <option ${param.searchType eq "newList"? 'selected' : ''} value="newList">최신순</option>
		      <option ${param.searchType eq "oldList"? 'selected' : ''} value="oldList">마감순</option>
		    </select>
			<%-- <sec:authorize access="hasRole('ROLE_ADMIN')"> --%>
			    <button 
			    	id="btn-enroll"
			    	class="btn btn-sm" 
			    	onclick="location.href='${pageContext.request.contextPath}/club/enrollClub.do';">북클럽 등록</button>	    	
			<%-- </sec:authorize> --%>
			<%-- <sec:authorize access="hasRole('ROLE_USER')"> 
			    <button 
			    	id="btn-enroll"
			    	class="btn btn-sm" 
			    	onclick="location.href='${pageContext.request.contextPath}/club/enrollClub.do';">나의 북클럽</button>	    	
			< </sec:authorize> --%>
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
					<div class="nop-div">
						<span class="fa-stack fa-lg" id='h-span'>
						  <i class="fa fa-heart fa-regular fa-stack-1x front" ></i>
						</span>
						<span class="fa-stack fa-lg" id='h-span'>
						  <i class="fa fa-bookmark fa-regular fa-stack-1x front"></i>
						</span>
					</div>				
				</div>
				<div class="text-div">
					<div class='text-div-top'>
						<h5>${club.title}</h5>
						<div class='likes-div'>						
							<span>좋아요</span>&nbsp;
							<span class='likes'>${club.likesCnt}</span>
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
						<h6><span class="badge badge-pill badge-secondary alert-badge">모집마감</span></h6>
					</div>
					<div class="img-div">
						<c:forEach items="${club.bookList}" var="clubBook" varStatus="bs">
							<img src="${clubBook.imgSrc}" />												
						</c:forEach>
					</div>
					<div class="nop-div" style="visibility: hidden;">
						<span class="fa-stack fa-lg" id='h-span'>
						  <i class="fa fa-heart fa-regular fa-stack-1x front" ></i>
						</span>
						<span class="fa-stack fa-lg" id='h-span'>
						  <i class="fa fa-bookmark fa-regular fa-stack-1x front"></i>
						</span>
					</div>				
				</div>
				<div class="text-div">
					<div class='text-div-top'>
						<h5>${club.title}</h5>
						<div class='likes-div'>						
							<span>좋아요</span>&nbsp;
							<span class='likes'>${club.likesCnt}</span>
							<span>개</span>					
						</div>
					</div>
						<span class="text-status">모집마감</span>			
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
	// hello-spring boardList.jsp에서 가져와
	window.addEventListener('load', (e) => {
		document.querySelectorAll(".bookCard").forEach((card) => {
			card.addEventListener('click', (e) => {
				console.log('디브실행');
				const target = e.target;
				const currentCard = $(target).parents('.bookCard');
				const clubNo = $(currentCard).attr('data-no');
				
				location.href = '${pageContext.request.contextPath}/club/clubAnn.do?clubNo=' + clubNo;
				
				
			});	
		})
		
		
	})

	window.addEventListener('load', (e) => {
		document.querySelectorAll(".fa-heart").forEach((heart) => {
			heart.addEventListener('click', (e) => {
				
				// 부모한테 이벤트 전파하지마셈
				e.stopPropagation(); 
				
				// 클릭할때마다 상태왔다갔다
				changeIcon(e.target, 'heart');
			});	
		});	
	});
	
	window.addEventListener('load', (e) => {
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
		
		const iHeart = `<i class="fa fa-heart fa-solid fa-stack-1x h-behind"></i>`;
		const iBookMark = `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind"></i>`;
		
		
		if(cnt==1) {
			if(shape == 'heart'){
				icon.parentElement.insertAdjacentHTML('beforeend', iHeart);
			}
			else {
				icon.parentElement.insertAdjacentHTML('beforeend', iBookMark);
			}
		}
		else {
			icon.parentElement.removeChild(icon.parentElement.lastElementChild);
		}
		
		

	}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>