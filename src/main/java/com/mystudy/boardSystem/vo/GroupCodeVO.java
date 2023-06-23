package com.mystudy.boardSystem.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GroupCodeVO {
	private int groupCode;
	private String codeName;
	private String createUser;
	private String createDate;
	private String modifyUser;
	private String modifyDate;
	private boolean isDeleted;
	
	
//	public int getGroupCode() {
//		return groupCode;
//	}
//	public void setGroupCode(int groupCode) {
//		this.groupCode = groupCode;
//	}
//	public String getCodeName() {
//		return codeName;
//	}
//	public void setCodeName(String codeName) {
//		this.codeName = codeName;
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
//	
//	public boolean isDeleted() {
//		return isDeleted;
//	}
//	public void setDeleted(boolean isDeleted) {
//		this.isDeleted = isDeleted;
//	}
//	@Override
//	public String toString() {
//		return "GroupCodeVO [groupCode=" + groupCode + ", codeName=" + codeName + ", createUser=" + createUser
//				+ ", createDate=" + createDate + ", modifyUser=" + modifyUser + ", modifyDate=" + modifyDate
//				+ ", isDeleted=" + isDeleted + "]";
//	}
//	
//	
}
