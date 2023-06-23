package com.mystudy.boardSystem.service;

import java.util.List;

import com.mystudy.boardSystem.vo.CommentVO;

public interface CommentService {
	
	List<CommentVO> getCommentList(int boardId);
	int getAllCommentCnt(int boardId);
	int createComment(CommentVO commentVo);
	int updateComment(CommentVO commentVo);
	int deleteComment(CommentVO commentVo);
	List<CommentVO> getChildComment(CommentVO commentVo);
	
}
