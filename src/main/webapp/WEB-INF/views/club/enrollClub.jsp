<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/enrollClub.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽 등록" name="title"/>
</jsp:include>
<section id="content">
	<div id="top-menu">
		<h1>북클럽 등록</h1>	
		<!-- <button id="btn-enroll" class="mybtn">등 록</button> -->	  
	</div>
	<form:form name="clubEnrollFrm" method="POST">
		<div id="intro-div" class="divs">
		  <div class="form-group">
		  	<i class="fa-solid fa-tag"></i>
		    <label for="exampleInputEmail1">제목</label>
		    <input type="email" class="form-control col-form-label-sm basic-input" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="제목을 입력하세요.">
		  </div>
		  <div class="form-group">
		  	<i class="fa-solid fa-pencil"></i>
		    <label for="exampleFormControlTextarea1">한 줄 설명</label>
		    <textarea class="form-control" id="exampleFormControlTextarea1" rows="2"></textarea>
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
				      <input type="date" class="form-control col-form-label-sm basic-input" placeholder="First name">
				    </div>
				    <span>~</span>
				    <div class="col" >
				      <input type="date" class="form-control col-form-label-sm basic-input" placeholder="Last name">
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
				      <input type="date" class="form-control col-form-label-sm basic-input" >
				    </div>
				    <span>~</span>
				    <div class="col">
				      <input type="date" class="form-control col-form-label-sm basic-input" >
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
			      <input type="text" class="form-control col-form-label-sm basic-input" placeholder="최소 인원" dir="rtl">
			   	  <span>명</span>
			    </div>
			 </div>
			 <div class="nop-div">
			 	<div class="label-div">
					<i class="fa-solid fa-user-group"></i>
					<label class="my-1" for="inlineFormCustomSelectPref">최대 인원</label>				
				</div>
		    	<div class="col nop-col">
			      <input type="text" class="form-control col-form-label-sm basic-input" placeholder="최대 인원" dir="rtl">
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
			      <input type="text" class="form-control col-form-label-sm basic-input" placeholder="금액을 입력하세요" dir="rtl">
			      <i class="fa-solid fa-won-sign"></i>
			    </div>
			 </div>
		</div>
		
		<!-- 읽는 책 -->
		<div id="book-div" class="divs">
			<p id="books-p"><strong>읽는 책</strong></p>
			<small id="books-small" class="form-text text-muted">등록 가능한 책은 최대 4권 입니다.</small>
			
			<div class="book-container">
			
				<div class="book-table" onclick="bookEnroll(this);">
					<input type="hidden" name="isbn13" value="9788932474755">
					<table class="tbl">
						<tbody><tr>
							<td rowspan="4">
								<img src="https://image.aladin.co.kr/product/29820/33/covermini/8932474753_1.jpg" style="width:65px;">
							</td>
							<td colspan="5" class="book-title">헤어질 결심 각본</td>
						</tr>
						<tr>
							<td class="book-author">박찬욱, 정서경 (지은이)</td>
						</tr>
						<tr>
							<td colspan="2" class="book-p">출판사 : 을유문화사 🧡 출판일 : 2022-08-05</td>
						</tr>
					</tbody></table>
				</div>
				
				<div>
					<button class="btn deleteBook-btn" onclick="deleteBook();">삭제</button>
				</div>
			</div>

			<div class="book-container">
			
				<div class="book-table" onclick="bookEnroll(this);">
					<input type="hidden" name="isbn13" value="9791191056556">
					<table class="tbl">
						<tbody><tr>
							<td rowspan="4">
								<img src="https://image.aladin.co.kr/product/29358/89/covermini/k782837210_2.jpg" style="width:65px;">
							</td>
							<td colspan="5" class="book-title">미드나잇 라이브러리 (1주년 스페셜 에디션)</td>
						</tr>
						<tr>
							<td class="book-author">매트 헤이그 (지은이), 노진선 (옮긴이)</td>
						</tr>
						<tr>
							<td colspan="2" class="book-p">출판사 : 인플루엔셜(주) 🧡 출판일 : 2021-04-28</td>
						</tr>
					</tbody></table>
				</div>
				
				<div>
					<button class="btn deleteBook-btn" onclick="deleteBook();">삭제</button>
				</div>
			
			</div>

			<div id="btn-more-container">
				<!-- Button trigger modal -->
				<button 
					type="button" id="btn-more" class="btn gap-2 col-12" 	
					onclick="addBook();">
				  책 추가
				</button>
				<span style="display:none;" id="cPage">1</span>
			</div>
		</div>
		

		

		<div id="mission-div" class="divs">
			<p><strong>미션</strong></p>
			
			<div class="accordion" id="accordionExample">
			
				<div class="card">
				    <div class="card-header" id="headingOne">
				      <h5 class="mb-0">
				        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
				          Book #1 미션
				        </button>
				      </h5>
				    </div>
				    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
				      <div class="card-body">
				      	<table>
				      		<tbody>
				      			<tr>
				      				<td>1</td>
				      				<td>제목</td>
				      				<td>디파짓</td>
				      				<td>기한</td>
				      				<td>
				      					<button class="mybtn" onclick="deleteBook();">수정</button>
				      					<button class="mybtn delete-btn" onclick="deleteMission();">삭제</button>
				      				</td>
				      			</tr>
				      		</tbody>
				      	</table>
					    <button type="button" class="btn gap-1 col-1 mission-btn" data-toggle="modal" data-target="#addMissionModal" data-whatever="@mdo">
					    +
					    </button>
				      </div>
				    </div>
				  </div>
				  
				  <div class="card">
				    <div class="card-header" id="headingTwo">
				      <h5 class="mb-0">
				        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
				          Book #2 미션
				        </button>
				      </h5>
				    </div>
				    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
				      <div class="card-body">
						 book #2 미션
				      </div>
				    </div>
				  </div>
			</div>
		</div>

		<div id="bottom-menu">
			<button id="btn-enroll" class="mybtn last-btn">등 록</button>
			<button id="btn-cancel" class="mybtn last-btn">취 소</button>	    	
		</div>
		
	</form:form>
