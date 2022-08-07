// ws.js

const ws = new SockJS(`http://${location.host}/bookie/stomp`);
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log('open : ', frame);
	
	/*
	// 오픈 시 구독신청
	// 1. 바로 브로커에 가는애
	stompClient.subscribe("/topic/abc", (message) => {
		console.log("/topic/abc : ", message);
	});
	// 2. 한번 핸들러 거쳐 가는애 ex)특정 사용자에게만
	stompClient.subscribe("/app/def", (message) => {
		console.log("/app/def : ", message);
	});
	*/
	
	
	// 전체공지
	stompClient.subscribe("/app/notice", (message) => {
		console.log("/app/notice : ", message);
		const {from, to, msg, time, type} = JSON.parse(message.body);
		console.log(from, to, msg, time, type);
		alert(`
관리자 공지
--------------------------------------------
${msg}
`);
	});
	
	// 개별공지
	stompClient.subscribe(`/app/notice/${memberId}`, (message) => {
		console.log(`/app/notice/${memberId} : `, message);
		const {from, to, msg, time, type} = JSON.parse(message.body);
		console.log(from, to, msg, time, type);
		alert(`${memberId}님 개인공지입니다.
관리자 공지
--------------------------------------------
${msg}
`);
	});
	
	
	
});
