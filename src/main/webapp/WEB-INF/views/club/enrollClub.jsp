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
	<form:form name="clubEnrollFrm" >
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
		    <textarea name="content" class="form-control" id="clubDesc" rows="2"></textarea>
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
			 <div id="recruitDateMsg" style="margin-left: 150px; display: none;">
			 	<span style="color: red;">모집 마감일은 모집 시작일보다 나중이어야 합니다!</span>
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
			 <div id="dateMsg" style="margin-left: 150px; display: none;">
			 	<span style="color: red;">모집기간과 북클럽 기간을 확인해주세요!</span>
			 </div>
			 <div style="margin-left: 150px;">
			 	<span id="clubDateMsg" style="color: red;  display: none;">클럽시작일은 클럽 마감일보다 나중이어야 합니다!</span>
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
			      	id="minimumNop"
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
			      	id="maximumNop" 
			      	class="form-control col-form-label-sm basic-input" 
			      	placeholder="최대 인원" dir="rtl">
			      <span>명</span>
			    </div>
			 </div>
			 <div id="nopMsg" style="margin-left: 150px; display: none;">
			 	<span style="color: red;">최대인원은 최소인원보다 많아야 합니다!</span>
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
			 <div class="interest-div">
			 	<div class="label-div">
					<i class="fa-solid fa-sitemap"></i>
					<label class="my-1" for="inlineFormCustomSelectPref">분야</label>				
				</div>
				<div class="col interest-col">
				 	<input type="checkbox" name="interests" value="경제"/>
				 	<label for="경제">경제</label>	
				 	<input type="checkbox" name="interests" value="공학"/>
				 	<label for="공학">공학</label>	
				 	<input type="checkbox" name="interests" value="문학"/>
				 	<label for="문학">문학</label>	
				 	<input type="checkbox" name="interests" value="자기계발"/>
				 	<label for="자기계발">자기계발</label>	
				 	<input type="checkbox" name="interests" value="언어"/>
				 	<label for="언어">언어</label>	
				 	<input type="checkbox" name="interests" value="취미"/>
				 	<label for="취미">취미</label>	
				 	<input type="checkbox" name="interests" value="에세이"/>
				 	<label for="에세이">에세이</label>	
				 	<input type="checkbox" name="interests" value="예술"/>
				 	<label for="예술">예술</label>	
				 	<input type="checkbox" name="interests" value="교육"/>
				 	<label for="교육">교육</label>	
				 	<input type="checkbox" name="interests" value="인문학"/>
				 	<label for="인문학">인문학</label>	
				 	<input type="checkbox" name="interests" value="종교"/>
				 	<label for="종교">종교</label>	
				 	<input type="checkbox" name="interests" value="기타"/>
				 	<label for="기타">기타</label>		
				</div>
			 </div>
		</div>
		
		<!-- 읽는 책 -->
		<div id="book-div" class="divs">
			<p id="books-p"><strong>읽는 책</strong></p>
			<small id="books-small" class="form-text text-muted">등록 가능한 책은 최대 4권 입니다.</small>
			<p id="bLabel" style="font-size: medium; margin-top: 10px !important;">📋 기본정보를 먼저 입력해주세요!</p>
			
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
			<button type="button" onclick="cancelAll();" id="btn-cancel" class="mybtn last-btn">취 소</button>	    	
		</div>

		<div id="additionalInfo">
			<input type="hidden" name="finalDeposit" id="finalDeposit" />			
		</div>

		
	</form:form>
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
	
	
	<%-- <form 
		name="addBookFrm"
		action="${pageContext.request.contextPath}/club/addBookPopup.do"
		method="GET">
		<input type="hidden" />
		<!-- <input type="hidden" name="currentBook" value="" /> -->
	</form> --%>
	


<script>

window.onload = function(){
	document.getElementById('recruitStart').value = new Date().toISOString().substring(0, 10);
}

/************** 기본정보 유효성검사 ************/
$('#recruitEnd').change(() => {
  		const recruitStart = $('#recruitStart').val();
  		const recruitEnd = $('#recruitEnd').val();
  		const clubStart = $('#clubStart').val();
  		
  		if(recruitStart >= recruitEnd){
	  		$("#recruitDateMsg").css('display', '');
  		}
  		else {
	  		$("#recruitDateMsg").css('display', 'none');  			
  		}

  		console.log(clubStart);
  		
  		if(clubStart != '') {
	  		if(recruitEnd >= clubStart){
	  			$("#dateMsg").css('display', '');
			}
			else {
	  			$("#dateMsg").css('display', 'none');  			
			}  			
  		}
  		
  		
  	});
  	
