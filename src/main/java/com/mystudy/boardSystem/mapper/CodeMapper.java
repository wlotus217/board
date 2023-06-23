package com.mystudy.boardSystem.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.mystudy.boardSystem.vo.CommonCodeVO;
import com.mystudy.boardSystem.vo.GroupCodeVO;

@Repository
public interface CodeMapper {
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
	
	List<CommonCodeVO> getBadWord();
}
