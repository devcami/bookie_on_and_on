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
	<div id="point-wrapper" style="position: relative;">
		<div id="month-container">
			<span class="months" data-no="3" style="background: #FFA1A1;" onclick="showOtherMonth(this);">${lastlastMonth}월</span>		
			<span class="months" data-no="2" style="background: #FFD59E;" onclick="showOtherMonth(this);">${lastMonth}월</span>		
			<span class="months" data-no="1" style="background: #FFF8BC;" onclick="showOtherMonth(this);">${month}월</span>		
		</div>
		<c:forEach items="${totalList}" var="list" varStatus="vs">
		
		<c:if test="${vs.count eq 1}">
			 <div class="point-container shadow" id="container${vs.count}" style="background: #FFF8BC;">
			 	<div class="point-top mb-3">
					<h3>${month}월 내역</h3>
				</div>			
		</c:if>
		<c:if test="${vs.count eq 2}">
			 <div class="point-container shadow" id="container${vs.count}" style="display: none; background: #FFD59E;">			
				<div class="point-top mb-3">
					<h3>${lastMonth}월 내역</h3>
				</div>
		</c:if>
		<c:if test="${vs.count eq 3}">
			 <div class="point-container shadow" id="container${vs.count}" style="display: none; background: #FFA1A1;">			
				<div class="point-top mb-3">
					<h3>${lastlastMonth}월 내역</h3>
				</div>
		</c:if>
<%-- 		<c:if test="${list.size() ne 0}"> --%>
			<div class="point-bottom">
				<div id="pointHeader" class="header flex-center-space mb-2">
					<span class="plusMinus">+/-</span>
					<span class="money">금액</span>
					<span class="content">내용</span>
					<span class="occur-date">발생일</span>
					<span class="total-point">누적 포인트</span>			
				</div>
				<c:forEach items="${list}" var="ps">
					<c:if test='${ps.status eq "P"}'>
						<div id="pointDiv${ps.pointNo}" class="pointInOut flex-center-space mb-1 plus">
							<span class="plusMinus" style="color: green;">+</span>
							<span class="money">${ps.point}</span>
							<span class="content">${ps.content}</span>
							<fmt:parseDate value="${ps.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="updatedAt"/>
							<span class="occur-date">
								<fmt:formatDate value="${updatedAt}" pattern="yy/MM/dd HH:mm"/>
							</span>
							<span class="total-point">${ps.totalPoint}</span>
						</div>
					</c:if>
					<c:if test='${ps.status eq "M"}'>
						<div id="pointDiv${ps.pointNo}" class="pointInOut flex-center-space mb-1 minus">
							<span class="plusMinus" style="color: red;">-</span>
							<span class="money">${ps.point}</span>
							<span class="content">${ps.content}</span>
							<fmt:parseDate value="${ps.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="updatedAt"/>
							<span class="occur-date">
								<fmt:formatDate value="${updatedAt}" pattern="yy/MM/dd HH:mm"/>
							</span>
							<span class="total-point">${ps.totalPoint}</span>
						</div>
					</c:if>
				</c:forEach>
			</div>
		
<%-- 		</c:if> --%>
		
<%-- 		<c:if test="${list.size() eq 0}">
			<span style="font-size: 40px; text-align: center; margin-top: 90px;">내역이 없습니다.</span>
		</c:if> --%>
		
		
		</div>
		</c:forEach>
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

const showOtherMonth = (e) => {
	const no = e.dataset.no;
	console.log(no);
	
	const containerId = "#container" + no;
	
	// 모든 포인트 안보이게 해
	$('#container1').css('display', 'none');
	$('#container2').css('display', 'none');
	$('#container3').css('display', 'none');

	// 선택한 월 포인트만 보이게 해
	$(containerId).css('display', '');
	
}

document.querySelector("#btn-charge").addEventListener('click', (e) => {
	// 충전하기 버튼 누르면 모달 보여줘
	$('#paymentModal').modal('show');

	
});

