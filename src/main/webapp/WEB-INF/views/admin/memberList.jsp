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
      <div class="row">
        <div class="col-12">
          <div class="row col-12 btn-group">
          	<a href="${pageContext.request.contextPath}/admin/memberList.do" class="btn yellow"    id="member" >회원목록</a>
			<a href="${pageContext.request.contextPath}/admin/reportList.do" class="btn red"    id="report" >신고</a>
			<a href="${pageContext.request.contextPath}/admin/qnaList.do" class="btn purple" id="question">Q & A</a>
			<a href="${pageContext.request.contextPath}/admin/sendAlarm.do" class="btn green"  id="alarm">알림전송</a>
			<a href="${pageContext.request.contextPath}/admin/missionCheck.do" class="btn blue"  id="mission">미션확인</a>
	     </div>
        </div>
      </div>
    </div>

    <div class="container mt-4">
	  
      <table class="table table-fixed text-center" style="transform: translateX(-45px);">
        <thead>
          <tr>
            <th scope="col" >아이디</th>
            <th scope="col" >닉네임</th>
            <th scope="col" >E-mail</th>
            <th scope="col" >핸드폰 번호</th>
            <th scope="col" >성별</th>
            <th scope="col" >잔여 포인트</th>
            <th scope="col" colspan="2">권한</th>
          </tr>
        </thead>
       	<tbody class="tbody">
			<c:forEach items="${list}" var="member" varStatus="vs">
				<tr data-member-id="${member.memberId}" onclick="location.href='${pageContext.request.contextPath}/admin/memberDetail.do?memberId=${member.memberId}'">
					<td>${member.memberId}</td>
					<td>${member.nickname}</td>
		            <td>${member.email}</td>
		            <td>${member.phone}</td>
		            <td>${member.gender}</td>
		            <td>${member.point}</td>
					<td class="p-1">
						<input type="checkbox" id="role-user-${vs.count}" name="authority" value="ROLE_USER" <%= hasRole(pageContext, "ROLE_USER") ? "checked" : "" %> />
						<label for="role-user-${vs.count}">일반</label>
						<br />
						<input type="checkbox" id="role-admin-${vs.count}" name="authority" value="ROLE_ADMIN" <%= hasRole(pageContext, "ROLE_ADMIN") ? "checked" : "" %> />
						<label for="role-admin-${vs.count}">관리자</label>
					</td>
					<td class="p-1">
						<button type="button" class="btn btn-sm btn-outline-primary btn-update-authority p-1" value="${member.memberId}">수정</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
        
      </table>
    </div>


</section>

<script>
document.querySelectorAll(".btn-update-authority").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const memberId = e.target.value;
		console.log(memberId);
		const tr = document.querySelector(`[data-member-id=\${memberId}]`);
		const authorities = [...tr.querySelectorAll("[name=authority]:checked")].map((checkbox) => checkbox.value);
		console.log(authorities);
		
		const headers = {
			"${_csrf.headerName}" : "${_csrf.token}"
		};
		const param = {
			memberId,
			authorities
		};
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/memberRoleUpdate.do",
			method : "POST",
			headers,
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(param),
			success(response){
				console.log(response);
				const {msg} = response;
				alert(msg);
				location.reload();
			},
			error : console.log
		});
	});
});
</script>
<%!
	/*"/Users/camilee/workspace/spring_workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/work/Catalina/localhost/spring/org/apache/jsp/index_jsp.java"
	 * 메소드 선언 -> sevlet변환시에 메소드 등록
	 */
	 private boolean hasRole(PageContext pageContext, String role){
		 Member member = (Member) pageContext.getAttribute("member");
		 List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) member.getAuthorities();
		 return authorities.contains(new SimpleGrantedAuthority(role));
	 }
%>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>