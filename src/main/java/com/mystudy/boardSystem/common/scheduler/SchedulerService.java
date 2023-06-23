package com.mystudy.boardSystem.common.scheduler;

import java.time.LocalTime;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.mystudy.boardSystem.common.mail.MailService;
import com.mystudy.boardSystem.mapper.BoardMapper;
import com.mystudy.boardSystem.mapper.CodeMapper;
import com.mystudy.boardSystem.mapper.MemberMapper;
import com.mystudy.boardSystem.vo.BoardVO;
import com.mystudy.boardSystem.vo.CommonCodeVO;
import com.mystudy.boardSystem.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SchedulerService {
	
	private final SqlSession sqlSession;

    public SchedulerService(SqlSession ss) {
        this.sqlSession = ss;
    }
    
    
	@Scheduled(fixedRate=600000) //10분
	public void filterBoard() {
		log.info("------------------------[비속어필터링] 10분 마다 실행 => time : {} --------------------------------" , LocalTime.now());
		//System.out.println("10분 마다 실행 => time : " + LocalTime.now());
		
		CodeMapper codeMapper = sqlSession.getMapper(CodeMapper.class);
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		
		//비속어리스트 조회
		List<CommonCodeVO> commoncodeList = codeMapper.getBadWord();
		
		for (CommonCodeVO commonCodeVo: commoncodeList) {
			List<BoardVO> blindBoardList = boardMapper.getBlindPost(commonCodeVo);
			for (BoardVO blindBoard: blindBoardList) {
				int result = boardMapper.filterBoard(blindBoard);
				if(result == 1) {
					log.info("비속어 : {}" , commonCodeVo);
					log.info("필터링 된 글 : {}" , blindBoard);
//					System.out.println("비속어 :" +commonCodeVo);
//					System.out.println("필터링 된 글 :" +blindBoard);
					
					MailService mailService = new MailService();
					
					MemberVO member = memberMapper.getMemberInfo(blindBoard.getCreateUser());
					log.info("필터링된 글 작성자 정보: {}" , member);
//					System.out.println("필터링된 글 작성자 정보:" + member);
					
					mailService.sendMailBlind(member.getEmail(),blindBoard);
					
				}else {
					
				}
			}
		}
		
		
		
	}
	
}
