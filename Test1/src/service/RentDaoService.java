package service;

import dao.RentDao;
import model.RentDto;

public class RentDaoService implements RentDaoServiceImpl {
	RentDao dao = new RentDao();
	
	@Override
	public boolean setReservation(RentDto rDto) {
		return dao.setReservation(rDto);
	}
	
}
