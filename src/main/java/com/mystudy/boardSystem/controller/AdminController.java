package com.mystudy.boardSystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mystudy.boardSystem.paging.Pagination;
import com.mystudy.boardSystem.paging.PagingResponse;
import com.mystudy.boardSystem.paging.SearchDTO;
import com.mystudy.boardSystem.service.CodeService;
import com.mystudy.boardSystem.service.MemberService;
import com.mystudy.boardSystem.vo.CommonCodeVO;
import com.mystudy.boardSystem.vo.GroupCodeVO;
import com.mystudy.boardSystem.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SessionAttributes("member")
@Controller
public class AdminController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CodeService codeService;
	
//	public AdminController(MemberService memberService, CodeService codeService) {
//		super();
//		this.memberService = memberService;
//		this.codeService = codeService;
//	}

	
	@GetMapping("/getMemberList")
	public String getMemberList(@ModelAttribute("params") SearchDTO params,Model model) {
		params.setRecordSize(10);
		PagingResponse<MemberVO> response = memberService.findAll(params);
		List<MemberVO> memberList = response.getList();
		Pagination pagination = response.getPagination();
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("pagination", pagination);
		return "admin/memberList";
	}
//	
//	@GetMapping("/getMemberList")
//	public String getMemberList(Model model) {
//		List<MemberVO> memberList = memberService.getMemberList();
//		model.addAttribute("memberList", memberList);
//		return "admin/memberList";
//	}
	
	@GetMapping("/changeAdmin")
	public String changeAdmin(MemberVO memberVo,Model model) {
		log.info("changeAdmin()실행 / 전달받은 vo : {}",memberVo);
		//System.out.println("changeAdmin()실행 / 전달받은 vo : " + memberVo);
		memberService.changeAdmin(memberVo);
		return "redirect:getMemberList";
	}
	
	@GetMapping("/getFilterBoard")
	public String getFilterBoard() {
		return "admin/filterBoard";
	}
	
	@RequestMapping("/getGroupCodeList")
	@ResponseBody
	public List<GroupCodeVO> getGroupCodeList() {
		log.info("getGroupCodeList컨트롤러 실행");
		//System.out.println("getGroupCodeList컨트롤러 실행");
		List<GroupCodeVO> data = codeService.getGroupCodeList();
		log.info("getGroupCodeList 결과:{} ",data);
		//System.out.println(data);
		return data;
	}
	
	@RequestMapping("/getOneGroup")
	@ResponseBody
	public GroupCodeVO getOneGroup(GroupCodeVO groupCodeVo) {
		log.info("getGroupCodeList컨트롤러 실행");
		//System.out.println("getGroupCodeList컨트롤러 실행");
		GroupCodeVO groupCode = codeService.getOneGroup(groupCodeVo);
		log.info("getOneGroup 결과:{} ",groupCode);
		//System.out.println(groupCode);
		return groupCode;
	}
	
	
	@RequestMapping("/modifyGroup")
	@ResponseBody
	public String modifyGroup(GroupCodeVO groupCodeVo) {
		log.info("modifyGroup컨트롤러 실행 / 그룹코드VO : {}", groupCodeVo);
		//System.out.println("modifyGroup컨트롤러 실행 / 그룹코드VO:"+groupCodeVo);
		int res = codeService.modifyGroup(groupCodeVo);
		
		String result = "";
		if (res == 1) {
			result = "ModifySuccess";
		} else {
			result = "ModifyFailed";
		}
		return result;
	}
	
	
	@RequestMapping("/deleteGroup")
	@ResponseBody
	public String deleteGroup(GroupCodeVO groupCodeVo) {
		log.info("deleteGroup컨트롤러 실행 / 그룹코드VO: {}", groupCodeVo);
		//System.out.println("deleteGroup컨트롤러 실행 / 그룹코드VO:"+groupCodeVo);
		int res= codeService.deleteGroup(groupCodeVo);
		log.info("deleteGroup 결과 : {}", res);
		//System.out.println(res);
		String result = "";
		if (res == 1) {
			result = "DeleteSuccess";
		} else {
			result = "DeleteFailed";
		}
		return result;
	}
	

	
	@RequestMapping("/insertGroup")
	@ResponseBody
	public String insertGroup(GroupCodeVO groupCodeVo) {
		log.info("insertGroupGroup컨트롤러 실행 / 그룹코드VO: {}", groupCodeVo);
		//System.out.println("insertGroupGroup컨트롤러 실행 / 그룹코드VO:"+groupCodeVo);
		int res = codeService.insertGroup(groupCodeVo);
		log.info("insertGroup 결과 : {}", res);
		//System.out.println(res);
		String result = "";
		if (res == 1) {
			result = "InsertSuccess";
		} else {
			result = "InsertFailed";
		}
		return result;
	}
	
	@RequestMapping("/getCommonCodeList")
	@ResponseBody
	public List<CommonCodeVO> getCommonCodeList(GroupCodeVO groupCodeVo) {
		log.info("getCommonCodeList컨트롤러 실행 / 그룹코드VO: {}",groupCodeVo);
		List<CommonCodeVO> data = codeService.getCommonCodeList(groupCodeVo);
		return data;
		
	}
	
	@RequestMapping("/getOneCommon")
	@ResponseBody
	public CommonCodeVO getOneCommon(CommonCodeVO commonCodeVo) {
		log.info("getOneCommon컨트롤러 실행");
		CommonCodeVO commonCode = codeService.getOneCommon(commonCodeVo);
		log.info("공통코드:{}",commonCode);
		return commonCode;
	}
	
	
	@RequestMapping("/modifyCommon")
	@ResponseBody
	public String modifyCommon(CommonCodeVO commonCodeVo) {
		log.info("modifyCommon컨트롤러 실행 / 공통코드VO:{}",commonCodeVo);
		int res = codeService.modifyCommon(commonCodeVo);
		log.info("modifyCommon 결과: {}", res);
		String result = "";
		if (res == 1) {
			result = "ModifySuccess";
		} else {
			result = "ModifyFailed";
		}
		return result;
	}
	
	
	@RequestMapping("/deleteCommon")
	@ResponseBody
	public String deleteCommon(CommonCodeVO commonCodeVo) {
		log.info("deleteCommon컨트롤러 실행 / 공통코드VO: {}" , commonCodeVo);
		int res= codeService.deleteCommon(commonCodeVo);
		log.info("deleteCommon 결과: {}",res);
		String result = "";
		if (res == 1) {
			result = "DeleteSuccess";
		} else {
			result = "DeleteFailed";
		}
		return result;
	}
	

	
	@RequestMapping("/insertCommon")
	@ResponseBody
	public String insertCommon(CommonCodeVO commonCodeVo) {
		log.info("insertCommon컨트롤러 실행 / 공통코드VO: {}",commonCodeVo);
		int res = codeService.insertCommon(commonCodeVo);
		log.info("insertCommon 결과: {}",res);
		String result = "";
		if (res == 1) {
			result = "InsertSuccess";
		} else {
			result = "InsertFailed";
		}
		return result;
	}
	
	
}
