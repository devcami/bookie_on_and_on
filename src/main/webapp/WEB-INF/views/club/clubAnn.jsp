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
		<h1>북클럽 상세보기</h1>	
		${club}
	</div>
	<form name="clubEnrollFrm" >
		<div id="intro-div" class="divs">
		  <div class="form-group">
		  	<i class="fa-solid fa-tag"></i>
		    <label for="title">제목</label>
		    <input 
		    	type="text" 
		    	id="title"
		    	name="title"
		    	class="form-control col-form-label-sm basic-input"  
		    	aria-describedby="emailHelp" placeholder="제목을 입력하세요.">
		  </div>
		  <div class="form-group">
		  	<i class="fa-solid fa-pencil"></i>
		    <label for="content">한 줄 설명</label>
		    <textarea name="content" class="form-control" id="content" rows="2"></textarea>
		    <small id="emailHelp" class="form-text text-muted">북클럽에 대한 간단한 설명을 적어주세요!</small>
  		  </div>
		</div>
		<div id="info-div" class="divs">
			<p><strong>기본 정보</strong></p>
			<div class="date-div">
				<div class="label-div">
					<i class="fa-solid fa-calendar-days"></i>
					<label class="my-1" for="inlineFormCustomSelectPref">모집 기간</label>				
				</div>
				<div class="row">
					<div class="col">
				      <input type="date" name="recruitStart" id="recruitStart" class="form-control col-form-label-sm basic-input" placeholder="First name">
				    </div>
				    <span>~</span>
				    <div class="col" >
				      <input type="date" name="recruitEnd" id="recruitEnd" class="form-control col-form-label-sm basic-input" placeholder="Last name">
				    </div>
				</div>
			 </div>
			 <div class="date-div">
			 	<div class="label-div">
					<i class="fa-solid fa-calendar-days"></i>
					<label class="my-1" for="inlineFormCustomSelectPref">북클럽 기간</label>				
				</div>
				<div class="row">
					<div class="col">
				      <input type="date" name="clubStart" id="clubStart" class="form-control col-form-label-sm basic-input" >
				    </div>
				    <span>~</span>
				    <div class="col">
				      <input type="date" name="clubEnd" id="clubEnd" class="form-control col-form-label-sm basic-input" >
				    </div>
				</div>
			 </div>
			 <!-- 최대/최소 인원 -->
			 <div class="nop-div">
			 	<div class="label-div">
					<i class="fa-solid fa-user"></i>
					<label class="my-1" for="inlineFormCustomSelectPref">최소 인원</label>				
				</div>
		    	<div class="col nop-col">
			      <input 
			      	type="text"
			      	name="minimumNop" 
			      	class="form-control col-form-label-sm basic-input" 
			      	placeholder="최소 인원" dir="rtl">
			   	  <span>명</span>
			    </div>
			 </div>
			 <div class="nop-div">
			 	<div class="label-div">
					<i class="fa-solid fa-user-group"></i>
					<label class="my-1" for="inlineFormCustomSelectPref">최대 인원</label>				
				</div>
		    	<div class="col nop-col">
			      <input 
			      	type="text"
			      	name="maximumNop" 
			      	class="form-control col-form-label-sm basic-input" 
			      	placeholder="최대 인원" dir="rtl">
			      <span>명</span>
			    </div>
			 </div>
			 <!-- 디파짓 -->
			 <div class="nop-div">
			 	<div class="label-div">
					<i class="fa-solid fa-sack-dollar"></i>
					<label class="my-1" for="inlineFormCustomSelectPref">디파짓</label>				
				</div>
		    	<div class="col nop-col">
			      <input 
			      	type="text" 
			      	id="deposit" 
			      	name="deposit"
			      	class="form-control col-form-label-sm basic-input" 
			      	placeholder="금액을 입력하세요" dir="rtl">
			      <i class="fa-solid fa-won-sign"></i>
			    </div>
			 </div>
		</div>
		
		<!-- 읽는 책 -->
		<div id="book-div" class="divs">
			<p id="books-p"><strong>읽는 책</strong></p>
			<small id="books-small" class="form-text text-muted">등록 가능한 책은 최대 4권 입니다.</small>
			<p id="mLabel" style="font-size: medium; margin-top: 10px !important;">📋 기본정보를 먼저 입력해주세요!</p>
			
			<div id="bookWrapper">
			<!--
			 	여기에 책이 하나씩 추가됨.
			 -->
			</div>
			

			<div id="btn-add-book-container">
				<!-- Button trigger modal -->
					<button 
						type="button" id="btn-add-book" class="btn gap-2 col-12" 	
						data-toggle="modal" 
						data-target="#addBookModal"
						onclick="addBookTest();"
					>책 추가</button>
				<span style="display:none;" id="cPage">1</span>
			</div>
		</div>
		
