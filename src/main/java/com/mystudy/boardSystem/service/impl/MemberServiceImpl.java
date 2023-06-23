package com.mystudy.boardSystem.service.impl;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mystudy.boardSystem.mapper.MemberMapper;
import com.mystudy.boardSystem.paging.Pagination;
import com.mystudy.boardSystem.paging.PagingResponse;
import com.mystudy.boardSystem.paging.SearchDTO;
import com.mystudy.boardSystem.service.MemberService;
import com.mystudy.boardSystem.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
    @Override
    public MemberVO getMember(MemberVO memberVo) {
		return memberMapper.getMember(memberVo);
    }
    
    @Override
    public int register(MemberVO memberVo) {
    	return memberMapper.register(memberVo);
    }
    
    @Override
    public List<MemberVO> getMemberList() {
    	return memberMapper.getMemberList();
    }
    
    @Override
    public int changeAdmin(MemberVO memberVo) {
    	
    	if (memberVo.getAdmin().equals("admin")) { //어드민이 admin일 경우 regular로 변경
    		memberVo.setAdmin("regular");
    	}else if (memberVo.getAdmin().equals("regular")) { //어드민이 regular일 경우 admin으로 변경
    		memberVo.setAdmin("admin");
    	}
    	return memberMapper.changeAdmin(memberVo);
    }
    
    @Override
    public MemberVO getMemberInfo(String id) {
    	return memberMapper.getMemberInfo(id);
    }
    @Override
    public PagingResponse<MemberVO> findAll(SearchDTO params) {
    	int count = memberMapper.count(params);
        if (count < 1) {
            return new PagingResponse<>(Collections.emptyList(), null);
        }
    	
        Pagination pagination = new Pagination(count, params);
        params.setPagination(pagination);
        
        List<MemberVO> list = memberMapper.findAll(params);
        return new PagingResponse<>(list, pagination);
        
    }
}
