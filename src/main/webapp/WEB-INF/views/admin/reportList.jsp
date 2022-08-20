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

<div class="container">
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
            <th scope="col" >신고자</th>
            <th scope="col" >
            	<select name="category" id="category">
            		<option selected>카테고리</option>
            		<option value="pheed">피드</option>
            		<option value="dokoo">독후감</option>
            		<option value="pheed_comment">피드댓글</option>
            		<option value="dokoo_comment">독후감댓글</option>
            	</select>
     		</th>
            <th scope="col" >글번호</th>
            <th scope="col" >신고날짜</th>
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
			<c:forEach items="${list}" var="report" varStatus="vs">
				<tr data-report-no="${report.reportNo}" 
					onclick="location.href='${pageContext.request.contextPath}/admin/reportDetail.do?reportNo=${report.reportNo}';">
					<td>${report.memberId}</td>
					<td>${report.category}</td>
		            <td>${report.beenziNo}</td>
		            <td>
		            	<fmt:parseDate value="${report.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
						<fmt:formatDate value="${createdAt}" pattern="yyyy/MM/dd HH:mm"/>
		            </td>
		            <td>${report.status eq 'U' ? '처리전' : '처리완료'}</td>
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
<%-- 카테고리 변경 시 eventListener --%>
document.querySelector("#category").addEventListener('change', (e) => {
	console.log(e.target.value);
	const statusInput = document.querySelector("#status");
	console.log(statusInput.value);
	tbody.innerHTML = "";
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/selectReportListByCategory.do",
		method : 'GET',
		contentType : 'application/json; charset=utf-8',
		data : {
			category : e.target.value,
			status :  statusInput.value
		},		
		success(resp){
			console.log(resp);
			// tbody에 뿌려
			const {list, pagebar} = resp;
			list.forEach((report) => {
				console.log(report);
				let {reportNo, memberId, beenziNo, category, createdAt, status} = report;
				//console.log(memberId, nickname, interest);
				//console.log(createdAt);
				let {year, monthValue, dayOfMonth, hour, minute} = createdAt;
					
				createdAt = year + "/" + 
							monthValue < 10 ? "0" + monthValue : monthValue + "/" + 
							dayOfMonth < 10 ? "0" + dayOfMonth : dayOfMonth + " " +
							hour < 10 ? "0" + hour : hour + ":" +
							minute < 10? "0" + minute : minute;
				
				status = (status == 'U' ? '처리전' : '처리완료');  
				let div = `
				<tr data-report-no="\${reportNo}"
					onclick="location.href='${pageContext.request.contextPath}/admin/reportDetail.do?reportNo=\${reportNo}';">
					<td>\${memberId}</td>
					<td>\${category}</td>
		            <td>\${beenziNo}</td>
		            <td>\${createdAt}</td>
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

<%-- 상태 변경 시 eventListener --%>
document.querySelector("#status").addEventListener('change', (e) => {
	console.log(e.target.value);
	const categoryInput = document.querySelector("#category");
	console.log(categoryInput.value);
	tbody.innerHTML = "";
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/selectReportListByStatus.do",
		method : 'GET',
		contentType : 'application/json; charset=utf-8',
		data : { 
			category : categoryInput.value,
			status :  e.target.value },
		success(resp){
			//console.log(resp);
			const {list, pagebar} = resp;
			list.forEach((report) => {
				//console.log(report);
				let {reportNo, memberId, beenziNo, category, createdAt, status} = report;
				//console.log(memberId, nickname, interest);
				//console.log(createdAt);
				let {year, monthValue, dayOfMonth, hour, minute} = createdAt;
					
				createdAt = year + "/" + 
							monthValue < 10 ? "0" + monthValue : monthValue + "/" + 
							dayOfMonth < 10 ? "0" + dayOfMonth : dayOfMonth + " " +
							hour < 10 ? "0" + hour : hour + ":" +
							minute < 10? "0" + minute : minute;
				
				status = (status == 'U' ? '처리전' : '처리완료');  
					
				let div = `
				<tr data-report-no="\${reportNo}">
					<td>\${memberId}</td>
					<td>\${category}</td>
		            <td>\${beenziNo}</td>
		            <td>\${createdAt}</td>
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