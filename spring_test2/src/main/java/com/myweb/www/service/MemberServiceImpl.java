package com.myweb.www.service;


import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.repository.MemberDAO;
import com.myweb.www.security.MemberVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{

	private final MemberDAO mdao;
	
	@Transactional
	@Override
	public int insert(MemberVO mvo) {
		int isOk = mdao.signup(mvo);
		return mdao.insertAuthInit(mvo.getEmail());
	
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		
		return mdao.updateLastLogin(authEmail) >0 ? true : false;
	}
}
