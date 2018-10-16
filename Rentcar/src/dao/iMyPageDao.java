package dao;

import java.util.List;

import dto.MemberDto;
import dto.RentDto;

public interface iMyPageDao {
	
	public MemberDto getMyPageList(String id); //회원 정보 출력(not list, 1인 개인)
	
	public List<RentDto> getRentPageList(String id); //회원이 사용중인 서비스(car list-it shows 빌린날짜,반납날짜 등)
	
	public boolean updateMyPage(String photo, String phone, String address, String email, String card, int seq); //회원 정보 수정
	
	public boolean deleteMyPage(int seq); //회원 탈퇴
	
	public boolean regiCompany(MemberDto dto); //렌트카 업체 등록
	
	public boolean getId(String id); //렌트카 업체 등록시 id중복 확인
	
	public int getSeq(String id); // 고객아이디를 통해 RC_RENT 정보를 가져오기 위한 함수
	
	public boolean cancelRes(int seq, String id); //예약 취소
	public boolean changeDates(int seq, String start, String end); //예약 날짜 변경
	
	public boolean testStr(String str);
	public boolean testNum(int num);

}
