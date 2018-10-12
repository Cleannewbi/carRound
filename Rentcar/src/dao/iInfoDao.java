package dao;

import java.util.List;

import dto.InfoDto;

public interface iInfoDao {
	
	public List<InfoDto> getInfoList();
	
	public List<InfoDto> getChecked(String datas[]);
	
	

}
