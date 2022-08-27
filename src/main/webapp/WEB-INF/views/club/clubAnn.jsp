<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.kh.bookie.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/clubAnn.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="북클럽리스트" name="title"/>
</jsp:include>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="loginMember"/>
</sec:authorize>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value='${today}' pattern='yyyy-MM-dd' var="nowDate"/>

<div id="title-header" class="" style="display: none;">
	<div id="header-div">
		<div id="title-header-left">
			<i class="fa-solid fa-angle-left" onclick="location.href='/bookie/club/clubList.do'"></i>
			<span>[북클럽] ${club.title}</span>					
		</div>
		<c:if test="${club.recruitEnd le nowDate}">
		<sec:authorize access="hasRole('ROLE_USER')">
			<div id="likeWishDiv">
				<span class="fa-stack fa-lg" id='h-span'>
				  <i class="fa fa-heart fa-regular fa-stack-1x front" data-club-no="${club.clubNo}"></i>
				  <c:if test="${club.isLiked == 1}">
				  	<i class="fa fa-heart fa-solid fa-stack-1x h-behind" data-club-no="${club.clubNo}"></i>
				  </c:if>
				</span>
				<span class="fa-stack fa-lg" id='h-span'>
				  <i class="fa fa-bookmark fa-regular fa-stack-1x front" data-club-no="${club.clubNo}"></i>
				  <c:if test="${club.isWished == 1}">
				  	<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind" data-club-no="${club.clubNo}"></i>
				  </c:if>
				</span>
			</div>		
		</sec:authorize>
		</c:if>
	</div>