$('#clubStart').change(() => {
		const recruitEnd = $('#recruitEnd').val();
		const clubStart = $('#clubStart').val();
		const clubEnd = $('#clubEnd').val();
		
		if(recruitEnd >= clubStart){
  			$("#dateMsg").css('display', '');
		}
		else {
  			$("#dateMsg").css('display', 'none');  			
		}
		
		if(clubEnd != ''){
			if(clubStart >= clubEnd){
	  			$("#clubDateMsg").css('display', '');			
			}
			else {
	  			$("#clubDateMsg").css('display', 'none');						
			}			
		}
		
	});

$('#clubEnd').change(() => {
	const clubStart = $('#clubStart').val();
	const clubEnd = $('#clubEnd').val();
	
	console.log(clubEnd - clubStart);
	
	if(clubStart >= clubEnd){
			$("#clubDateMsg").css('display', '');			
	}
	else {
			$("#clubDateMsg").css('display', 'none');						
	}
	
});


$('#maximumNop').keyup(() => {
	ckNop();
});
$('#minimumNop').keyup(() => {
	ckNop();
});

const ckNop = () => {
	const minimumNop = $('#minimumNop').val();
	const maximumNop = $('#maximumNop').val();
	
	console.log('minimumNop ', minimumNop);
	console.log('maximumNop ', maximumNop);
	
	if(minimumNop != '' && maximumNop != ''){
		if(minimumNop <= maximumNop) {
			$('#nopMsg').css('display', 'none');			
		}
		else {
			$('#nopMsg').css('display', '');
		}
	}
}

/***************모달테스트임************/
	
<%-- scroll 유지 테스트 --%>
//쿠키 생성 함수
function setCookie(cName, cValue, cDay){
	var expire = new Date();
	expire.setDate(expire.getDate() + cDay);
	cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
	if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	document.cookie = cookies;
}

//쿠키 가져오기 함수
function getCookie(cName) {
	cName = cName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cName);
	var cValue = '';
	if(start != -1){
		start += cName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length;
		cValue = cookieData.substring(start, end);
	}
	return unescape(cValue);
}

<%-- paging --%>
var maxResult = 20;
//var cPage = Number(document.querySelector("#cPage").innerText);
/* window.addEventListener('load', () => {
	const intY = getCookie("intY");
	const cPageVal = getCookie("cPageVal");
	// console.log(intY, cPageVal);
	document.querySelector("#cPage").innerText = cPageVal; 
	if(cPageVal > 1){
		maxResult = cPageVal * maxResult;
	}
	else if(cPageVal > 2){
		maxResult = 40;
	}
	if(intY != 0) {
	 	//쿠키값에 scroll 값이 저장되었을 경우
		console.log("scrollTo : " + intY);
		getPage(1, maxResult);
		setTimeout(() => window.scrollTo(0, intY), 2000);
	} else {
	 	//scroll 값이 없는 경우
		getPage(1, maxResult);
	 	setTimeout(() => window.scrollTo(0, 0), 1000)
	}
}); */



/********************************/

const makeEmpty = () => {
	 $("#searchType").val("All").prop("selected", true);
	 $('#searchKeyword').val('');
	 $('#bestSellerP').text('베스트 셀러'); 
	 const container = document.querySelector("#books-div");
	 container.innerHTML = "";
}
 
const addBookTest = () => {
	
		makeEmpty();
		
		const intY = getCookie("intY");
		const cPageVal = getCookie("cPageVal");
		// console.log(intY, cPageVal);
		document.querySelector("#cPage").innerText = cPageVal; 
		if(cPageVal > 1){
			maxResult = cPageVal * maxResult;
		}
		else if(cPageVal > 2){
			maxResult = 40;
		}
		if(intY != 0) {
		 	//쿠키값에 scroll 값이 저장되었을 경우
			console.log("scrollTo : " + intY);
			getPage(1, maxResult);
			setTimeout(() => window.scrollTo(0, intY), 2000);
		} else {
		 	//scroll 값이 없는 경우
			getPage(1, maxResult);
		 	setTimeout(() => window.scrollTo(0, 0), 1000)
		}
	} 
	
	$('#addBookModal').on('shown.bs.modal', function (e) {
		// 모달 열릴때 이벤트
	});
	
