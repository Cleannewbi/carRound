package dao;

import model.MemberDto;

public interface memberDaoImpl {
	public MemberDto getMember(String id, int auth);
}
