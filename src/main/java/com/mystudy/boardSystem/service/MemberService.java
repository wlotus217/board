package com.mystudy.boardSystem.service;

import java.util.List;

import com.mystudy.boardSystem.paging.PagingResponse;
import com.mystudy.boardSystem.paging.SearchDTO;
import com.mystudy.boardSystem.vo.MemberVO;

public interface MemberService {
	MemberVO getMember(MemberVO memberVO);
	int register(MemberVO memberVo);
	List<MemberVO> getMemberList();
	int changeAdmin(MemberVO memberVo);
	MemberVO getMemberInfo(String id);
	
	PagingResponse<MemberVO> findAll(SearchDTO params);
}
