package dao;

import java.util.List;

import dto.InfoDto;

public interface iInfoDao {
	
	public List<InfoDto> getInfoList();
	
	public List<InfoDto> getChecked(String datas[]);
	
	public InfoDto getInfoList(int seq);
	
	public List<InfoDto> getInfoSearchableList(String carname, String comname, String rentAddress, String startDate, String startTime, String endDate, String endTime);

}
