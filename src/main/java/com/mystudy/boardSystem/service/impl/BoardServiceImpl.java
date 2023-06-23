package com.mystudy.boardSystem.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mystudy.boardSystem.common.paging.Pagination;
import com.mystudy.boardSystem.common.paging.PagingResponse;
import com.mystudy.boardSystem.common.paging.SearchDTO;
import com.mystudy.boardSystem.mapper.BoardMapper;
import com.mystudy.boardSystem.service.BoardService;
import com.mystudy.boardSystem.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	

	@Autowired 
	private BoardMapper boardMapper;
	
//    '생성자 주입 형태'로 사용합니다.
//    - Autowired 는 권장되지 않기에 생성자 주입 형태로 구성합니다.


//	private final SqlSession sqlSession;
//
//    public BoardServiceImpl(SqlSession ss) {
//        this.sqlSession = ss;
//    }

	
	@Override
	public List<BoardVO> getBoard() {
//		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		return boardMapper.getBoard();
	}
	
	
	@Override
	public BoardVO getPost(int boardId) {
		return boardMapper.getPost(boardId);
	}
	@Override
	public void createPost(BoardVO boardVo) {
		boardMapper.createPost(boardVo);
	}	
	@Override
	public void updatePost(BoardVO boardVo) {
		boardMapper.updatePost(boardVo);
	}
	@Override
	public int deletePost(int boardId) {
		return boardMapper.deletePost(boardId);
	}
	
//	@Override
//	public PagingResponse<BoardVO> findAll(final SearchDTO params) {
//		// 조건에 해당하는 데이터가 없는 경우, 응답 데이터에 비어있는 리스트와 null을 담아 반환
//	  int count = boardMapper.count(params);
//	  if (count < 1) {
//	      return new PagingResponse<>(Collections.emptyList(), null);
//	  }
//	
//	  // Pagination 객체를 생성해서 페이지 정보 계산 후 
//		// SearchDto 타입의 객체인 params에 계산된 페이지 정보 저장
//	  Pagination pagination = new Pagination(count, params);
//	  params.setPagination(pagination);
//	
//	  // 계산된 페이지 정보의 일부(limitStart, recordSize)를 기준으로 
//		// 리스트 데이터 조회 후 응답 데이터 반환
//	  List<BoardVO> list = boardMapper.findAll(params);
//	  return new PagingResponse<>(list, pagination);
//		
//	}
	
	@Override
	public PagingResponse<List<HashMap<String, Object>>> findAll(SearchDTO params) {
		List<HashMap<String, Object>> listMap = boardMapper.findAll(params);
		String count = listMap.get(0).get("total_record_count").toString();
		//System.out.println("전체 글 갯수 :"+count);
		int totalRecordCount = Integer.parseInt(count);
		if (totalRecordCount < 1) {
			return null;
		}
		Pagination pagination = new Pagination(totalRecordCount, params);
		params.setPagination(pagination);
		
		return new PagingResponse(listMap, pagination);
	}
	
}

