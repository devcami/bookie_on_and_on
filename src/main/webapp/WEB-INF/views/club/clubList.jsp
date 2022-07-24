<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubList.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽리스트" name="clubList"/>
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
			
	
	
	
			<div class="bookCard">
				<div class="card-top">
					<div class='badge-div'>
						<h6><span class="badge badge-pill badge-light">모집중</span></h6>
						<h6><span class="badge badge-pill badge-danger alert-badge">마감임박</span></h6>
					</div>
					<div class="img-div">
						<img src="https://image.aladin.co.kr/product/29521/63/covermini/8901260719_3.jpg" style="widht: 50px;" />
						<img src="https://image.aladin.co.kr/product/29689/64/covermini/8965137705_1.jpg" style="widht: 50px;" />
						<img src="https://image.aladin.co.kr/product/29808/73/covermini/8954699804_2.jpg" style="widht: 50px;" />
						<img src="https://image.aladin.co.kr/product/29496/39/covermini/k202838509_2.jpg" style="widht: 50px;" />
					</div>
					<div class="nop-div">
						<span>인원)</span>&nbsp;
						<span class="current-nop">1</span>
						/
						<span class="max-nop">6</span>
					</div>				
				</div>
				<div class="text-div">
					<h5>주식은 처음입니다.</h5>
					<span class="text-status">진행중</span>
					<div class="date-div">
						<span class="text-date">2022-03-20</span>
						<span class="text-date">~</span>
						<span class="text-date">2022-04-17</span>
					</div>
				</div>
			</div>
			
			
			
			
			
			
			
			<div class="bookCard">
				<div class="card-top">
					<h6><span class="badge badge-pill badge-light">모집중</span></h6>
					<div class="img-div">
						<img src="https://image.aladin.co.kr/product/29521/63/covermini/8901260719_3.jpg" />
						<img src="https://image.aladin.co.kr/product/29689/64/covermini/8965137705_1.jpg" />
					
					</div>
					<div class="nop-div">
						<span>인원)</span>&nbsp;
						<span class="current-nop">1</span>
						/
						<span class="max-nop">6</span>
					</div>				
				</div>
				<div class="text-div">
				
				</div>
			</div>
			
			<div class="bookCard">
				<div class="card-top">
					<h6><span class="badge badge-pill badge-light">모집중</span></h6>
					<div class="img-div">
						<img src="https://image.aladin.co.kr/product/29521/63/covermini/8901260719_3.jpg" style="widht: 50px;" />
						
					</div>
					<div class="nop-div">
						<span>인원)</span>&nbsp;
						<span class="current-nop">1</span>
						/
						<span class="max-nop">6</span>
					</div>				
				</div>
				<div class="text-div">
				
				</div>
			</div>
			
		</div>
		
		<nav aria-label="...">
		  <ul class="pagination pagination-sm">
		    <li class="page-item disabled">
		      <a class="page-link" href="#" tabindex="-1">1</a>
		    </li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		  </ul>
		</nav>
</section>

<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>