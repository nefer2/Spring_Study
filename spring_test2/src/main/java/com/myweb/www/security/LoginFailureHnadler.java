package com.myweb.www.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Getter
@Setter
@Component
public class LoginFailureHnadler implements AuthenticationFailureHandler {

	
	private String authEmail;
	private String errorMassge;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		setAuthEmail(request.getParameter("email"));
		
		//exception 발생시 메시지 저장
		if(exception instanceof BadCredentialsException ||
				exception instanceof InternalAuthenticationServiceException) {
			setErrorMassge(exception.getMessage().toString());
		}
		log.info(">>>> errMsg >>>> " ,errorMassge);
		request.setAttribute("email", getAuthEmail());
		request.setAttribute("errMsg", getErrorMassge());
		request.getRequestDispatcher("/member/login?error").forward(request, response);
	}

}