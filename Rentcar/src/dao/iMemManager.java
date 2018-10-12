package dao;

import dto.MemberDto;

public interface iMemManager {

	public boolean addMem(MemberDto dto);
	
	public boolean idcheck(String id);
	

}
