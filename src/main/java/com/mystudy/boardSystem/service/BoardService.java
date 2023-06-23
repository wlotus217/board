package com.mystudy.boardSystem.service;

import java.util.HashMap;
import java.util.List;

import com.mystudy.boardSystem.common.paging.PagingResponse;
import com.mystudy.boardSystem.common.paging.SearchDTO;
import com.mystudy.boardSystem.vo.BoardVO;

public interface BoardService {
	List<BoardVO> getBoard();
	BoardVO getPost(int boardId);
	void createPost(BoardVO boardVo);
	void updatePost(BoardVO boardVo);
	int deletePost(int boardId);
	
	//PagingResponse<BoardVO> findAll(SearchDTO params);
	
	PagingResponse<List<HashMap<String, Object>>> findAll(SearchDTO params);
}
	