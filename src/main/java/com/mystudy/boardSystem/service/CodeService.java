package com.mystudy.boardSystem.service;

import java.util.List;

import com.mystudy.boardSystem.vo.CommonCodeVO;
import com.mystudy.boardSystem.vo.GroupCodeVO;

public interface CodeService {
	List<GroupCodeVO> getGroupCodeList();
	GroupCodeVO getOneGroup(GroupCodeVO groupCodeVo);
	int modifyGroup(GroupCodeVO groupCodeVo);
	int deleteGroup(GroupCodeVO groupCodeVo);
	int insertGroup(GroupCodeVO groupCodeVo);
	
	List<CommonCodeVO> getCommonCodeList(GroupCodeVO groupCodeVo);
	CommonCodeVO getOneCommon(CommonCodeVO commonCodeVo);
	int modifyCommon(CommonCodeVO commonCodeVo);
	int deleteCommon(CommonCodeVO commonCodeVo);
	int insertCommon(CommonCodeVO commonCodeVo);
	
}
