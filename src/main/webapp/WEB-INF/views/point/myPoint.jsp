<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPoint.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나의 포인트" name="title"/>
</jsp:include>
<sec:authentication property="principal" var="loginMember"/>
<section id="content">

	<div id="myPointDiv" class="mt-3 mb-5">
		<div id="myPointDiv-left">
			<img src="${pageContext.request.contextPath}/resources/images/icon/point-icon.png" alt="포인트" style="width: 70px; height : 80px;">
			<h1 class="ml-2 mr-3">나의 포인트 : </h1>
			<h1 id="myPointH4">${loginMember.point}원</h1>			
		</div>
		<div id="btn-div">
			<button id="btn-charge" class="or-btn">충전하기</button>			
			<button id="btn-withdraw" class="ml-1 or-btn">출금하기</button>					
		</div>

	</div>
	<div id="point-container" class="shadow">
		<div id="point-top" class="mb-3">
			<h3>7월 내역</h3>
		</div>
		<div id="point-bottom">
			<div id="header" class="flex-center-space mb-2">
				<span class="plusMinus">+/-</span>
				<span class="money">금액</span>
				<span class="content">내용</span>
				<span class="occur-date">발생일</span>
				<span class="total-point">누적 포인트</span>			
			</div>
			<div id="" class="pointInOut flex-center-space mb-1 plus">
				<span class="plusMinus" style="color: green;">+</span>
				<span class="money">10000</span>
				<span class="content">포인트 충전</span>
				<span class="occur-date">22/09/15 17:53</span>
				<span class="total-point">20000</span>
			</div>
			<div id="" class="pointInOut flex-center-space mb-1 minus">
				<span class="plusMinus" style="color: red;">-</span>
				<span class="money">5000</span>
				<span class="content">북클럽 디파짓 반환</span>
				<span class="occur-date">22/09/10 22:28</span>
				<span class="total-point">20000</span>
			</div>
			<div id="" class="pointInOut flex-center-space mb-1 plus">
				<span class="plusMinus">+</span>
				<span class="money">10000</span>
				<span class="content">북클럽 미션 수행</span>
				<span class="occur-date">22/09/15 17:53</span>
				<span class="total-point">30000</span>
			</div>
		</div>
	</div>

</section>



<!-- 결제모달 -->
<div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">포인트 충전</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <span id="mBody-span1">충전을 원하는 금액을 입력해주세요.</span>
        <span id="mBody-span2">포인트는 1000원부터 충전이 가능합니다.</span>
        <div id="input-div" class="mt-2">
	        <input type="text" name="chargePoint" id="chargePoint" dir="rtl" />
			<span>원</span>  
        </div>
      </div>
      <div class="modal-footer">
		<button type="button" id="charge-btn" class="btn ow-btn">충전하기</button>      
      </div>
    </div>
  </div>
</div>





<script>
document.querySelector("#btn-charge").addEventListener('click', (e) => {
	// 충전하기 버튼 누르면 모달 보여줘
	$('#paymentModal').modal('show');

	
});

$('#paymentModal').on('hidden.bs.modal', function (e) {
	// 모달 닫길때 모달 안에 입력된 충전 금액 비워
	document.querySelector("#chargePoint").value = '';
	console.log("${loginMember.enrollDate}")
});

const makeUid = () => {
	const memberId = "${loginMember.username}";
	
	let today = new Date();
	
	let year = today.getFullYear();
	let month = ('0' + (today.getMonth() + 1)).slice(-2);
	let day = ('0' + today.getDate()).slice(-2);
	let hours = ('0' + today.getHours()).slice(-2); 
	let minutes = ('0' + today.getMinutes()).slice(-2);
	let seconds = ('0' + today.getSeconds()).slice(-2); 
	
	const uid = memberId + year + month + day + hours + minutes + seconds;
	
	return uid
}

document.querySelector("#charge-btn").addEventListener('click', (e) => {

	const headers = {
		"${_csrf.headerName}" : "${_csrf.token}"
	};
	
	const uid = makeUid();
	const point = document.querySelector("#chargePoint").value;
	
  	IMP.init('imp63733866');
  	
  	IMP.request_pay({
  	    pg : 'html5_inicis',
  	    pay_method : 'card',
  	    merchant_uid: uid, // 상점에서 관리하는 주문 번호
  	    name : '포인트 충전',
  	    amount : point,
  	    buyer_email : 'jyjmjs2@naver.com',
  	    buyer_name : '${loginMember.nickname}',
  	    buyer_tel : '010-1234-5678',
  	    buyer_addr : '서울특별시 강남구 삼성동',
  	    buyer_postcode : '123-456'
  	}, function(rsp) {
  		console.log(rsp);
  	    if ( rsp.success ) {
  	    	
  	    	const param = {
  	    		imp_uid : rsp.imp_uid
  	  		};
  	    	
  	    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
  	    	$.ajax({
  	    		url: "${pageContext.request.contextPath}/point/chargeMyPoint.do", //cross-domain error가 발생하지 않도록 주의해주세요
  	    		type: 'POST',
  	    		headers,
  	    		contentType : 'application/json; charset=utf-8',
  	    		dataType: 'json',
  	    		data: JSON.stringify(param),
  	    		success(resp){
  	    			console.log(resp);
  	    		},
  	    		error: console.log
  	    	});
  	    } else {
  	        var msg = '결제에 실패하였습니다.';
  	        msg += '에러내용 : ' + rsp.error_msg;
  	        
  	        alert(msg);
  	    }
  	});
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>