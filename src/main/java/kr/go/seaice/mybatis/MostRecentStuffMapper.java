package kr.go.seaice.mybatis;

import java.util.HashMap;
import java.util.List;

import kr.go.seaice.arctic.timeseries.service.MostRecentStuffVO;


public interface MostRecentStuffMapper {
    public MostRecentStuffVO retrieveOneArcticData();
    public MostRecentStuffVO retrieveMatchingArcticData(HashMap<String, String> hashmap);
    public List<MostRecentStuffVO> retrieveMatchingArcticDataList(HashMap<String, String> hashmap);
    public MostRecentStuffVO retrieveOneArcticData_monthly();
    public MostRecentStuffVO retrieveMatchingArcticData_monthly(HashMap<String, String> hashmap);
    public List<MostRecentStuffVO> retrieveMatchingArcticDataList_monthly(HashMap<String, String> hashmap);
    
}