document.getElementById('searchType').addEventListener('change', (e) => {
	 const selectedOption = $("#searchType option:selected").val();
	 if(selectedOption == 'All'){
		 
		 makeEmpty();
		 
		 getPage(1, 20);	
	 }
});


const findBook = () => {
	const query = document.querySelector("#searchKeyword").value;
	const queryType = document.querySelector("#searchType").value;
	
	const searchKeyword = document.querySelector("#searchKeyword");
	// 숫자, 영문, 한글로 2자 이상
	if(!/^[0-9a-zA-Z가-힣]{2,}$/.test(searchKeyword.value)){
		alert("검색어를 2자 이상 입력해주세요.");
		return;
	}
	
	if(queryType == '' && query != ''){
		alert('검색 조건을 선택해주세요.');
		return;
	}
	
	$('#bestSellerP').text('검색 결과'); 
	const searchApi = 'https://cors-anywhere.herokuapp.com/';  // 이것이 cors해결법이야
	const container = document.querySelector("#books-div");

	container.innerHTML = "";
	
	getPage(1, 20);	
}

/*******************************/

window.addEventListener('scroll', (e) => {
	const nowPage = document.querySelector("#cPage").innerText;
	let intY = window.scrollY;	
	setCookie("intY", intY, "1");
	//console.log(nowPage);
	setCookie("cPageVal", nowPage, "1");
});

document.querySelector("#btn-more").onclick = () => {
	let c = Number(document.querySelector("#cPage").innerText);
	document.querySelector("#cPage").innerText = c + 1;
	maxResult = 20;
	getPage(c + 1, maxResult);
};



<%-- 검색 제출 시 유효성 검사 & 비동기--%>
/* document.bookSearchFrm.addEventListener('submit', (e) => {
	const searchKeyword = document.querySelector("#searchKeyword");
	// 숫자, 영문, 한글로 2자 이상
	if(!/^[0-9a-zA-Z가-힣]{2,}$/.test(searchKeyword.value)){
		alert("검색어를 2자 이상 입력해주세요.");
		e.preventDefault();
		return;
	}
	
	 
	const searchApi = 'https://cors-anywhere.herokuapp.com/';  // 이것이 cors해결법이야
	const container = document.querySelector("#book-container");
	const query = document.bookSearchFrm.searchKeyword.value;  // 검색어
	const queryType = document.bookSearchFrm.searchType.value; // 검색어 종류
	container.innerHTML = "";
	
	getPage(1, 20);	
	

}); */


/***************************여기 getPage()자리 **********************************/
 
 
 const getPage = (cPage, maxResult) => {
	console.log(cPage, maxResult);
	// const searchApi = 'https://cors-anywhere.herokuapp.com/';
	const container = document.querySelector("#books-div");
	// console.log('${param.searchType}', '${param.searchKeyword}');
	const query = document.querySelector("#searchKeyword").value;
    const queryType = document.querySelector("#searchType").value;

	
	let book = {
			ttbkey : 'ttbiaj96820130001',
			QueryType : 'Bestseller',
			SearchTarget: 'Book',
			Start : cPage,
			MaxResults : maxResult,
			Output : 'js',
			Cover : 'mini',
			Version : '20131101',
			Query : ''
	};
	
	 if('${param.searchType}' != ''){
		 book.QueryType = '${param.searchType}';
	 }
     if('${param.searchKeyword}' != ''){
        book.Query = '${param.searchKeyword}';
     }
     
     
     if(queryType == 'All'){
        console.log('처음로딩');
     } else{
        console.log("검색 후 로딩");
        book.QueryType = queryType;
     }
     if(query != ''){
        book.Query = query;
     }

	
	$.ajax({
		url : `${pageContext.request.contextPath}/search/selectBookList.do`,
		data : book,
		contentType : "application/json; charset=utf-8",
		success(resp){
			console.log(resp);
            const {item} = resp;
            const divNon = `
               <div>
                  <p style="text-align:center"> 검색된 결과가 없습니다. </p>
               </div>`
           
            if(item.length == 0){
               container.insertAdjacentHTML('beforeend', divNon);
               const btn = document.querySelector("#btn-more")
               btn.disabled = "disabled";
               btn.style.cursor = "not-allowed";
            }
              
            item.forEach((book) => {
               const {isbn13, title, author, publisher, pubDate, cover} = book;
               const btnDivId = "btnDiv" + isbn13;
               const div = `
                  <div class="modal-book-container" id="book\${isbn13}">
                  <div class="book-table">
                     <input type="hidden" name="isbn13" value=\${isbn13} />
                     <input type="hidden" name="bookImg" value="\${cover}"/>
                     <table class="tbl">
                        <tbody><tr>
                           <td rowspan="4">
                              <img src=\${cover} style="width:65px;">
                           </td>
                           <td colspan="5" class="book-title">\${title}</td>
                        </tr>
                        <tr>
                           <td class="book-author">\${author}</td>
                        </tr>
                        <tr>
                           <td colspan="2" class="book-p">출판사 : \${publisher} 🧡 출판일 : \${pubDate}</td>
                        </tr>
                     </tbody></table>
                  </div>
                  <div id=\${btnDivId}>
                     <button type="button" class="mybtn btn-plus" onclick="modalAddBook(this);" value=\${isbn13}>+</button>
                     <input type="hidden" name="img" value=\${cover} />
                  </div>
               </div>
               `;
               container.insertAdjacentHTML('beforeend', div);
               ckSelectedBook(isbn13, btnDivId);
               
            });
            
         },
		error : console.log
	});
};
 
 