</div>
<section id="content">
	<div id="head">
		<div id="head-img">
			<c:forEach items="${club.bookList}" var="book" varStatus="vs">
				<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}">
			</c:forEach>
		</div>
		<div id="head-text">
			<h3>${club.title}</h3>
			<h6>${club.content}</h6>
		</div>
	</div>
	<div class="badge-div">
		<c:set var="item" value="${fn:split(club.interest,',')}"/>
		<c:forEach items="${item}" var="interest" varStatus="vs">
			<span class="badge badge-pill myBadge">#${interest}</span>	
		</c:forEach>
	</div>
	
	<%-- 기본정보 --%>
	<div id="info-div">
		<div class="divs-head">
			<strong>기본 정보</strong>
			<span id="heart-span">🧡</span>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-calendar-days"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">📆 모집 기간</label>
			</div>
			<div>
				<span>${club.recruitStart} ~ ${club.recruitEnd}</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-calendar-days"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">📅 북클럽 기간</label>
			</div>
			<div>
				<span>${club.clubStart} ~ ${club.clubEnd}</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-user"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">🙍‍♀️ 최소 인원</label>
			</div>
			<div>
				<span>${club.minimumNop}명</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-user-group"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">‍‍👨‍👩‍👦‍👦 최대 인원</label>
			</div>
			<div>
				<span>${club.maximumNop}명</span>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-user-group"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">‍‍😊 모집된 인원</label>
			</div>
			<div>
				<span>${club.currentNop}명 / ${club.maximumNop}명</span>
				<c:if test="${club.maximumNop eq club.currentNop}">
					<span class="redText" style="margin-left: 10px;">!마감되었습니다!</span>				
				</c:if>
			</div>
		</div>
		<div class="divs">
			<div class="label-div">
				<!-- <i class="fa-solid fa-sack-dollar"></i> -->
				<label class="my-1" for="inlineFormCustomSelectPref">💰 디파짓</label>
			</div>
			<div>
				<fmt:formatNumber value="${club.deposit}" pattern="#,###" />
				<i class="fa-solid fa-won-sign"></i>
			</div>
		</div>
	</div>
	<%-- 기본정보 끝 --%>
	
	<%-- 읽는 책 --%>
	<div id="book-div">
		<div class="divs-head">
			<strong>읽는 책</strong>
			<span id="heart-span">🧡</span>
			<span id="mini-info">북클럽에서 ${club.bookList.size()}권의 책을 읽어요.</span>
		</div>	
		<div id="book-imgs">
			<c:forEach items="${club.bookList}" var="book" varStatus="vs">
				<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}" value="${book.itemId}" onclick="bookEnroll(this);">
				
			</c:forEach>
		</div>
	</div>
	<%-- 읽는 책 끝 --%>
	
	

	<%-- 미션 --%>
	<div id="mDiv">
		<div id="mission-head">
			<strong>미션</strong>
			<span id="heart-span">🧡</span>
			<span id="mini-info">미션을 수행하고 포인트를 받으세요!</span>
		</div>	
		<div id="mission-div">
			
			<c:forEach items="${club.bookList}" var="book" varStatus="vs">
				<div class="mCard" data-no="${book.itemId}" data-vs-no="${vs.count}" onclick="openDetailMission(this);">
					<div class='m-img-div' data-no="${vs.count}">
						<img src="${fn:replace(book.imgSrc, 'covermini', 'cover')}" value="${book.itemId}">								
					</div>
					<div class="m-text-div">
						<table>
							<tbody id="tbody${book.itemId}">
								<c:forEach items="${book.missionList}" var="mission" varStatus="vs">
									<tr id="bookMission${book.itemId}">
										<td>🌼${mission.title}</td>									
										<td><fmt:formatNumber value="${mission.point}" pattern="#,###" />원</td>									
								        <td>${mission.mendDate}</td>
									</tr>									         								
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>								
			</c:forEach>
			
		</div>
	
	</div>
	<%-- 미션 끝 --%>
	
	
	
	<%-- 등록 버튼 --%>
	<sec:authorize access="isAnonymous()">
		<p id="plzEnrollMember">🧡이 북클럽이 맘에 드셨나요? 부기온앤온의 회원이 되시면 북클럽 활동이 가능합니다!🧡</p>
	</sec:authorize>
	<div id="btn-div">
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button style="margin-right: 2px;" data-type="update" onclick="ckNop(this);">수정</button>
			<button type="button" style="margin-left: 2px;" data-type="delete" onclick="ckNop(this);">삭제</button>
		</sec:authorize>
		<sec:authorize access="isAuthenticated() && !hasRole('ADMIN')">
			<!-- 모집중인 경우 -->
			<c:if test="${club.recruitEnd ge nowDate}">
				<!--  아직 인원이 차지 않은 경우 -->
				<c:if test="${club.maximumNop gt club.currentNop}">
					<c:if test="${club.isJoined == 0}">
						<button onclick="joinClub();">신청하기</button>						
					</c:if>
					<c:if test="${club.isJoined == 1}">
						<p>이미 신청하신 북클럽입니다!</p>
						<button onclick="cancelJoin();" id="btn-disabled" style="width: 55%; cursor: pointer !important;">북클럽 신청 취소</button>
					</c:if>							
				</c:if>
				<!-- 모집중이면서 인원이 다 찬 경우 -->
				<c:if test="${club.maximumNop eq club.currentNop}">
					<button id="btn-disabled">인원이 다 찼습니다😥</button>						
				</c:if>
			</c:if>
			<!-- 날짜가 지난 북클럽일때 -->			
			<c:if test="${club.recruitEnd lt nowDate && club.isJoined == 0}">
				<button id="btn-disabled">모집일이 지난 북클럽입니다😥</button>
			</c:if>
			<c:if test="${club.recruitEnd lt nowDate && club.isJoined == 1}">
				<button id="btn-disabled">이미 신청하신 북클럽입니다!</button>
			</c:if>
		</sec:authorize>
		<sec:authorize access="isAnonymous()">
			<button>회원가입 하러가기</button>
		</sec:authorize>
	</div>
	<%-- 등록 버튼 끝--%>
	
	
	<%-- 미션 모달 --%>
	<div class="modal fade" id="missionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="missionModalBook"></h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body" id="modalMissionWrapper">
	      <%--
	      	여기에 미션이 하나씩 추가됨
	       --%>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%-- 미션 모달 끝 --%>
	<form:form
		name="joinClubFrm" 
		method="POST"
		action="${pageContext.request.contextPath}/club/joinClub.do">
		<input type="hidden" name="clubNo" value="${club.clubNo}" />
		<input type="hidden" name="memberId" value="${loginMember.username}" />
		<input type="hidden" name="deposit" value="${club.deposit}" />
		<input type="hidden" name="myPoint" id="myPoint" value="" />
		<input type="hidden" name="clubEnd" value="${club.clubEnd}"/>
		<input type="hidden" name="totalMission" value="${club.missionCnt}" />
		
	</form:form>

	<form:form
		name="deleteClubFrm" 
		method="POST"
		action="${pageContext.request.contextPath}/club/deleteClub.do">
		<input type="hidden" name="clubNo" value="${club.clubNo}" />
	</form:form>	

	
