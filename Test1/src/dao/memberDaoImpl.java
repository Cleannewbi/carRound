package dao;

import java.util.List;
import model.MemberDto;

public interface memberDaoImpl {
	public MemberDto getMember(String id, int auth);
	public List<MemberDto> getUserList();
	public List<MemberDto> getComList();
	
}
