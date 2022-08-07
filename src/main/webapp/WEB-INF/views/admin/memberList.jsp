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

<div class="container">
      <div class="row">
        <div class="col-12">
          <div class="btn-group">
            <a href="${pageContext.request.contextPath}/admin/report.do" class="btn red"    id="report" >신고</a>
            <a href="${pageContext.request.contextPath}/admin/Q&A.do" class="btn purple" id="question">Q & A</a>
            <a href="${pageContext.request.contextPath}/admin/management.do" class="btn green"  id="management">회원 관리</a>
          </div>
        </div>
      </div>
    </div>

    <div class="container">
      <table class="table table-fixed">
        <thead>
          <tr>
            <th type="head-line" class="col-xs-2">회원 아이디</th>
            <th type="head-line" class="col-xs-2">이름</th>
            <th type="head-line" class="col-xs-4">E-mail</th>
            <th type="head-line" class="col-xs-4">핸드폰 번호</th>
            <th type="head-line" class="col-xs-4">성별</th>
            <th type="head-line" class="col-xs-3">잔여 포인트</th>
            <th type="head-line" class="col-xs-3">권한</th>
         
          </tr>
        </thead>
        <tbody>
          <tr data-member-id="${member.memberId}">
            <th class="col-xs-2">${member.memberId}</th>
            <th class="col-xs-2">${member.name}</th>
            <th class="col-xs-3">${member.email}</th>
            <th class="col-xs-3">${member.phone}</th>
            <th class="col-xs-3">${member.gender}</th>
            <th class="col-xs-3">${member.point}</th>
            <td>					
              <input type="checkbox" name="authority" id="role-user-${vs.count}" value="ROLE_USER"  <%= hasRole(pageContext, "ROLE_USER") ? "checked" : "" %>/>
              <label for="role-user-${vs.count}">일반</label>
              &nbsp;
              <input type="checkbox" name="authority" id="role-admin-${vs.count}" value="ROLE_ADMIN" <%= hasRole(pageContext, "ROLE_ADMIN") ? "checked" : "" %>//>
              <label for="role-admin-${vs.count}">관리자</label>
          </td>
          </tr>
    
        
        </tbody>
      </table>
    </div>
<section id="content">


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
	/**
	 * 메소드선언 -> servlet변환시에 메소드등록
	 */
	private boolean hasRole(PageContext pageContext, String role){
		Member member = (Member) pageContext.getAttribute("member");
		List<SimpleGrantedAuthority> authorities = (List<SimpleGrantedAuthority>) member.getAuthorities();
		return authorities.contains(new SimpleGrantedAuthority(role));
	}

%>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>