package com.mystudy.boardSystem.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.mystudy.boardSystem.paging.SearchDTO;
import com.mystudy.boardSystem.vo.MemberVO;

@Repository
public interface MemberMapper {
	MemberVO getMember(MemberVO memberVo);
	int register(MemberVO memberVo);
	List<MemberVO> getMemberList();
	int changeAdmin(MemberVO memberVo);
	MemberVO getMemberInfo(String id);
	
	List<MemberVO> findAll(SearchDTO params);
	int count(SearchDTO params);
}
