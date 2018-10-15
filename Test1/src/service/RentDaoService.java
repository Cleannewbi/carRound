package service;

import dao.RentDao;
import model.RentDto;

public class RentDaoService implements RentDaoServiceImpl {
	RentDao dao = new RentDao();
	
	@Override
	public boolean setReservation(RentDto rDto, int infoSeq) {
		return dao.setReservation(rDto, infoSeq);
	}
	
}
