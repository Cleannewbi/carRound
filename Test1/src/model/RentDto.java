/*
DROP TABLE RC_RENT
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_RC_RENT;

CREATE TABLE RC_RENT
   (	SEQ NUMBER(8) PRIMARY KEY, 
		CARNAME VARCHAR2(100) NOT NULL, 
		RC_START DATE NOT NULL, 
		RC_END VARCHAR2(100) NOT NULL, 
		CUS_ID VARCHAR2(100) NOT NULL, 
		COM_NUM NUMBER(8) NOT NULL )
		
CREATE SEQUENCE SEQ_RC_RENT
START WITH 1
INCREMENT BY 1;

ALTER TABLE RC_RENT
ADD CONSTRAINT FK_RC_ID FOREIGN KEY(CUS_ID)
REFERENCES RC_MEMBER(ID);

ALTER TABLE RC_RENT
ADD CONSTRAINT FK_INFO_SEQ FOREIGN KEY(COM_NUM)
REFERENCES RC_INFO(SEQ);
*/

package model;

import java.io.Serializable;

public class RentDto implements Serializable {
	
	private int Rent_seq;
	private String Rent_carname;
	private String Rent_start;
	private String Rent_end;
	private String cus_id;				// MemberDto.Member_id
	private int com_num;				// InfoDto.seq company의seq
	private int price; //총금액
	private String rc_name;
	private String rc_phone;
	private String rc_address;
	private String rc_card;
	private String rc_photo;
	
	public RentDto() {	}

	public RentDto(int rent_seq, String rent_carname, String rent_start, String rent_end, String cus_id, int com_num,
			int price) {
		super();
		Rent_seq = rent_seq;
		Rent_carname = rent_carname;
		Rent_start = rent_start;
		Rent_end = rent_end;
		this.cus_id = cus_id;
		this.com_num = com_num;
		this.price = price;
	}

	public RentDto(String rent_carname, String rent_start, String rent_end, String cus_id, int com_num, int price,
			String rc_name, String rc_phone, String rc_address, String rc_card, String rc_photo) {
		super();
		Rent_carname = rent_carname;
		Rent_start = rent_start;
		Rent_end = rent_end;
		this.cus_id = cus_id;
		this.com_num = com_num;
		this.price = price;
		this.rc_name = rc_name;
		this.rc_phone = rc_phone;
		this.rc_address = rc_address;
		this.rc_card = rc_card;
		this.rc_photo = rc_photo;
	}

	public int getRent_seq() {
		return Rent_seq;
	}

	public void setRent_seq(int rent_seq) {
		Rent_seq = rent_seq;
	}

	public String getRent_carname() {
		return Rent_carname;
	}

	public void setRent_carname(String rent_carname) {
		Rent_carname = rent_carname;
	}

	public String getRent_start() {
		return Rent_start;
	}

	public void setRent_start(String rent_start) {
		Rent_start = rent_start;
	}

	public String getRent_end() {
		return Rent_end;
	}

	public void setRent_end(String rent_end) {
		Rent_end = rent_end;
	}

	public String getCus_id() {
		return cus_id;
	}

	public void setCus_id(String cus_id) {
		this.cus_id = cus_id;
	}

	public int getCom_num() {
		return com_num;
	}

	public void setCom_num(int com_num) {
		this.com_num = com_num;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getRc_name() {
		return rc_name;
	}

	public void setRc_name(String rc_name) {
		this.rc_name = rc_name;
	}

	public String getRc_phone() {
		return rc_phone;
	}

	public void setRc_phone(String rc_phone) {
		this.rc_phone = rc_phone;
	}

	public String getRc_address() {
		return rc_address;
	}

	public void setRc_address(String rc_address) {
		this.rc_address = rc_address;
	}

	public String getRc_card() {
		return rc_card;
	}

	public void setRc_card(String rc_card) {
		this.rc_card = rc_card;
	}

	public String getRc_photo() {
		return rc_photo;
	}

	public void setRc_photo(String rc_photo) {
		this.rc_photo = rc_photo;
	}

	@Override
	public String toString() {
		return "RentDto [Rent_seq=" + Rent_seq + ", Rent_carname=" + Rent_carname + ", Rent_start=" + Rent_start
				+ ", Rent_end=" + Rent_end + ", cus_id=" + cus_id + ", com_num=" + com_num + ", price=" + price
				+ ", rc_name=" + rc_name + ", rc_phone=" + rc_phone + ", rc_address=" + rc_address + ", rc_card="
				+ rc_card + ", rc_photo=" + rc_photo + "]";
	}

	
	
	
}
