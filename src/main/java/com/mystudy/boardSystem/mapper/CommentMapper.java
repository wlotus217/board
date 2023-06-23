package com.mystudy.boardSystem.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.mystudy.boardSystem.vo.CommentVO;

@Repository
public interface CommentMapper {
	
	List<CommentVO> getCommentList(int boardId);
	int getAllCommentCnt(int boardId);
	int createComment(CommentVO commentVo);
	int createChildComment(CommentVO commentVo);
	int updateComment(CommentVO commentVo);
	int deleteComment(CommentVO commentVo);
	List<CommentVO> getChildComment(CommentVO commentVo);
	
}
