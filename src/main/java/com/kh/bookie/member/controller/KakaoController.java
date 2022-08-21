package com.kh.bookie.member.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.bookie.member.model.dto.Member;
import com.kh.bookie.member.model.service.KakaoService;
import com.kh.bookie.member.model.service.MemberService;
import com.kh.bookie.security.model.service.SecurityService;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@AllArgsConstructor
public class KakaoController {
	@Autowired
    private KakaoService kakaoService;
	@Autowired
    private MemberService memberService;
	@Autowired
	private SecurityService securityService;
    
    @GetMapping("/kakao_login.do")
    public String kakaoLogin() {
        StringBuffer loginUrl = new StringBuffer();
        loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
        loginUrl.append("7c60b658a3909ccd7270a7b5be879058"); 
        loginUrl.append("&redirect_uri=");
        loginUrl.append("http://localhost:9090/bookie/kakao_callback"); 
        loginUrl.append("&response_type=code");
        
        return "redirect:"+loginUrl.toString();
    }
    
    @GetMapping("/kakao_callback")
    public String redirectkakao(@RequestParam String code, HttpSession session) throws IOException {
            //접속토큰 get
            String kakaoToken = kakaoService.getReturnAccessToken(code);
            //접속자 정보 get
            Map<String,Object> result = kakaoService.getUserInfo(kakaoToken);
            
            log.debug("kakao result = {}", result);
            
            String snsId = (String) result.get("id"); //토
            String nickname = (String) result.get("nickname");
            String email = (String) result.get("email");
            String password = snsId;
            
            Member member = new Member();
            if(memberService.kakaoLogin(snsId) == null) {
         	   log.debug("카카오로 회원가입");
         	   member.setMemberId(email);
         	   member.setPassword(password);
         	   member.setNickname(nickname);
         	   member.setEmail(email);
         	   member.setSnsId(snsId);
         	   int res = memberService.KakaoJoin(member);
            }
            
     	   log.debug("카카오로 로그인");
     	   String memberId = memberService.findUserIdBySnsId(snsId);
     	   Member vo = (Member) securityService.loadUserByUsername(memberId);
     	   // Authentication
     	   Authentication auth = new UsernamePasswordAuthenticationToken(vo, null, vo.getAuthorities());
     	   SecurityContextHolder.getContext().setAuthentication(auth);
            
            // 로그아웃 처리 시, 사용할 토큰 값 
            session.setAttribute("kakaoToken", kakaoToken);
        return "redirect:/";
    }

}
