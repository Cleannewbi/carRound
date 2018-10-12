package service;

import dao.memberDao;
import model.MemberDto;

public class memberDaoService implements memberDaoServiceImpl {
	memberDao dao = new memberDao();
	
	@Override
	public MemberDto getMember(String id, int auth) {
		return dao.getMember(id, auth);
	}

}