/******************************************************************************/

const selectedBooks = [];  
const booksDiv = new Object();

const modalAddBook = (e) => {
// 	console.log("선택된 책 isbn", e.value);
//	console.log(e.nextElementSibling.value); 
//	console.log(container.childElementCount);
	const container = document.querySelector("#modal-header-bottom");
	const isbn = e.value;
	
	const bookDiv = e.parentElement.parentElement;
	
	
	if(container.childElementCount > 4){
		
		
		/* alert('등록 가능한 책은 최대 4권입니다.'); */
		
		Swal.fire({
	      icon: 'warning',
	      title: '등록 가능한 책은 최대 4권입니다.',
	    });
		
		return;
	}
	
	// 배열에 추가
	// console.log("추가 전 ", booksDiv);
	selectedBooks.push(isbn);
	
	booksDiv[isbn] = bookDiv;
	
	e.classList.add('noclick');
	e.disabled = 'disabled';
	
	const imgSrc = e.nextElementSibling.value
	const itemId = "smallImg" + isbn;
	
	const div = `
		<div class="img-btn" id=\${itemId}>
	      <img src=\${e.nextElementSibling.value} style="width:65px;">
	      <button type="button" class="close x-btn" value=\${isbn} onclick = "modalDeleteBook(this);" >
	      	 <span aria-hidden="true">&times;</span>
	      </button>				      
    	</div>
	`;
	
	container.insertAdjacentHTML('beforeend', div);
	
	// console.log("추가후", booksDiv);
}

const delBook = (isbn) => {
	for(let i = 0; i < selectedBooks.length; i++) {
		  if(selectedBooks[i] === isbn)  {
		    selectedBooks.splice(i, 1);
		    i--;
		  }
		}
	delete booksDiv[isbn];
}

const modalDeleteBook = (e) => {
	
//	console.log("삭제전",booksDiv);
//	console.log("삭제전",selectedBooks);
	
	const isbn = e.value;
	const container = document.querySelector("#modal-header-bottom");
	container.removeChild(e.parentElement);

	const btnId = "btnDiv" + isbn;
	const div = document.getElementById(btnId);
	div.firstElementChild.classList.remove('noclick');
	div.firstElementChild.disabled = '';
	
	
	const divId = "#book" + isbn;
	const bDiv = $('#bookWrapper').children(divId);
	
	// 바깥 책 있으면 삭제해라
	if(bDiv.length == 1){
		$(divId).remove();
	}
	
	const mdivId = "#m" + isbn;
	const mDiv = $('#missionContainer').children(mdivId);
	
	// 바깥 미션 있으면 삭제해라
	if(mDiv.length == 1){
		$(mdivId).remove();
	}

	// 배열하고 객체에서 싹 지워
	delBook(isbn);
	
	
//	console.log("삭제후",booksDiv);
//	console.log("삭제후",selectedBooks);
	
};




