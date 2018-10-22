package dao;

import java.util.List;
import model.MemberDto;
import model.ReviewDto;

public interface memberDaoImpl {
	public MemberDto getMember(String id, int auth);
	public List<MemberDto> getUserList();
	public List<MemberDto> getComList();
}
