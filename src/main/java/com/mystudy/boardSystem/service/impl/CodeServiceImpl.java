package com.mystudy.boardSystem.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mystudy.boardSystem.mapper.CodeMapper;
import com.mystudy.boardSystem.service.CodeService;
import com.mystudy.boardSystem.vo.CommonCodeVO;
import com.mystudy.boardSystem.vo.GroupCodeVO;

@Service
public class CodeServiceImpl implements CodeService {
	
	@Autowired
	private CodeMapper codeMapper;
    
    @Override
    public List<GroupCodeVO> getGroupCodeList() {
		return codeMapper.getGroupCodeList();
    }
    @Override
    public GroupCodeVO getOneGroup(GroupCodeVO groupCodeVo) {
    	
    	return codeMapper.getOneGroup(groupCodeVo);
    }
    
    @Override
    public int modifyGroup(GroupCodeVO groupCodeVo) {
    	
		return codeMapper.modifyGroup(groupCodeVo);
    }
    
    @Override
    public int deleteGroup(GroupCodeVO groupCodeVo) {
    	return codeMapper.deleteGroup(groupCodeVo);
    }
    
    @Override
    public int insertGroup(GroupCodeVO groupCodeVo) {
    	return codeMapper.insertGroup(groupCodeVo);
    }
    
    
    @Override
    public List<CommonCodeVO> getCommonCodeList(GroupCodeVO groupCodeVo) {
		return codeMapper.getCommonCodeList(groupCodeVo);
    }
    
    @Override
    public CommonCodeVO getOneCommon(CommonCodeVO commonCodeVo) {
    	return codeMapper.getOneCommon(commonCodeVo);
    }
    
    @Override
    public int modifyCommon(CommonCodeVO commonCodeVo) {
    	return codeMapper.modifyCommon(commonCodeVo);
    }
    
    @Override
    public int deleteCommon(CommonCodeVO commonCodeVo) {
    	return codeMapper.deleteCommon(commonCodeVo);
    }
    
    @Override
    public int insertCommon(CommonCodeVO commonCodeVo) {
    	return codeMapper.insertCommon(commonCodeVo);
    }
    
}
