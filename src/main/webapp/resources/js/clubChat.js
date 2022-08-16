// clubChat.js


document.querySelector("#sendBtn").addEventListener('click', (e) => {
	const msg = document.querySelector("#msgInput").value;
	if(!msg) return;
	
	const payload = {
		chatroomId,
		memberId,
		msg,
		time : Date.now(),
		type : 'CHAT',
		nickname,
		profile
	};
	
	stompClient.send(`/app/chat/${chatroomId}`, {}, JSON.stringify(payload));
	document.querySelector("#msgInput").value = '';
});

setTimeout(() => {
	const container = document.querySelector("#chatList");
	
	const nowMember = memberId;

	stompClient.subscribe(`/app/chat/${chatroomId}`, (message) => {
		console.log(`/app/chat/${chatroomId} : `, message);
		
		const {'content-type' : contentType} = message.headers;
		if(!contentType) return;
		
		const {nickname, msg, time, profile, memberId} = JSON.parse(message.body);
		
		let date = formatDate(new Date(time));
		let html = '';

		if(nowMember == memberId) {
			html = `
				<div class="chatDiv myChatDiv">
					<div class="imgDiv">
						<img 
							class="rounded-circle shadow-1-strong"
							src="/bookie/resources/upload/profile/${profile}"
							style = "width: 40px; height: 40px;" />				
					</div>
					<div class="myChat">
						<span class="nickname">${nickname}</span>
						<span class="chatMsgSpan">${msg}</span>		
						<span class="msgTime" style="text-align: left; margin-right: 5px;">${date}</span>		
					</div>
				</div>`;
		}
		else {
			html = `
				<div class="chatDiv">
					<img 
						class="rounded-circle shadow-1-strong"
						src="/bookie/resources/upload/profile/${profile}" 
						style = "width: 40px; height: 40px;"/>
					<div class="otherChat">
						<span class="nickname">${nickname}</span>
						<span class="chatMsgSpan">${msg}</span>				
						<span class="msgTime" style="text-align: right; margin-right: 10px">${date}</span>
					</div>
				</div>`;
		}
		
		const scrollTop = Math.ceil(container.scrollTop);
		const scrollHeight = container.scrollHeight;
		const innerHeight = $(container).innerHeight();
		
		console.log(scrollTop);
		console.log(scrollHeight);
		console.log(innerHeight);		
		
		
		if(scrollTop + innerHeight >= scrollHeight) {
			// 맨 아래일때
			container.insertAdjacentHTML('beforeend', html);
			container.scrollTop = scrollHeight;
		}
		else {
			// 맨 아래 아닐때
			container.insertAdjacentHTML('beforeend', html);

			const alertDiv = document.querySelector("#alertDiv");
			const alertNickname = document.querySelector("#alertNickname");
			const alertMsg = document.querySelector("#alertMsg");
			
			const height = Math.round($('#chatList').scrollTop()) + 550;
			
			alertNickname.innerHTML = nickname;
			alertMsg.innerHTML = msg;
			alertDiv.style.top = height;

			
			alertDiv.style.display = '';
			
			
		}
		

		
		
	});

}, 500);





function formatDate(date) {
    let d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
        hh = pad(date.getHours(), 2),
        mm = pad(date.getMinutes(), 2)

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;
        
    return [year, month, day].join('/') + " " + hh + ":" + mm;
}

function pad(number, length) {
  var str = '' + number;
  while (str.length < length) {
    str = '0' + str;
  }
  return str;
}






/*
document.querySelector("#sendBtn").addEventListener('click', (e) => {
	const msg = document.querySelector("#msg").value;
	if(!msg) return;
	
	const payload = {
		chatroomId,
		memberId,
		msg,
		time : Date.now(),
		type : 'CHAT'
	};
	
	stompClient.send(`/app/chat/${chatroomId}`, {}, JSON.stringify(payload));
	document.querySelector("#msg").value = '';
});

const lastCheck = () => {
	console.log('lastCheck!!!');
	let payload = {
		chatroomId,
		memberId,
		lastCheck : Date.now(),
		type : "LAST_CHECK" 
	};
	
	stompClient.send("/app/lastCheck", {}, JSON.stringify(payload));
};

window.addEventListener('focus', () => {
	lastCheck();
});

setTimeout(() => {
	const container = document.querySelector("#msg-container");
	
	lastCheck();

	stompClient.subscribe(`/app/chat/${chatroomId}`, (message) => {
		console.log(`/app/chat/${chatroomId} : `, message);
		const {'content-type' : contentType} = message.headers;
		console.log('contentType : ', contentType);
		
		if(!contentType) return;
		
		const {memberId, msg, time} = JSON.parse(message.body);
		const html = `<li class="list-group-item">${memberId} : ${msg}</li>`;
		container.insertAdjacentHTML('beforeend', html);
	});

}, 500);

*/ 