</section>

		<%-- <!-- 책 추가 Modal -->
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
			      <div class="img-btn">
				      <img src="https://image.aladin.co.kr/product/29358/89/covermini/k782837210_2.jpg" style="width:65px;">
				      <button type="button" class="close x-btn" >
				      	 <span aria-hidden="true">&times;</span>
				      </button>				      
			      </div>
			      <div class="img-btn">
				      <img src="https://image.aladin.co.kr/product/29820/33/covermini/8932474753_1.jpg" style="width:65px;">
				      <button type="button" class="close x-btn" >
				      	 <span aria-hidden="true">&times;</span>
				      </button>				      
			      </div>
			      <div class="img-btn">
				      <img src="https://image.aladin.co.kr/product/29358/89/covermini/k782837210_2.jpg" style="width:65px;">
				      <button type="button" class="close x-btn" >
				      	 <span aria-hidden="true">&times;</span>
				      </button>				      
			      </div>
			  </div>
		      
		      <div class="modal-body">		        
		        <div class="searchbar center-block">
					<form name="bookSearchFrm" >
					    <select id="searchType" name="searchType" class="col-2 form-control d-inline form-select">
					      <option value="Keyword">키워드</option>
					      <option value="Title">책제목</option>
					      <option value="Author">저자</option>
					      <option selected="" value="Publisher">출판사</option>
					    </select>
					    <input type="text" class="form-control col-md-8 d-inline mx-3" name="searchKeyword" id="searchKeyword" value="" placeholder="검색어를 입력해주세요">
					    <input type="submit" class="mybtn" id="btn-search" value="검색">
					</form>
				</div>
		      </div>
		      
		      <div class="modal-book-container">
				<div class="book-table" onclick="bookEnroll(this);">
					<input type="hidden" name="isbn13" value="9788932474755">
					<table class="tbl">
						<tbody><tr>
							<td rowspan="4">
								<img src="https://image.aladin.co.kr/product/29820/33/covermini/8932474753_1.jpg" style="width:65px;">
							</td>
							<td colspan="5" class="book-title">헤어질 결심 각본</td>
						</tr>
						<tr>
							<td class="book-author">박찬욱, 정서경 (지은이)</td>
						</tr>
						<tr>
							<td colspan="2" class="book-p">출판사 : 을유문화사 🧡 출판일 : 2022-08-05</td>
						</tr>
					</tbody></table>
				</div>
				<div>
					<button class="mybtn btn-plus" onclick="">+</button>
				</div>
			</div>
			
			<div class="modal-book-container">
				<div class="book-table" onclick="bookEnroll(this);">
					<input type="hidden" name="isbn13" value="9788932474755">
					<table class="tbl">
						<tbody><tr>
							<td rowspan="4">
								<img src="https://image.aladin.co.kr/product/29820/33/covermini/8932474753_1.jpg" style="width:65px;">
							</td>
							<td colspan="5" class="book-title">헤어질 결심 각본</td>
						</tr>
						<tr>
							<td class="book-author">박찬욱, 정서경 (지은이)</td>
						</tr>
						<tr>
							<td colspan="2" class="book-p">출판사 : 을유문화사 🧡 출판일 : 2022-08-05</td>
						</tr>
					</tbody></table>
				</div>
				
				<div>
					<button class="mybtn btn-plus" onclick="">+</button>
				</div>
			</div>

		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary cancel-btn book-btn" data-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary enroll-btn book-btn">등록</button>
		      </div>

		  </div>
		</div>
	</div>
	<!-- 책 추가 modal 끝 --> --%>
	
	
	<!-- 미션 추가 모달 -->
		<div class="modal fade" id="addMissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">미션 등록</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="m-modal-body">
		        <form>
		          <div class="m-divs">
		            <label for="recipient-name" class="m-label">미션명</label>
		            <input type="text" class="m-input" id="recipient-name">
		          </div>
     		      <div class="m-divs">
		            <label for="recipient-name" class="m-label">마감 기한</label>
					<div class="m-divs-div">
			            <input type="date" class="m-input" id="mEndDate">		            
		            	<span> 까지 </span>					
					</div>

		          </div>
		          <div class="m-divs">
		            <label for="recipient-name" class="m-label">디파짓</label>
		            <div class="m-divs-div">
		            	<input type="text" class="m-input" id="mdeposit" dir="rtl">	
		            	<i class="fa-solid fa-won-sign"></i>	            
		            </div>
		          </div>
		          <div class="m-divs">
		            <label for="message-text" class="m-label">내용</label>
		            <textarea class="form-control" id="m-content"></textarea>
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="m-cancel-btn" class="btn btn-secondary cancel-btn" data-dismiss="modal">취 소</button>
		        <button type="button" id="m-enroll-btn" class="btn btn-primary enroll-btn">등 록</button>
		      </div>
		    </div>
		  </div>
		</div>
	
	
	<form 
		name="addBookFrm"
		action="${pageContext.request.contextPath}/club/addBookPopup.do"
		method="GET">
		<input type="hidden" />
		<!-- <input type="hidden" name="currentBook" value="" /> -->
	</form>
	


<script>

const addBook = () => {
		const title = "addBookPopup";
		const spec = "width=700px";
		const popup = open("", title, spec);
		
		const frm = document.addBookFrm;
		frm.target = title; // 해당 팝업에서 폼을 제출 
		frm.submit();
	}




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>