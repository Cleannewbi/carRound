package dao;

import dto.MemberDto;

public interface iAdminDao {
	
	public boolean deleteUser(int seq);
	
	public boolean regiAdminUser(MemberDto dto);
}