<!-- 		<button 
			type="button" 
			id="btn-add-book"
			class="btn gap-2 col-12"
			onclick="addBookTest();"
			data-container="body" 
			data-toggle="popover" 
			data-placement="top" 
			data-content="📋 기본정보를 먼저 입력해주세요!">
		  책 추가
		</button>
 -->
		
<!-- 		<script>
		
		 $(function () {
		    $( '[data-toggle="popover"]' ).popover()
		  } );
		
		</script> -->
		

		<div id="mission-div" class="divs">
			<p><strong>미션</strong></p>
			<p id="mLabel" style="font-size: medium;">📚 책을 먼저 추가해주세요!</p>
			
			<div class="accordion" id="missionContainer">
			<!-- 
				여기에 미션이 하나씩 추가됨
			 -->	  
			</div>
		</div>

		<div id="bottom-menu">
			<button type="button" onclick="frmSubmit();" id="btn-enroll" class="mybtn last-btn">등 록</button>
			<button type="button" id="btn-cancel" class="mybtn last-btn">취 소</button>	    	
		</div>

		<div id="additionalInfo">
			<input type="hidden" name="finalDeposit" id="finalDeposit" />			
		</div>

		
	</form>
</section>
	
	<!-- 책 추가 Modal -->
		<div class="modal fade" id="addBookModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		    
		      <div class="modal-header book-modal-header">
		        <h3 class="modal-title" id="exampleModalCenterTitle">책 추가</h3>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>	
		      </div>
		      
		      <div id="modal-header-bottom">
			      <h6 class="modal-title" id="exampleModalCenterTitle">추가된 책</h6>
			      <!--
			      	여기에 책 작은 이미지가 한권씩 추가됨 
			       -->
			  </div>
		      
		      <div class="modal-body">		        
		        <div class="searchbar center-block">
<%-- 					<form 
						name="bookSearchFrm"
						action="${pageContext.request.contextPath}/club/bookSearch.do"
						method="GET" > --%>
					    <select id="searchType" name="searchType" class="col-2 form-control d-inline form-select">
					      <option value="All">전체</option>
					      <option value="Keyword">키워드</option>
					      <option value="Title">책제목</option>
					      <option value="Author">저자</option>
					      <option value="Publisher">출판사</option>
					    </select>
					    <%-- <input type="text" class="form-control col-md-8 d-inline mx-3" name="searchKeyword" id="searchKeyword" value="${param.searchKeyword ne '' ? param.searchKeyword : '' }" placeholder="검색어를 입력해주세요"> --%>
					    <input type="text" class="form-control col-md-8 d-inline mx-3" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력해주세요"> 
					    <input type="button" class="mybtn" id="btn-search" value="검색" onclick="findBook();">
					    <!-- <input type="submit" class="mybtn" id="btn-search" value="검색"> -->
<%-- 					</form> --%>
				</div>
		      </div> 
		      
		      <p id="bestSellerP">베스트 셀러</p>
		      <div id="books-div">
		      	
		    	<!-- 여기에 책이 한권씩 추가됨 -->  
		      </div>
		      
			
			<div id="btn-more-container">
				<button id="btn-more" class="btn gap-2" type="button">더보기</button>
				<span style="display:none;" id="cPage">5</span>
			  </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary cancel-btn book-btn" data-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary enroll-btn book-btn" onclick="enrollBook();" data-dismiss="modal" >등록</button>
		      </div>

		  </div>
		</div>
	</div>
	<!-- 책 추가 modal 끝 -->	
		
	
	<!-- 미션 추가 모달 -->
		<div class="modal fade" id="addMissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">미션 등록</h5>
		        <button type="button" class="close" onclick="hideMissionModal();" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="m-modal-body">
		          <div class="m-divs">
		            <label for="recipient-name" class="m-label">미션명</label>
		            <input type="text" class="m-input" id="mName">
		          </div>
     		      <div class="m-divs">
		            <label for="recipient-name" class="m-label">마감 기한</label>
		            &nbsp;<span id="clubPeriodLabel" style="color: #6c757d;">(북클럽 기한: 2022-08-02 ~ 2022-08-17)</span>
					<div class="m-divs-div">
			            <input type="date" class="m-input" id="mEndDate">		            
		            	<span> 까지 </span>					
					</div>

		          </div>
		          <div class="m-divs">
		            <label for="recipient-name" class="m-label">디파짓</label>
		            <div class="m-divs-div">
		            	<input type="text" class="m-input" id="mDeposit" placeholder="자동으로 계산됩니다!" readonly>	
		            	<i class="fa-solid fa-won-sign"></i>	            
		            </div>
		          </div>
		          <div class="m-divs">
		            <label for="message-text" class="m-label">내용</label>
		            <textarea class="form-control" id="mContent"></textarea>
		          </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="m-cancel-btn" class="btn btn-secondary cancel-btn" onclick="hideMissionModal();">취 소</button>
		        <button type="button" id="m-enroll-btn" class="btn btn-primary enroll-btn" onclick="enrollMission();">등 록</button>
		      </div>
		    </div>
		  </div>
		</div>

<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>