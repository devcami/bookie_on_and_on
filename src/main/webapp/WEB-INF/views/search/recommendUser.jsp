<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recommendUser.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="유저 추천" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<section id="content">
	
</section>

<script>
// 로드할 때 member 들 중 interest가 같은 넘들 List가져와 (하나씩)
const interest = '${member.interest}';
// console.log(interest.split(',')); 
const interests = interest.split(','); // 배열
window.addEventListener('load', () => {
	interests.forEach((i) => {
		console.log(i);
	});
});



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>