const ckSelectedBook = (isbn, divId) => {
	
	for(let i = 0; i < selectedBooks.length; i++) {
		  if(selectedBooks[i] === isbn)  {
			  const divId = "btnDiv" + isbn;
			  const div = document.getElementById(divId);
			  div.firstElementChild.classList.add('noclick');
			  div.firstElementChild.disabled = 'disabled';
		  }
	}
}


$('#addBookModal').on('hide.bs.modal', function (e) {
/*     // 모달 닫길때 이벤트
    console.log(selectedBooks.length, '개');
   	
   	const msg = '총 ' + selectedBooks.length + '권의 책이 선택되었습니다. 등록하시겠습니까?';
   	const yn = confirm(msg);
   	
   	if(yn){
   		console.log('예');
	   	
   	}
   	else {
   		selectedBooks.forEach((book) => {

   			
   			console.log(book);
   			
 	   		// 모달 안 작은 이미지 삭제
	   		$(`#smallImg\${isbn}`).remove();
	
	   		// 객체와 배열에서 모두 삭제
	   		delBook(isbn); 
   		});
   	} */ 
   	
	enrollBook();
   	
});


const hideAddBookBtn = () => {
	const btn = document.querySelector("#btn-add-book")
	btn.disabled = "disabled";
	btn.classList.add('noclick');
	btn.style.color = "white";
}

const showAddBookBtn = () => {
	const btn = document.querySelector("#btn-add-book")
	btn.disabled = "";
	btn.classList.remove('noclick');
	btn.style.color = "#FE9801";
}


 
const enrollBook = () => {
	
	if(selectedBooks.length == 4){
		hideAddBookBtn();
	}
		
	const container = document.getElementById('bookWrapper');
	const missionContainer = document.getElementById('missionContainer');
	const btnDiv = `
		<div>
			<button type="button" class="btn deleteBook-btn" onclick="deleteBook(this);">삭제</button>
		</div>
	`;
	
	const divs = Object.values(booksDiv);
	console.log(divs);
	divs.forEach((div) => {
		const isbn = $(div).find('input')[0].defaultValue;

		div.classList.remove('modal-book-container')
		div.classList.add('book-container')
		div.firstElementChild.setAttribute("onClick", "");
		div.lastElementChild.remove();
		div.insertAdjacentHTML('beforeend', btnDiv);
		$(div).find('button').val(isbn);
		
		
		container.appendChild(div); 
		
		
		const bookName = $(div).find('.book-title')[0].innerText;
		const divId = "m" + isbn;
		
		if(document.getElementById(divId) == null) {
			document.querySelector('#mLabel').style.display = 'none';
			
			// 기본정보 다 입력했는지 확인후
			document.querySelector('#bLabel').style.display = 'none';
			
			const headId = "head" + isbn;
			const collapseId = "col" + isbn;
			
			const missionDiv = `
				<div class="card" id="\${divId}">
			    <div class="card-header" id="\${headId}">
			      <h5 class="mb-0">
			        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#\${collapseId}" aria-expanded="false" aria-controls="\${collapseId}">
			          Book <i><\${bookName}></i> 미션
			        </button>
			      </h5>
			    </div>
			    <div id="\${collapseId}" class="collapse" aria-labelledby="\${headId}" data-parent="#missionContainer">
			      <div class="card-body">
			      	<table>
			      		<tbody id="missionWrapper\${isbn}">
				      		<tr id="addMissionLabel">
		      					<td colspan="4" style="margin-bottom: 17px;">🧡책에 대한 미션을 등록해주세요!</td>
		      				</tr>	
			      		</tbody>
			      	</table>
				    <button 
				    	type="button" 
				    	value = "\${isbn}"
				    	id = "plus\${isbn}"  
				    	class="btn gap-1 col-1 mission-btn" 
				    	onclick="plusMission(this);"
				    	data-toggle="modal" 
						data-target="#addMissionModal" 
						data-whatever="@mdo"
				    	>
				    +
				    </button>
			      </div>
			    </div>
			  </div>`;
			
			
			missionContainer.insertAdjacentHTML('beforeend', missionDiv);
		}
	
	});
}

