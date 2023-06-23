package com.mystudy.boardSystem.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mystudy.boardSystem.common.paging.Pagination;
import com.mystudy.boardSystem.common.paging.PagingResponse;
import com.mystudy.boardSystem.common.paging.SearchDTO;
import com.mystudy.boardSystem.service.BoardService;
import com.mystudy.boardSystem.service.CommentService;
import com.mystudy.boardSystem.vo.BoardVO;
import com.mystudy.boardSystem.vo.CommentVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
	
//	public BoardController(BoardService boardService, CommentService commentService) {
//		super();
//		this.boardService = boardService;
//		this.commentService = commentService;
//	}
	
//	@GetMapping("/getBoard")
//	public String getBoard(@ModelAttribute("params") SearchDTO params,Model model) {
//		PagingResponse<BoardVO> response = boardService.findAll(params);
//		List<BoardVO> boardList = response.getList();
//		Pagination pagination = response.getPagination();
//		
//        model.addAttribute("boardList", boardList);
//        model.addAttribute("pagination", pagination);
//        
//        return "board/boardList";
//	}
	
	@GetMapping("/getBoard")
	public String getBoard(@ModelAttribute("params") SearchDTO params,Model model) {
		log.info("getBoard() 컨트롤러 실행");
		//System.out.println("getBoard() 컨트롤러 실행");
		PagingResponse<List<HashMap<String, Object>>> list = boardService.findAll(params);
		List<HashMap<String, Object>> boardList = list.getList();
		Pagination pagination =  list.getPagination();
		
		//System.out.println(boardList.toString());
		model.addAttribute("boardList",boardList);
		model.addAttribute("pagination",pagination);
    
        return "board/boardList";
	}
	@GetMapping("/createPost")
	public String createPost(Model model,int page) {
		model.addAttribute("page", page);
		return "board/createPost";
	}
	
	@PostMapping("/createPost")
	public String createPost(Model model,BoardVO boardVo) {
		boardService.createPost(boardVo);
		return "redirect:getBoard";
	}
	
	@GetMapping("/goUpdatePost")
	public String goUpdatePost(Model model,int boardId,int page) {
		BoardVO post = boardService.getPost(boardId);
		log.info("getPost:{}", post);
		model.addAttribute("post", post);
		model.addAttribute("page", page);
		return "board/updatePost";
	}
	
	@PostMapping("/updatePost")
	public String updatePost(Model model,BoardVO boardVo,int page) {
		boardService.updatePost(boardVo);
		return "redirect:getPost?boardId="+boardVo.getBoardId()+"&page="+page;
	}
	
	@RequestMapping("/deletePost")
	public String deletePost(Model model,int boardId, int page) {
		boardService.deletePost(boardId);
		return "redirect:getBoard?page="+page;
	}
	
	@RequestMapping("/getPost")
	public String getPost(Model model, int boardId, int page) {
		model.addAttribute("page", page);
		log.info("boardId: {}" , boardId);
		BoardVO post = boardService.getPost(boardId);
		model.addAttribute("post", post);

		int commentCnt = commentService.getAllCommentCnt(boardId);
		model.addAttribute("commentCnt", commentCnt);
		log.info("댓글갯수: {}" ,commentCnt);
		
		return "board/post";
	}
	
	
	@RequestMapping("/getCommentCnt")
	@ResponseBody
	public int getCommentCnt(int boardId){
		int commentCnt = commentService.getAllCommentCnt(boardId);
		log.info("getCommentCnt실행 - 댓글갯수: {}" , commentCnt);
		return commentCnt;
	}

	@RequestMapping("/getCommentList")
	@ResponseBody
	public List<CommentVO> getCommentList(int boardId){
		List<CommentVO> commentList = commentService.getCommentList(boardId);
		return commentList;
	}
	
	@PostMapping("/createComment")
	@ResponseBody
	public String createComment(CommentVO commentVo) {
		log.info("createComment 전달받은댓글: {}" , commentVo);
		int res = commentService.createComment(commentVo);
		String result = "";
		if (res == 1) {
			result = "InsertSuccess";
		}
	
		log.info("입력한댓글: {}",commentVo);
		return result;
	}
	
	@PostMapping("/updateComment")
	@ResponseBody
	public String updateComment(CommentVO commentVo) {
		log.info("updateComment 전달받은댓글: {}", commentVo);
		int res = commentService.updateComment(commentVo);
		String result = "";
		if (res == 1) {
			result = "UpdateSuccess";
		}
		return result;
	}
	
	@RequestMapping("/deleteComment")
	@ResponseBody
	public String deleteComment(CommentVO commentVo) {
		log.info("deleteComment전달받은값: {}" , commentVo);
		int res = commentService.deleteComment(commentVo);
		String result = "";
		if (res == 1) {
			result = "DeleteSuccess";
		}
		return result;
	}
	
	
	@RequestMapping("/getChildComment")
	@ResponseBody
	public String getChildComment(CommentVO commentVo) {
		List<CommentVO> childComment = commentService.getChildComment(commentVo);
		String result = "";
		if (childComment.size() != 0) {
			result = "Exist";
		} else {
			result = "Nothing";
		}
		return result;
	}
	
	
}
