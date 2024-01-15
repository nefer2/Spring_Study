package com.myweb.www.repository;

import java.util.List;

import com.myweb.www.security.AuthVO;
import com.myweb.www.security.MemberVO;

public interface MemberDAO {

	int signup(MemberVO mvo);

	MemberVO getUser(String email);

	int insertAuthInit(String email);

	MemberVO selectEmail(String username);

	List<AuthVO> selectAuth(String username);

	int updateLastLogin(String authEmail);

}
		