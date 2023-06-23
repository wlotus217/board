package com.mystudy.boardSystem.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardVO {
	private int boardId;
	private String title;
	private String content;
	private String createUser;
	private String createDate;
	private boolean isDeleted;
	private boolean isBlind;
	private String modifyUser;
	private String modifyDate;
	
//	
//	public int getBoardId() {
//		return boardId;
//	}
//	public void setBoardId(int boardId) {
//		this.boardId = boardId;
//	}
//	public String getTitle() {
//		return title;
//	}
//	public void setTitle(String title) {
//		this.title = title;
//	}
//	public String getContent() {
//		return content;
//	}
//	public void setContent(String content) {
//		this.content = content;
//	}
//	public String getCreateUser() {
//		return createUser;
//	}
//	public void setCreateUser(String createUser) {
//		this.createUser = createUser;
//	}
//	public String getCreateDate() {
//		return createDate;
//	}
//	public void setCreateDate(String createDate) {
//		this.createDate = createDate;
//	}
//	public boolean isDeleted() {
//		return isDeleted;
//	}
//	public void setDeleted(boolean isDeleted) {
//		this.isDeleted = isDeleted;
//	}
//	public boolean isBlind() {
//		return isBlind;
//	}
//	public void setBlind(boolean isBlind) {
//		this.isBlind = isBlind;
//	}
//	public String getModifyUser() {
//		return modifyUser;
//	}
//	public void setModifyUser(String modifyUser) {
//		this.modifyUser = modifyUser;
//	}
//	public String getModifyDate() {
//		return modifyDate;
//	}
//	public void setModifyDate(String modifyDate) {
//		this.modifyDate = modifyDate;
//	}
//	@Override
//	public String toString() {
//		return "BoardVO [boardId=" + boardId + ", title=" + title + ", content=" + content + ", createUser="
//				+ createUser + ", createDate=" + createDate + ", isDeleted=" + isDeleted + ", isBlind=" + isBlind
//				+ ", modifyUser=" + modifyUser + ", modifyDate=" + modifyDate + "]";
//	}
//
//	
}

