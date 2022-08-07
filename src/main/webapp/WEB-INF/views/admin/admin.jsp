<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css" />


<sec:authentication property="principal" var="loginMember" scope="page"/>
<fmt:requestEncoding value="utf-8"></fmt:requestEncoding>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자페이지" name="title"/>
</jsp:include>

<section id="content">


</section>




<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>