</section>

<script>

// 수정/삭제 버튼 눌렀을 때
const ckNop = (e) => {
	
	const type = e.dataset.type;
	const nop = ${club.currentNop};
	
	console.log(type);
	
	if(nop != 0){
		if(type == "update"){
			alert('이미 신청한 회원이 있어 수정이 불가합니다.');
			return;
		}
		else {
			alert("이미 신청한 회원이 있어 삭제가 불가합니다.");
			return;
		}
	}
	
	if(type == "update")
		location.href = `${pageContext.request.contextPath}/club/updateClub.do/${club.clubNo}`;
	else 
		deleteClubFrm.submit();
		
	
}

const bookEnroll = (e) => {
	const isbn13 = $(e).attr('value');
	location.href = "${pageContext.request.contextPath}/search/bookEnroll.do?isbn13=" + isbn13;
};


/* window.addEventListener('load', (e) => {
	document.querySelectorAll(".mCard").forEach((mission) => {
		mission.addEventListener('click', (e) => {
			console.log(e.target);
		});
	});
	
	
	
}); */

window.addEventListener('load', (e) => {
	
	
	/************* 하트와 찜 *************/
	// 하트
		document.querySelectorAll(".fa-heart").forEach((heart) => {
		heart.addEventListener('click', (e) => {
			
			// 부모한테 이벤트 전파하지마셈
			e.stopPropagation(); 
			
			// 클릭할때마다 상태왔다갔다
			changeIcon(e.target, 'heart');
		});	
	});	
	
	// 북마크
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
	
	console.log(icon);
	
	const iHeart = `<i class="fa fa-heart fa-solid fa-stack-1x h-behind"></i>`;
	const iBookMark = `<i class="fa fa-bookmark fa-solid fa-stack-1x b-behind"></i>`;
	let memberId = "";
	
	if("${loginMember}"){
         memberId = "${loginMember.username}";			
	}
	 
	
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
				
				console.log('하트/찜 delete 완료');
				
			},
			error: console.log
		});
	
	}

}





/* const changeIcon = (icon, shape) => {

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
	
} */



const cnt = ${club.bookList.get(0).missionList.size()};
const clubb = '${club.bookList.get(0).missionList.get(0).title}';


let arr = new Array();
<c:forEach items="${club.bookList}" var="book" varStatus="vs">
	arr.push({ "bookTitle": "${book.bookTitle}"});
</c:forEach>

