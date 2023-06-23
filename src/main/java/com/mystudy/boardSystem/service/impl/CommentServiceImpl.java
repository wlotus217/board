package com.mystudy.boardSystem.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mystudy.boardSystem.mapper.CommentMapper;
import com.mystudy.boardSystem.service.CommentService;
import com.mystudy.boardSystem.vo.CommentVO;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private CommentMapper commentMapper;
	
    @Override
    public List<CommentVO> getCommentList(int boardId) {
    	return commentMapper.getCommentList(boardId);
    }
    
    @Override
    public int getAllCommentCnt(int boardId) {
    	return commentMapper.getAllCommentCnt(boardId);
    }
	@Override
	public int createComment(CommentVO commentVo) {
		if(commentVo.getParentCommentId() == 0) { //부모댓글 insert
			return commentMapper.createComment(commentVo);
		}
		else{ //대댓글 insert
			return commentMapper.createChildComment(commentVo);
		}
		
	}

	@Override
	public int updateComment(CommentVO commentVo) {
		return commentMapper.updateComment(commentVo);
	}

	@Override
	public int deleteComment(CommentVO commentVo) {
		return commentMapper.deleteComment(commentVo);
	}
	
	@Override
	public List<CommentVO> getChildComment(CommentVO commentVo) {
		return commentMapper.getChildComment(commentVo);
	}
}
