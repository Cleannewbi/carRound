package dao;

import java.util.List;

import dto.MemberDto;

public interface iMemManager {

	public boolean addMem(MemberDto dto);
	
	public boolean idcheck(String id);
	
	public MemberDto getCom(String comname);
	
	public MemberDto login(String id, String pw);
	
	public MemberDto getMember(String id, int auth);
	
	public List<MemberDto> getUserList();
	
	public List<MemberDto> getComList();
	

}
