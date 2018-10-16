package dao;

import dto.MemberDto;

public interface iMemManager {

	public boolean addMem(MemberDto dto);
	
	public boolean idcheck(String id);
	
	public MemberDto getCom(String comname);
	
	public MemberDto login(String id, String pw);
	

}
