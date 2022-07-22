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
			
			<div id="bookWrapper">
			<!--
			 	여기에 책이 하나씩 추가됨.
			 -->
			</div>
			

			<div id="btn-add-book-container">
				<!-- Button trigger modal -->
<!-- 				<button 
					type="button" id="btn-add-book" class="btn gap-2 col-12" 	
					onclick="addBook();"> -->
					<button 
					type="button" id="btn-add-book" class="btn gap-2 col-12" 	
					data-toggle="modal" data-target="#addBookModal"
					onclick="addBookTest();">
					
				  책 추가
				</button>
				<span style="display:none;" id="cPage">1</span>
			</div>
		</div>
		

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
			<button id="btn-enroll" class="mybtn last-btn">등 록</button>
			<button id="btn-cancel" class="mybtn last-btn">취 소</button>	    	
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
	
	
	<%-- <form 
		name="addBookFrm"
		action="${pageContext.request.contextPath}/club/addBookPopup.do"
		method="GET">
		<input type="hidden" />
		<!-- <input type="hidden" name="currentBook" value="" /> -->
	</form> --%>
	


<script>

/* const addBook = () => {
		const title = "addBookPopup";
		const spec = "width=700px";
		const popup = open("", title, spec);
		
		const frm = document.addBookFrm;
		frm.target = title; // 해당 팝업에서 폼을 제출 
		frm.submit();
	} */
	

	


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


const getPage = (cPage, maxResult) => {
	   // console.log(cPage, maxResult);
	   const searchApi = 'https://cors-anywhere.herokuapp.com/';
	   const container = document.querySelector("#books-div");
	   // console.log('${param.searchType}', '${param.searchKeyword}');
	   const query = document.querySelector("#searchKeyword").value;
	   const queryType = document.querySelector("#searchType").value;
		   
	   let data = {
	         ttbkey : 'ttbiaj96820130001',
	         QueryType : 'Bestseller',
	         SearchTarget: 'Book',
	         Start : cPage,
	         MaxResults : maxResult,
	         Output : 'js',
	         Cover : 'mini',
	         Version : '20131101'
	   };
	   let url;
	   
	   /*********************************
	   if('${param.searchType}' == ''){
	      url = searchApi + "http://www.aladin.co.kr/ttb/api/ItemList.aspx";
	   } else{
	      url = searchApi + "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx";
	      data.QueryType = '${param.searchType}';
	   }
	   if('${param.searchKeyword}' != ''){
	      data.Query = '${param.searchKeyword}';
	   }
	   
	   *********************/
	   	   if(queryType == 'All'){
	   		   console.log('처음로딩');
		      url = searchApi + "http://www.aladin.co.kr/ttb/api/ItemList.aspx";
		   } else{
			   console.log("검색 후 로딩");
		      url = searchApi + "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx";
		      data.QueryType = queryType;
		   }
		   if(query != ''){
		      data.Query = query;
		   }
	   
	   
	   console.log('data = ', data);
	   $.ajax({
	      url : url,
	      //https://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbiaj96820130001&Query=aladdin&QueryType=Keyword&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101
	      data : data,
	      success(resp){
	    	  const {item} = resp;
				const divNon = `
					<div>
						<p style="text-align:center"> 검색된 결과가 없습니다. </p>
					</div>`
					
				// console.log('item = {}', item);
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
/* 	      complete(){
	         if(cPage == 10){
	            const btn = document.querySelector("#btn-more")
	            btn.disabled = "disabled";
	            btn.style.cursor = "not-allowed";
	         }
	      } */
	   });
	};

/***********************************/

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
		alert('등록 가능한 책은 최대 4권입니다.');
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
	
	// console.log("삭제전", booksDiv);
	
	const isbn = e.value;
	const container = document.querySelector("#modal-header-bottom");
	container.removeChild(e.parentElement);

	const divId = "btnDiv" + isbn;
	const div = document.getElementById(divId);
	div.firstElementChild.classList.remove('noclick');
	div.firstElementChild.disabled = '';
	delBook(isbn);
	
	// console.log("삭제후",booksDiv);
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


$('#addBookModal').on('hidden.bs.modal', function (e) {
   	// 모달 닫길때 이벤트
/*    	console.log(selectedBooks.length, '개');
   	
   	const msg = '총 ' + selectedBooks.length + '권의 책이 선택되었습니다. 등록하시겠습니까?';
   	confirm(msg);
   	
   	if(confirm){
   		console.log('예');
   	}  */
   	enrollBook();
});

const enrollBook = () => {
	
	if(selectedBooks.length == 4){
		const btn = document.querySelector("#btn-add-book")
		btn.disabled = "disabled";
		btn.classList.add('noclick');
		btn.style.color = "white";
	}
		
	const container = document.getElementById('bookWrapper');
	const missionContainer = document.getElementById('missionContainer');
	const btnDiv = `
		<div>
			<button type="button" class="btn deleteBook-btn" onclick="deleteBook(this);">삭제</button>
		</div>
	`;
	
	const divs = Object.values(booksDiv);
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
			      		<tbody>
				      		<tr>
		      					<td colspan="5">🧡책에 대한 미션을 등록해주세요!</td>
		      				</tr>
			      		</tbody>
			      	</table>
				    <button type="button" class="btn gap-1 col-1 mission-btn" data-toggle="modal" data-target="#addMissionModal" data-whatever="@mdo">
				    +
				    </button>
			      </div>
			    </div>
			  </div>`;
			
			
			missionContainer.insertAdjacentHTML('beforeend', missionDiv);
		}
		
		
		

		/*
		
			<table>
	      		<tbody>
	      			<tr>
	      				<td colspan="5">🧡책에 대한 미션을 등록해주세요!</td>
	      			</tr>
	      		    <!-- <tr class="head-tr">
	      				<th>번호</th>
	      				<th>제목</th>
	      				<th>디파짓</th>
	      				<th>기한</th>
	      				<td>
	      					<button style="display:none;">수정</button>
	      					<button style="display:none;">삭제</button>
	      				</td>
	      			</tr>  -->
	      		</tbody>
	      	</table>
			
		*/
		
		
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
		const btn = document.querySelector("#btn-add-book")
		btn.disabled = "";
		btn.classList.remove('noclick');
		btn.style.color = "#FE9801";
	}
	
	// 미션 삭제
	$(`#m\${isbn}`).remove();
	
	// 미션 1개 이상인지 확인
	const missionContainer = document.querySelector('#missionContainer');
	if(missionContainer.childElementCount == 0){
		document.querySelector('#mLabel').style.display = '';
	}
	
	
}

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>