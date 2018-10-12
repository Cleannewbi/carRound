/*
	SEQ NUMBER(8) PRIMAY KEY, 
	CUS_ID VARCHAR2(100 BYTE) NOT NULL, 
	TITLE VARCHAR2(1000 BYTE) NOT NULL, 
	CONTENT VARCHAR2(2000 BYTE) NOT NULL, 
	WDATE DATE NOT NULL, 
	DELNUM NUMBER(8) NOT NULL
*/

package dto;

import java.io.Serializable;

public class ReviewDto implements Serializable {
	
	private int Review_seq;
	private String Review_cus_id;
	private String Review_title;
	private String Review_content;
	private String Review_date;
	private int delnum;
	private int com_num;
	
	public int getCom_num() {
		return com_num;
	}
	public void setCom_num(int com_num) {
		this.com_num = com_num;
	}
	public int getReview_seq() {
		return Review_seq;
	}
	public void setReview_seq(int review_seq) {
		Review_seq = review_seq;
	}
	public String getReview_cus_id() {
		return Review_cus_id;
	}
	public void setReview_cus_id(String review_cus_id) {
		Review_cus_id = review_cus_id;
	}
	public String getReview_title() {
		return Review_title;
	}
	public void setReview_title(String review_title) {
		Review_title = review_title;
	}
	public String getReview_content() {
		return Review_content;
	}
	public void setReview_content(String review_content) {
		Review_content = review_content;
	}
	public String getReview_date() {
		return Review_date;
	}
	public void setReview_date(String review_date) {
		Review_date = review_date;
	}
	public int getDelnum() {
		return delnum;
	}
	public void setDelnum(int delnum) {
		this.delnum = delnum;
	}
	
	public ReviewDto(int review_seq, String review_cus_id, String review_title, String review_content,
			String review_date, int delnum, int com_num) {
		super();
		Review_seq = review_seq;
		Review_cus_id = review_cus_id;
		Review_title = review_title;
		Review_content = review_content;
		Review_date = review_date;
		this.delnum = delnum;
		this.com_num = com_num;
	}
	@Override
	public String toString() {
		return "ReviewDto [Review_seq=" + Review_seq + ", Review_cus_id=" + Review_cus_id + ", Review_title="
				+ Review_title + ", Review_content=" + Review_content + ", Review_date=" + Review_date + ", delnum="
				+ delnum + "]";
	}
	
}
