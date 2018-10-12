package service;

import model.MemberDto;

public interface memberDaoServiceImpl {
	public MemberDto getMember(String id, int auth);

}
