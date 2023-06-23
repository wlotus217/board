package com.mystudy.boardSystem.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.mystudy.boardSystem.common.paging.SearchDTO;
import com.mystudy.boardSystem.vo.BoardVO;
import com.mystudy.boardSystem.vo.CommonCodeVO;

@Repository
public interface BoardMapper {
	List<BoardVO> getBoard();
	BoardVO getPost(int boardId);
	void createPost(BoardVO boardVo);
	void updatePost(BoardVO boardVo);
	int deletePost(int boardId);
	
	//게시글 리스트 조회
//	List<BoardVO> findAll(SearchDTO params);
//	int count(SearchDTO params);
	
	List<HashMap<String, Object>> findAll(SearchDTO params);
	
	int filterBoard(BoardVO boardVo);
	List<BoardVO> getBlindPost(CommonCodeVO commonCodeVo);
}