const deleteBook = (e) => {
	console.log(e.value);
	const isbn = e.value;

	// 객체와 배열에서 모두 삭제
	delBook(isbn);
	
	// 읽는 책 div 삭제
	$(`#book\${isbn}`).remove();
	
	// 모달 안 작은 이미지 삭제
	$(`#smallImg\${isbn}`).remove();
	
	// 읽는 책 4개 미만인지 확인
	const bookWrapper = document.querySelector('#bookWrapper');
	if(bookWrapper.childElementCount < 4){
		showAddBookBtn();
	}
	
	// 미션 삭제
	$(`#m\${isbn}`).remove();
	
	// 미션 1개 이상인지 확인
	const missionContainer = document.querySelector('#missionContainer');
	if(missionContainer.childElementCount == 0){
		document.querySelector('#mLabel').style.display = '';
	}
	
	
}

/****************** 미션 등록 / 삭제 ********************/
 
// 미션 모달 내용 비우기
const missionModalEmpty = () => {
	$('#mName').val('');
	$('#mEndDate').val('');
	$('#mDeposit').val('');
	$('#mContent').val('');
}

//플러스 버튼 누르면 -> 모달열림
let status = '';
const plusMission = (e) => {
	
	status = "enroll";
	
	// (북클럽 기한: 2022-08-02 ~ 2022-08-17)
	const clubStart = $('#clubStart').val();
	const clubEnd = $('#clubEnd').val();
	const isbn = e.value;   	
	
	const period = `(북클럽 기한: \${clubStart} ~ \${clubEnd})`; 
	
	$('#addMissionModal').attr('value', isbn);
	$('#clubPeriodLabel').text(period);

	
	/* 
	북클럽 기간 검사..일단 미뤄둬..

	
	if(clubStart == '' || clubEnd ==''){
		alert('먼저 북클럽 기간을 입력해주세요.');
		notShowModal("#addMissionModal");
		return;
	}
	*/

	

}

const ckMissionModal = () => {
	const yn = confirm('취소하시겠습니까?');
		if(yn){   			
			
			// 내용도 모두 지우기
			missionModalEmpty();
			// return; 
			$('#addMissionModal').modal('hide');
			return;
		}
		else {
			console.log('계속 진행시켜.');
			return;
		}
}

const hideMissionModal = () => {
	
	// 내용이 모두 비워져있으면
	if(!$('#mName').val() && !$('#mEndDate').val() &&  !$('#mContent').val()) {
		$('#addMissionModal').modal('hide');
		return;
		
   	}
	
   	// 내용 하나라도 채워져있으면
   	if(!$('#mName').val() || !$('#mEndDate').val()  || !$('#mContent').val()) {
   		
   		ckMissionModal();
   	}
   	
   	
   	if($('#mName').val() && $('#mEndDate').val() && $('#mContent').val()) {
   		
   		ckMissionModal();
   		
   	}
   	
}


let cnt = 1;
let missionCnt = 0;