/********** 미션 디테일 모달 열어 ***************/
const openDetailMission = (e) => {
	const container = document.querySelector('#modalMissionWrapper');
	const headContainer = document.querySelector('#missionModalBook');
	
	
	// 미션 모달 안에 내용 전부 비워
	while (container.hasChildNodes()) {	// 부모노드가 자식이 있는지 여부를 알아낸다
			container.removeChild(
				container.firstChild
		  );
		}
	headContainer.innerText = '';
	
	const itemId = e.dataset.no;
	const eNo = e.firstElementChild.dataset.no - 1;
	const tbodyId = "#tbody" + itemId;
	const mCnt = $(e).find(tbodyId).children().length;
	const vsNo = e.dataset.vsNo-1;
	const bookTitle = arr[vsNo].bookTitle;

	// console.log(eNo);
	// console.log(mCnt);
	
	const clubNo = '${club.clubNo}';	

	$.ajax({
		url: "${pageContext.request.contextPath}/club/getMission.do",
		data : {
			itemId : itemId,
			clubNo : clubNo
		},
		method : "GET",
		success(mList){
			// console.log('여기', mList);
			
			const {missionList} = mList;
			// console.log(missionList);
			
			if(missionList.length == 0){
				// 미션없는 경우
			} 
			else {
				missionList.forEach((mission, index) => {
					const year = mission.mendDate.year;
					const month = mission.mendDate.monthValue;
					const day = mission.mendDate.dayOfMonth;
					const mEndDate = year + "." + month + "." + day;
					
					headContainer.innerText = `📕\${bookTitle}`;
					
					const div = `
				        <div id="m\${mission.missionNo}" class="modalDiv">
					    	<span class="missionNo">미션 \${index + 1}</span>
					    	<p class="mTitle">\${mission.title}</p>
					    	<span class="mDate mSpan">~ \${mEndDate}</span>
					    	<span class="mDeposit mSpan">\${mission.point}원</span>
					    	<span class="mContent">\${mission.content}</span>
				    	</div>`;	
				    
				    container.insertAdjacentHTML('beforeend', div);
				    
				    	
				})
				
			}
			
		},
		error: console.log
	});
	
	$('#missionModal').modal('show');

}


/************** 모달 닫길때 이벤트 ****************/
$('#addBookModal').on('hide.bs.modal', function (e) {
	
	// 모달 닫길때 이벤트
	
	
	
});





/************** 상단 제목 바 **************/
 let imgDiv = document.querySelector("#head");
 let header = document.querySelector("#header-container")
 let headerHeight = header.clientHeight;
 let imgDivHeight = imgDiv.clientHeight;
const titlebar = document.querySelector("#title-header");
window.onscroll = function () {
	let windowTop = window.scrollY;
	if (windowTop >= imgDivHeight + headerHeight) {
		titlebar.classList.add("drop");
		titlebar.style.display = "inline";
	} 
	else {
		titlebar.classList.remove("drop");
		titlebar.style.display = "none";
	}
};

/**************** 회원의 클럽 신청 ***************/
const joinClub = () => {
	const clubNo = '${club.clubNo}';
	const memberId = '${loginMember.username}'
	const deposit = '${club.deposit}';
	
	console.log(clubNo, ' and ', deposit);
	
	$.ajax({
		url: '${pageContext.request.contextPath}/club/checkMyPoint.do',
		method: "GET",
		data : {
			deposit : deposit,
			memberId : memberId
		},
		success(data){
			const {myPoint, result, msg} = data;
			
			if(result == "enough"){
				// 성공하면 폼 제출
				const frm = document.joinClubFrm
				frm.myPoint.value = myPoint
				frm.submit();
			}
			else {
				alert(msg);
			}
			
		},
		error(data){
			console.log(data);
			console.log('실패');
			// 실패하면 포인트충전하라는 알람나옴
		}
	});
	
}

/**************** 회원의 클럽 신청 취소 ***************/
const cancelJoin = () => {
	const memberId = '${loginMember.username}';
	console.log(memberId);
	
	Swal.fire({
	      title: '북클럽 신청을 취소하시겠습니까?',
 	      text: "지불한 디파짓은 포인트로 다시 환불됩니다.",
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#fe9801;',
	      cancelButtonColor: '#d33',
	      confirmButtonText: '확인',
	      cancelButtonText: '취소',
	      reverseButtons: true, // 버튼 순서 거꾸로
	      
	    }).then((result) => {
	      if (result.isConfirmed) {
	    	  
	    	  Swal.fire({
			      icon: 'success',
			      title: '신청이 취소되었습니다!'
			    });
	    	 
	    	  const clubNo = '${club.clubNo}';
	    	  const memberId = '${loginMember.username}';
	    	  const deposit = '${club.deposit}';
	    	  const type = 'cancel';
	    	  
	    	  
	    	  location.href = `${pageContext.request.contextPath}/club/clubAnn.do?clubNo=\${clubNo}&memberId=\${memberId}&deposit=\${deposit}&type=\${type}`;
	      }
	      else {
	    	  return;
	      }
	    });
	 
}


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>