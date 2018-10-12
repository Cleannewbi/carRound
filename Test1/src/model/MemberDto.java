/*
DROP TABLE RC_MEMBER
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_RC_MEMBER;

CREATE TABLE RC_MEMBER
   ( SEQ NUMBER(8) NOT NULL, 
     ID VARCHAR2(100) PRIMARY KEY, 
     PASSWORD VARCHAR2(100) NOT NULL, 
     PHOTO VARCHAR2(2000), 
     NAME VARCHAR2(100) NOT NULL, 
     PHONE VARCHAR2(100) NOT NULL, 
     ADDRESS VARCHAR2(100) NOT NULL, 
     EMAIL VARCHAR2(100) NOT NULL, 
     CARD VARCHAR2(100) NOT NULL );
     
CREATE SEQUENCE SEQ_RC_MEMBER
START WITH 1
INCREMENT BY 1;

*/

package model;

import java.io.Serializable;

public class MemberDto implements Serializable {
	
	private int Member_seq;
	private String Member_id;
	private String Member_pw;
	private String Member_Photo;	//member 운전면허증번호
	private String Member_name;
	private String Member_phone;
	private String Member_address;
	private String Member_email;
	private String Member_card;			// xxxx-xxxx-xxxx-xxxx	->	xxxxxxxxxxxxxxxx
	
	public int getMember_seq() {
		return Member_seq;
	}
	public void setMember_seq(int member_seq) {
		Member_seq = member_seq;
	}
	public String getMember_id() {
		return Member_id;
	}
	public void setMember_id(String member_id) {
		Member_id = member_id;
	}
	public String getMember_pw() {
		return Member_pw;
	}
	public void setMember_pw(String member_pw) {
		Member_pw = member_pw;
	}
	public String getMember_Photo() {
		return Member_Photo;
	}
	public void setMember_Photo(String member_Photo) {
		Member_Photo = member_Photo;
	}
	public String getMember_name() {
		return Member_name;
	}
	public void setMember_name(String member_name) {
		Member_name = member_name;
	}
	public String getMember_phone() {
		return Member_phone;
	}
	public void setMember_phone(String member_phone) {
		Member_phone = member_phone;
	}
	public String getMember_address() {
		return Member_address;
	}
	public void setMember_address(String member_address) {
		Member_address = member_address;
	}
	public String getMember_email() {
		return Member_email;
	}
	public void setMember_email(String member_email) {
		Member_email = member_email;
	}
	public String getMember_card() {
		return Member_card;
	}
	public void setMember_card(String member_card) {
		Member_card = member_card;
	}
	
	// Insert
	public MemberDto(int member_seq, String member_id, String member_pw, String member_Photo, String member_name,
			String member_phone, String member_address, String member_email, String member_card) {
		super();
		Member_seq = member_seq;
		Member_id = member_id;
		Member_pw = member_pw;
		Member_Photo = member_Photo;
		Member_name = member_name;
		Member_phone = member_phone;
		Member_address = member_address;
		Member_email = member_email;
		Member_card = member_card;
	}
	
	// 결제정보시 사용
	public MemberDto(String member_id, String member_name, String member_phone, String member_card) {
		super();
		Member_id = member_id;
		Member_name = member_name;
		Member_phone = member_phone;
		Member_card = member_card;
	}
	
	@Override
	public String toString() {
		return "MemberDto [Member_seq=" + Member_seq + ", Member_id=" + Member_id + ", Member_pw=" + Member_pw
				+ ", Member_Photo=" + Member_Photo + ", Member_name=" + Member_name + ", Member_phone=" + Member_phone
				+ ", Member_address=" + Member_address + ", Member_email=" + Member_email + ", Member_card="
				+ Member_card + "]";
	}
	
	
	

}
