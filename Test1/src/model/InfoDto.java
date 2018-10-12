/*
DROP TABLE RC_INFO
CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_RC_INFO;

CREATE TABLE RC_INFO
   (   SEQ NUMBER(8) PRIMARY KEY, 
       COM_NAME VARCHAR2(100) NOT NULL, 
       CAR_PIC VARCHAR2(2000), 
       CAR_NAME VARCHAR2(100) NOT NULL, 
       CAR_TYPE VARCHAR2(100) NOT NULL, 
       CAR_FUEL VARCHAR2(100) NOT NULL, 
       CAR_SIZE VARCHAR2(100) NOT NULL, 
       CAR_FEE VARCHAR2(100) NOT NULL )

CREATE SEQUENCE SEQ_RC_INFO
START WITH 1
INCREMENT BY 1;

INSERT INTO RC_INFO
VALUES (1, 'TEST COMPANY', null, 'K5 Hybrid', '승용차', '전기', '중형', '43,000')

INSERT INTO RC_INFO
VALUES (2, 'TEST COMPANY', null, 'K5', '승용차', 'LPG', '중형', '45,000')

INSERT INTO RC_INFO
VALUES (3, 'TEST COMPANY', null, '2019 아반떼', '승용차', 'LPG', '중형', '40,000')

*/

package model;

import java.io.Serializable;

public class InfoDto implements Serializable {
	
	private int Info_seq;
	private String Com_name;
	private String Car_pic;		// MemberDto에서는 photo로 되어있음.. 혼동주의
	private String Car_name;
	private String Car_type;	// suv, 승용차, 승합차
	private String Car_fuel;
	private String Car_size;	// 소형, 중형, 대형
	private String Car_fee;
	
	
	
	public int getInfo_seq() {
		return Info_seq;
	}
	public void setInfo_seq(int info_seq) {
		Info_seq = info_seq;
	}
	public String getCom_name() {
		return Com_name;
	}
	public void setCom_name(String com_name) {
		Com_name = com_name;
	}
	public String getCar_pic() {
		return Car_pic;
	}
	public void setCar_pic(String car_pic) {
		Car_pic = car_pic;
	}
	public String getCar_name() {
		return Car_name;
	}
	public void setCar_name(String car_name) {
		Car_name = car_name;
	}
	public String getCar_type() {
		return Car_type;
	}
	public void setCar_type(String car_type) {
		Car_type = car_type;
	}
	public String getCar_fuel() {
		return Car_fuel;
	}
	public void setCar_fuel(String car_fuel) {
		Car_fuel = car_fuel;
	}
	public String getCar_size() {
		return Car_size;
	}
	public void setCar_size(String car_size) {
		Car_size = car_size;
	}
	public String getCar_fee() {
		return Car_fee;
	}
	public void setCar_fee(String car_fee) {
		Car_fee = car_fee;
	}
	
	public InfoDto(int info_seq, String com_name, String car_pic, String car_name, String car_type, String car_fuel,
			String car_size, String car_fee) {
		super();
		Info_seq = info_seq;
		Com_name = com_name;
		Car_pic = car_pic;
		Car_name = car_name;
		Car_type = car_type;
		Car_fuel = car_fuel;
		Car_size = car_size;
		Car_fee = car_fee;
	}
	
	@Override
	public String toString() {
		return "InfoDto [Info_seq=" + Info_seq + ", Com_name=" + Com_name + ", Car_pic=" + Car_pic + ", Car_name="
				+ Car_name + ", Car_type=" + Car_type + ", Car_fuel=" + Car_fuel + ", Car_size=" + Car_size
				+ ", Car_fee=" + Car_fee + "]";
	}
	

}
