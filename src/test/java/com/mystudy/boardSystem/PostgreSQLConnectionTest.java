package com.mystudy.boardSystem;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.mystudy.boardSystem.service.BoardService;
import com.mystudy.boardSystem.vo.BoardVO;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class PostgreSQLConnectionTest {
	@Autowired
	BoardService boardService;
	
	
	private String URL = "jdbc:postgresql://localhost:5432/mystudy";
	private String USERNAME = "mystudyuser"; //postgresql 계정
	private String PASSWORD = "1234"; //비밀번호
	
	
	@Test
	public void ConnectionTest() throws Exception{
		Connection con = DriverManager.getConnection(URL,USERNAME,PASSWORD); //db 연결
		System.out.println(con); //연결 정보 출력
		Statement pre = con.createStatement();
		ResultSet rs = pre.executeQuery("select * from board");

		if (rs.next()) {
		    System.out.println(rs);
		    System.out.println(rs.getString("title"));
		}
	}
	
	@Test
	void saveByForeach() {
        for (int i = 1; i <= 1000; i++) {
            BoardVO params = new BoardVO();
            params.setTitle(i + "번 게시글 제목");
            params.setContent(i + "번 게시글 내용");
            params.setCreateUser("테스터" + i);
            boardService.createPost(params);
            
        }
    }
	
}
