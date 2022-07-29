package com.kh.bookie.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;

import com.kh.bookie.member.model.dto.Member;

/**
 * 개발서버 reload될때 SecurityContext의 Authentication#principal이 empty Member객체로 대체되는 오류가 있다.
 * 
 * EmptyPrincipalCheckFilter 처리내용
 * 1. 저장된 authentication을 AnonymousAuthenticationToken으로 대체.
 * 2. remember-me cookie를 이용한 자동인증을 위해 redirect처리
 */
@WebFilter("/*")
public class EmptyPrincipalCheckFilter extends HttpFilter implements Filter {
       
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//System.out.println("authentication = " + authentication); 
		//System.out.println("isAuthenticated() = " + authentication.isAuthenticated()); // always true
		if(authentication != null && authentication.isAuthenticated()) {
			Object principal = authentication.getPrincipal(); // anonymousAuthentication인 경우 "anonymousUser" 문자열 
			System.out.println("principal = " + principal);
			if(principal instanceof String) {
				System.out.println("principal is String!");
			}
			else if(principal instanceof Member) {
				System.out.println("principal is Member!");
				Member loginMember = (Member) principal;
				if(loginMember != null && loginMember.getMemberId() == null) {
					System.out.println("anounymous authentication 변경!");
					// AnonymousAuthenticationToken(String key, Object principal, Collection<? extends GrantedAuthority> authorities)
					Authentication anonymousAuthentication = new AnonymousAuthenticationToken("1234", "anonymousUser", AuthorityUtils.createAuthorityList("ROLE_ANONYMOUS"));
					SecurityContextHolder.getContext().setAuthentication(anonymousAuthentication);
					
					// remember-me token 사용을 위한 redirect
					HttpServletRequest httpReq = (HttpServletRequest) request; 
					HttpServletResponse httpRes = (HttpServletResponse) response;
					String qs = httpReq.getQueryString(); 
					String location = httpReq.getRequestURI();
					location += (qs != null) ? "?" + qs : "";
					httpRes.sendRedirect(location);
				}
			}
				
		}
		
		
		chain.doFilter(request, response);
	}


}
