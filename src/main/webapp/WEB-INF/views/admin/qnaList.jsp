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
<section id="content" style="min-height: 800px;">

<div class="container" >
      <div class="row">
        <div class="col-12">
          <div class="row col-12 btn-group">
          	<a href="${pageContext.request.contextPath}/admin/memberList.do" class="btn yellow"    id="member" >회원목록</a>
			<a href="${pageContext.request.contextPath}/admin/reportList.do" class="btn red"    id="report" >신고</a>
			<a href="${pageContext.request.contextPath}/admin/qnaList.do" class="btn purple" id="question">Q & A</a>
			<a href="${pageContext.request.contextPath}/admin/sendAlarm.do" class="btn green"  id="alarm">알림전송</a>
			<a href="${pageContext.request.contextPath}/club/missionCheck.do" class="btn blue"  id="mission">미션확인</a>
	     </div>
        </div>
      </div>

	<div class="container mt-4">
      <table class="table table-fixed text-center" id="reportTbl">
        <thead>
          <tr>
            <th scope="col" >문의자</th>
            <th scope="col" >제목</th>
            <th scope="col" >등록날짜</th>
            <th scope="col" >
            	<select name="status" id="status">
            		<option selected >상태</option>
            		<option value="U">처리전</option>
            		<option value="E">처리완료</option>
            	</select>
           	</th>
          </tr>
        </thead>
       	<tbody id="tbody">
			<c:forEach items="${list}" var="qna" varStatus="vs">
				<tr data-qna-no="${qna.qnaNo}" 
					onclick="location.href='${pageContext.request.contextPath}/mypage/qnaDetail.do?qnaNo=${qna.qnaNo}';">
					<td>${qna.memberId}</td>
					<td>${qna.title}</td>
		            <td>
		            	<fmt:parseDate value="${qna.enrollDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="enrollDate"/>
						<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd HH:mm"/>
		            </td>
		            <td>${qna.status eq 'U' ? '처리전' : '처리완료'}</td>
				</tr>
			</c:forEach>
		</tbody>
        
      </table>
    </div>

</div>
</section>
<div class="pagebar" >
	<nav class="pagination-outer" id="pagebar" >${pagebar}</nav>
</div>

<script>
					
const tbody = document.querySelector("#tbody");

<%-- 상태 변경 시 eventListener --%>
document.querySelector("#status").addEventListener('change', (e) => {
	console.log(e.target.value);
	tbody.innerHTML = "";
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/selectQnaListByStatus.do",
		method : 'GET',
		contentType : 'application/json; charset=utf-8',
		data : { 
			status :  e.target.value },
		success(resp){
			//console.log(resp);
			const {list, pagebar} = resp;
			//console.log(pagebar);
			list.forEach((qna) => {
				//console.log(report);
				let {qnaNo, memberId, title, enrollDate, status} = qna;
				//console.log(memberId, nickname, interest);
				let {year, monthValue, dayOfMonth, hour, minute, second} = enrollDate;
					
				monthValue = monthValue < 10 ? "0" + monthValue : monthValue; 
				dayOfValue = dayOfMonth < 10 ? "0" + dayOfMonth : dayOfMonth;
				hour =	hour < 10 ? "0" + hour : hour;
				minute = minute < 10? "0" + minute : minute;
				
				const ed = year + "/" + monthValue + "/"+ dayOfValue + " " + hour + ":" + minute;
				status = (status == 'U' ? '처리전' : '처리완료');  
					
				let div = `
				<tr data-qna-no="\${qnaNo}"
					onclick="location.href='${pageContext.request.contextPath}/mypage/qnaDetail.do?qnaNo=\${qnaNo}';">
					<td>\${memberId}</td>
					<td>\${title}</td>
		            <td>\${ed}</td>
		            <td>\${status}</td>
				</tr>
				`;
				tbody.insertAdjacentHTML('beforeend', div);
				document.querySelector("#pagebar").innerHTML = pagebar;
			});
			
			
		},
		error: console.log
	});
});

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>