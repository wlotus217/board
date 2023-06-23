package com.mystudy.boardSystem.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentVO {
	private int commentId;
	private int boardId;
	private String content;
	private String createUser;
	private String createDate;
	private int parentCommentId;
	private int groupNum;
	private boolean isDeleted;
	private String modifyUser;
	private String modifyDate;
	
	
//	public int getCommentId() {
//		return commentId;
//	}
//	public void setCommentId(int commentId) {
//		this.commentId = commentId;
//	}
//	public int getBoardId() {
//		return boardId;
//	}
//	public void setBoardId(int boardId) {
//		this.boardId = boardId;
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
//	public int getParentCommentId() {
//		return parentCommentId;
//	}
//	public void setParentCommentId(int parentCommentId) {
//		this.parentCommentId = parentCommentId;
//	}
//	public int getGroupNum() {
//		return groupNum;
//	}
//	public void setGroupNum(int groupNum) {
//		this.groupNum = groupNum;
//	}
//	public boolean isDeleted() {
//		return isDeleted;
//	}
//	public void setDeleted(boolean isDeleted) {
//		this.isDeleted = isDeleted;
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
//		return "CommentVO [commentId=" + commentId + ", boardId=" + boardId + ", content=" + content + ", createUser="
//				+ createUser + ", createDate=" + createDate + ", parentCommentId=" + parentCommentId + ", groupNum="
//				+ groupNum + ", isDeleted=" + isDeleted + ", modifyUser=" + modifyUser + ", modifyDate=" + modifyDate
//				+ "]";
//	}
//	
//	
	
}