// 미션 모달에서 등록 버튼 누르면 
const enrollMission = () => {
	const clubStart = $('#clubStart').val();
	const clubEnd = $('#clubEnd').val();
	let mEndDate = $('#mEndDate').val();
	
	// 내용이 모두 채워져 있는지 유효성 검사
   	if(!$('#mName').val() || !$('#mEndDate').val() || !$('#mContent').val()) {
   		// alert('모든 칸을 입력해주세요');
   		Swal.fire({
  	      icon: 'warning',
  	      title: '모든 칸을 입력해주세요',
  	    });
   		
   		return;
   	}

	// 미션 날짜가 북클럽 기간 사이가 아닐때 유효성 검사
	if(!(mEndDate >= clubStart && mEndDate <= clubEnd)){
		
		// alert('북클럽 기간과 미션 기한을 확인해주세요.');
		
		Swal.fire({
  	      icon: 'warning',
  	      title: '모든 칸을 입력해주세요',
  	    });
		
		return;	
	}

	// 모든 칸이 입력됐으니까 변수 받아오고
	   	const mName = $('#mName').val();
		mEndDate = $('#mEndDate').val();
		let mContent = $('#mContent').val();

		mContent = mContent.replace(/\"/g, '&quot;');
		
		

	if(status == 'enroll'){

		missionCnt++;
		
		const mDeposit = changeDeposit();
		
		// 미션 탭에 tr 추가 
		const isbn = $('#addMissionModal').attr("value");
		const mtbody = document.querySelector(`#missionWrapper\${isbn}`);

		const mtr = `
			<tr class=="head-tr" id="mission\${cnt}">
				<td><input class="missionInput" type="text" name="missionName" id="mName\${cnt}" value="\${mName}" readOnly/></td>
				<td><input class="missionInput" type="text" name="missionDeposit" id="mDeposit\${cnt}" value="\${mDeposit}원" readOnly/></td>
				<td><input class="missionInput" type="text" name="missionDate" id="mEndDate\${cnt}" value="~ \${mEndDate}" readOnly /></td>
				<td value="\${isbn}">
					<button type="button" class="mybtn" onclick="editMission(this);" value="\${cnt}">수정</button>
					<button type="button" class="mybtn" onclick="deleteMission(this);" value="\${cnt}">삭제</button>
				</td>
				<input type="hidden" name="missionContent" id="mContent\${cnt}" value="\${mContent}"/>
			</tr>
		`;
		
		mtbody.insertAdjacentHTML('beforeend', mtr);
		cnt++;
	}
	else {
		
		// 수정할거임 
		$(`#mName\${mNo}`).val(mName);
		$(`#mEndDate\${mNo}`).val('~ ' + mEndDate);
		$(`#mContent\${mNo}`).val(mContent);
		
		alert('수정되었습니다!');
	}
	
	
	// 등록했으니 미션모달 내용 싹 지우기
	missionModalEmpty();
	
	// 모달 닫기
	$('#addMissionModal').modal('hide');

}

const notShowModal = (missionModal) => {
/* 	$(missionModal).on('show.bs.modal', function (e) {

		  e.preventDefault();

		}) */
}

const showModal = (modal) => {
	$(modal).off('show.bs.modal');
}

let mNo='';
const editMission = (e) => {
	status="edit";
	
	console.log(e);
	
	mNo = e.value;
	const isbn = $(e.parentElement).attr('value');
	
	// 수정할거니까 모달 보여줘
 	$('#addMissionModal').modal('show');

	// 이전 값 뿌려줘야 하니까 가져와
 	const mNameBefore = $(`#mName\${mNo}`).val();
	const mEndDateBefore = $(`#mEndDate\${mNo}`).val().substr(2);
	let mContentBefore = $(`#mContent\${mNo}`).val();

	// 이전 값 모달에 뿌리셈
	$('#mName').val(mNameBefore);
	$('#mEndDate').val(mEndDateBefore);
	$('#mContent').val(mContentBefore);
	
}

const changeDeposit = () => {
	
	const deposit = $('#deposit').val();
	const mDeposit = Math.round(deposit / missionCnt);
	
	// 현재 있는 미션 모두 가져와
	// 디포짓 바꿔 
	$("input[name=missionDeposit]").val(mDeposit + "원");
	$('#finalDeposit').val(mDeposit);
	
	
	return mDeposit;
	
}


// 미션 삭제할거임
const deleteMission = (e) => {
	
	mNo = e.value;
	const missionId = "#mission" + mNo;
	const mtr = document.querySelector(missionId);
	
	const isbn = $(e.parentElement).attr('value');
	const mtbodyId = "#missionWrapper" + isbn;
	const mtbody = document.querySelector(mtbodyId); 
	
	// 미션리스트에서 선택된 미션 지워
	mtbody.removeChild(mtr);
	
	// 전체 개수 삭제하셈.
	missionCnt--;
	
	// 디파짓도 바꾸셈
	changeDeposit();
	
}






// 폼이 제출되기 전에!! 
const frmSubmit = () => {
	
	
	console.log(booksDiv);
	console.log(selectedBooks);
	
	/**************유효성검사***************/
	// 제목 입력했는지
	if($('#title').val() == ''){
		 // alert('북클럽 제목을 입력해주세요');
		
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 제목을 입력해주세요.',
	    });
				
		return;
	}
	// 북클럽 설명 입력했는지
	if($('#clubDesc').val().length < 10){
 		// alert('북클럽 설명은 최소 10자 이상 적어주세요.');
		
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 설명은 최소 10자 이상 적어주세요.',
	    });
		
		return;
	}
	
	//날짜 다 입력했는지
	if($('#recruitStart').val() == '' || $('#recruitEnd').val() == ''){
		/* alert("북클럽 모집 기간을 입력해주세요."); */
		
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 모집 기간을 입력해주세요.',
	    });
		
		return;
	}
	
	//날짜 다 입력했는지
	if($('#clubStart').val() == '' || $('#clubEnd').val() == ''){
		// alert("북클럽 기간을 입력해주세요.");
		
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 기간을 입력해주세요.',
	    });
		
		return;
	}
	
	// 날짜 기간 맞는지
	if($('#recruitStart').val() > $('#recruitEnd').val()) {
		// alert("북클럽 모집 마감일은 모집 시작일 이후여야 합니다!");
		
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 모집 마감일은 모집 시작일 이후여야 합니다!',
	    });
		
		return;
	}
	
	if($('#recruitEnd').val() > $('#clubStart').val()) {
		// alert("북클럽 시작일은 모집 마감일 이후여야 합니다!");
		
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 시작일은 모집 마감일 이후여야 합니다!',
	    });
		
		return;
	}
	
	if($('#clubStart').val() > $('#clubEnd').val()) {
		// alert("북클럽 마감일은 북클럽 시작일 이후여야 합니다!");
		
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 마감일은 북클럽 시작일 이후여야 합니다!',
	    });
		
		return;
	}
	
	// 북클럽 분야 선택했는지
	if($("input:checkbox[name=interests]:checked").length == 0){
		// alert("북클럽 분야를 최소 한 개 이상 선택해주세요.");
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽 분야를 최소 한 개 이상 선택해주세요.',
	    });
		
		return;
	}
	
	//책 한권이라도 추가했는지
	if(selectedBooks.length == 0){
		// alert("북클럽에서 읽을 책을 최소 한 권 이상 골라주세요.");
		Swal.fire({
	      icon: 'warning',
	      title: '북클럽에서 읽을 책을 최소 한 권 이상 골라주세요.',
	    });
		
		return;
	}

	
	// 미션 책마다 최소 하나씩은 있는지
	for(let i = 0; i < selectedBooks.length; i++){
		let mId = "#missionWrapper" + selectedBooks[i];
		let missionCnt = document.querySelector(mId).childElementCount;
		if(missionCnt == 1){
			// alert("책마다 최소 한 개 이상의 미션을 등록해주세요!");
			Swal.fire({
		      icon: 'warning',
		      title: '책마다 최소 한 개 이상의 미션을 등록해주세요!',
		    });
			
			return;
		}
	}
	

	const frm = document.clubEnrollFrm;
	console.log(selectedBooks);
	const additionalInfo = document.querySelector('#additionalInfo');
	
	selectedBooks.forEach((isbn) => {
		const tbodyId = "missionWrapper" + isbn;
		const mCnt = document.getElementById(tbodyId).childElementCount - 1;
		const mInput = `
			<input type="hidden" name="mCount" value="\${mCnt}" />
		`;
		additionalInfo.insertAdjacentHTML('beforeend', mInput);
	});

	const divs = Object.values(booksDiv);
	divs.forEach((div) => {
		const bookName = $(div).find('.book-title')[0].innerText;
		console.log(bookName);
		
		const nameInput = `
			<input type="hidden" name="bookName" value="\${bookName}" />
		`;
		
		additionalInfo.insertAdjacentHTML('beforeend', nameInput);
		
	});
	
	
	// 따옴표 검사해서 바꿔치기해
	$('#title').val().replace(/\"/g, '&quot;');
	$('#clubDesc').val().replace(/\"/g, '&quot;');
	
	
 	frm.action = `${pageContext.request.contextPath}/club/enrollClub.do`
	frm.method = "POST";
	frm.submit();
	
}


const cancelAll = () => {
	
	Swal.fire({
	      title: '북클럽 등록을 취소하시겠습니까?',
/* 	      text: "다시 되돌릴 수 없습니다. 신중하세요.", */
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#fe9801;',
	      cancelButtonColor: '#d33',
	      confirmButtonText: '확인',
	      cancelButtonText: '취소',
	      reverseButtons: true, // 버튼 순서 거꾸로
	      
	    }).then((result) => {
	      if (result.isConfirmed) {
	    	  location.href = `${pageContext.request.contextPath}/club/clubList.do`;
	      }
	      else {
	    	  return;
	      }
	    });
	
}


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>