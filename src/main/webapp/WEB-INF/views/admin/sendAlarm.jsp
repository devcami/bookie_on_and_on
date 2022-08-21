<%@page import="com.kh.bookie.member.model.dto.Interest"%>
<%@page import="org.springframework.security.core.authority.SimpleGrantedAuthority"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.bookie.member.model.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자페이지" name="title"/>
</jsp:include>
<section id="content">

<div class="container">
     <div class="row col-12 btn-group">
     	<a href="${pageContext.request.contextPath}/admin/memberList.do" class="btn yellow"    id="member" >회원목록</a>
		<a href="${pageContext.request.contextPath}/admin/reportList.do" class="btn red"    id="report" >신고</a>
		<a href="${pageContext.request.contextPath}/admin/qnaList.do" class="btn purple" id="question">Q & A</a>
		<a href="${pageContext.request.contextPath}/admin/sendAlarm.do" class="btn green"  id="alarm">알림전송</a>
		<a href="${pageContext.request.contextPath}/club/missionCheck.do" class="btn blue"  id="mission">미션확인</a>
     </div>
</div>
<div>
	<div class="input-group m-3 w-50">
	  <select class="custom-select" name="interest" id="inputGroupSelect">
	    <option selected disabled>관심사 선택</option>
	    <option value="경제">경제</option>
	    <option value="공학">공학</option>
	    <option value="문학">문학</option>
	    <option value="자기계발">자기계발</option>
	    <option value="언어">언어</option>
	    <option value="취미">취미</option>
	    <option value="에세이">에세이</option>
	    <option value="예술">예술</option>
	    <option value="교육">교육</option>
	    <option value="인문학">인문학</option>
	    <option value="종교">종교</option>
	    <option value="기타">기타</option>
	  </select>
	  <div class="input-group-append">
		<button 
	     type="button" 
	     class="btn yellow"
	     data-toggle="modal" data-target="#adminNoticeModal">알림전송하기</button>            
	  </div>
	</div>
</div>

<div class="container mt-3">
	<table class="table table-fixed text-center">
		<thead>
			<tr>
				<th scope="col">아이디</th>
				<th scope="col">닉네임</th>
				<th scope="col">관심사</th>
			</tr>
		</thead>
		<tbody id="tbody">
			<c:forEach items="${list}" var="member">
				<tr data-member-id=${member.memberId}>
					<td>${member.memberId}</td>
					<td>${member.nickname}</td>

					<td>${member.interest}</td>
				</tr>
			</c:forEach>
		</tbody>

	</table>
</div>


</section>

<script>
document.querySelector('#inputGroupSelect').addEventListener('change', (e) => {
	console.log(e.target.value);	
	const tbody = document.querySelector("#tbody");
	const modalSendToName = document.querySelector("#send-to-name");
	modalSendToName.value = "";
	tbody.innerHTML = "";
	
	// 셀렉트 변경 시 회원 list 다시 가져와
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/selectMemberListByInterest.do",
		method : 'GET',
		contentType : 'application/json; charset=utf-8',
		data : { interest : e.target.value },
		success(resp){
			console.log(resp);
			// tbody에 뿌려
			const {list} = resp;
			list.forEach((member) => {
				const {memberId, nickname, interest} = member;
				//console.log(memberId, nickname, interest);
				let div = `
				<tr data-member-id=\${memberId}>
					<td>\${memberId}</td>
					<td>\${nickname}</td>
					<td>\${interest}</td>
				</tr>`;
				tbody.insertAdjacentHTML('beforeend', div);
				// 여기의 memberId들을 modal id에 뿌려
				modalSendToName.value += memberId + ",";
			});
			
			
		},
		error: console.log
	});
});

</script>
<%!
%>


<!-- 관리자용 공지 modal -->
<div class="modal fade" id="adminNoticeModal" tabindex="-1"
	role="dialog" aria-labelledby="#adminNoticeModalLabel"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="adminNoticeModalLabel">Notice</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form name="adminNoticeFrm">
					<div class="form-group">
						<label for="send-to-name" class="col-form-label">받는이 :</label> 
						<input type="text" class="form-control" id="send-to-name" placeholder="생략 시 전체 접속회원에게 공지합니다.">
					</div>
					<div class="form-group">
						<label for="message-text" class="col-form-label">메세지 :</label>
						<textarea class="form-control" id="message-text"></textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="adminNoticeSendBtn">전송</button>
			</div>
		</div>
	</div>
</div>
<script>
document.querySelector("#adminNoticeSendBtn").addEventListener('click', (e) => {
	const tos = document.querySelector("#send-to-name").value;
	const msg = document.querySelector("#message-text").value;
	
	if(!msg) return;
	
	const to = tos.split(",");
	//console.log(to.length);

	const csrfHeader = '${_csrf.headerName}';
	const csrfToken = '${_csrf.token}';
	const headers = {};
	headers[csrfHeader] = csrfToken; // 전송하는 헤더에 추가하여 전송 
	
	for(let i = 0; i < to.length - 1; i++){
		// 공지 알림 db 저장
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/insertAlarm.do",
			method : 'post',
			headers,
			data : { 
				memberId : to[i],
				alarmContent : msg
			},
			success(resp){
				console.log(resp);
			},
			error: console.log
		});
	}
	
	$(adminNoticeModal).modal('hide'); // 모달 숨기기
	document.adminNoticeFrm.reset(); // 모달 폼 초기화

});



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>