$('#paymentModal').on('hidden.bs.modal', function (e) {
	// 모달 닫길때 모달 안에 입력된 충전 금액 비워
	document.querySelector("#chargePoint").value = '';
	
	getNowDateTime();
});

// 결제 고유 번호 만들어주는 함수
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
	const point = document.querySelector("#chargePoint").value;
	
	// 테스트할때는 천원씩 테스트 할수없어..마이머니.. 테스트 끝나면 풀기
/* 	if(point < 1000){
		alert('포인트는 1000원부터 충전이 가능합니다.');
		return;
	} */

	const headers = {
		"${_csrf.headerName}" : "${_csrf.token}"
	};
	
	const uid = makeUid();
	
  	IMP.init('imp63733866');
  	
  	IMP.request_pay({
  	    pg : 'html5_inicis',
  	    pay_method : 'card',
  	    merchant_uid: uid, // 상점에서 관리하는 주문 번호
  	    name : '포인트 충전',
  	    amount : point,
  	    buyer_email : '${loginMember.email}',
  	    buyer_name : '${loginMember.nickname}',
  	    buyer_tel : '${loginMember.phone}'
  	}, function(rsp) {
  		console.log(rsp);
  	    if ( rsp.success ) {
  	    	
  	    	const param = {
  	    		impUid : rsp.imp_uid,
  	    		memberId : '${loginMember.memberId}',
  	    		content: '포인트 충전',
  	    		point: point,
  	    		status : 'P'
  	  		};
  	    	
  	    	console.log(param);
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
  	    			const {msg, pointStatus} = resp;
  	    			  	    			
   	    			Swal.fire({
  	    		      icon: 'success',
  	    		      title: `\${msg}`
  	    		    });
  	    			
  	    			const dateTime = getNowDateTime();

  	    			// 모달 밖에 지금 충전된 내역 추가해
  	    			const container = document.querySelector("#pointHeader");
  	    			
  	    			const div = `
  	    				<div id="pointDiv\${pointStatus.pointNo}" class="pointInOut flex-center-space mb-1 plus">
		  	  				<span class="plusMinus" style="color: green;">+</span>
		  	  				<span class="money">\${pointStatus.point}</span>
		  	  				<span class="content">\${pointStatus.content}</span>
		  	  				<span class="occur-date">\${dateTime}</span>
		  	  				<span class="total-point">\${pointStatus.totalPoint}</span>
		  	  			</div>`; 
  	    			
  	    			// 모달 밖에 포인트 바꿔
  	    			container.insertAdjacentHTML('afterend', div);
  	    			
  	    			// 모달 밖에 내 포인트도 바꿔
  	    			const myNewPoint = pointStatus.totalPoint + "원"
  	    			document.querySelector('#myPointH4').innerHTML = myNewPoint;
  	    			
  	    			// 모달 안에 인풋 내용 지워 
  	    			document.querySelector("#chargePoint").value = '';

  	    			// 포인트 충전 모달 닫어
  	    			$('#paymentModal').modal('hide'); 
  	    			
  	    		},
  	    		error: console.log
  	    	});
  	    } else {
  	        let msg = '결제가 취소되었습니다.';
  	        
  	        // alert(msg);
  	        
  	     	Swal.fire({
  		      icon: 'error',
  		      title: `\${msg}`,
  		    });
  	     	
  	  		// 모달 안에 인풋 내용 지워 
  			document.querySelector("#chargePoint").value = '';
  	  		
  	   		// 포인트 충전 모달 닫어
  			$('#paymentModal').modal('hide');
 
  	    }
  	});
});

const getNowDateTime = () => {
		const today = new Date();
		
		let yy = today.getFullYear();
		let year = String(yy).substring(2,4);
		console.log(year);
		const month = ('0' + (today.getMonth() + 1)).slice(-2);
		const day = ('0' + today.getDate()).slice(-2);
		const hours = ('0' + today.getHours()).slice(-2); 
		const minutes = ('0' + today.getMinutes()).slice(-2);
		
		const nowDateTime = year + "/" + month + "/" + day + " " + hours + ":" + minutes;
		
		return nowDateTime;
}

// 환불버튼 누르면



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>