<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/enrollClub.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽등록" name="enrollClub"/>
</jsp:include>
<section id="content">
	<div id="top-menu">
		<h1>북클럽 등록</h1>	
		<button id="btn-enroll" class="">등 록</button>	    	
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
			<div class="book-table" onclick="bookEnroll(this);">
				<input type="hidden" name="isbn13" value="9788917238532">
				<table class="tbl">
					<tbody><tr>
						<td rowspan="4">
							<img src="https://image.aladin.co.kr/product/28415/31/covermini/891723853x_2.jpg" style="width:65px;">
						</td>
						<td colspan="5" class="book-title">ETS 토익 정기시험 기출문제집 1000 Vol. 3 Listening (리스닝) - TOEIC 기출문제 한국 독점출간 / 문제집 + 해설집 + ETS 성우 음원 MP3 파일 + APP 모바일 학습 / 2022 대비 최신판</td>
					</tr>
					<tr>
						<td class="book-author">ETS (엮은이)</td>
					</tr>
					<tr>
						<td colspan="2" class="book-p">출판사 : (주)YBM(와이비엠) 🧡 출판일 : 2021-12-13</td>
					</tr>
				</tbody></table>
			</div>
			<div id="btn-more-container">
				<button id="btn-more" class="btn gap-2 col-12" type="button">책 추가</button>
				<span style="display:none;" id="cPage">1</span>
			</div>
		</div>

		<div id="mission-div" class="divs">
			<p><strong>미션</strong></p>
		</div>
	</form:form>
</section>

<script>

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>