package dao;

import java.util.List;

import dto.InfoDto;
import dto.MemberDto;
import dto.ReviewDto;

public interface iBbsDao {

//	public List<BbsDto> getBbsList();
// 통합적인 게시판 dao 
	
/////////////
	public InfoDto getInfoList(int seq);		// 차량 정보
	
	public MemberDto getCom(String comname);	// 회사 정보
	
	public List<ReviewDto> getBbsList(int com_num);	// 리뷰
	
	
}
