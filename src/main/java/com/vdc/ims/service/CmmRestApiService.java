package com.vdc.ims.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface CmmRestApiService {

	List<Map<String, Object>> getEmp(Map<String, Object> map, HttpSession session) throws Exception;
	List<Map<String, Object>> getDept(Map<String, Object> map, HttpSession session) throws Exception;
	List<Map<String, Object>> getTotalEmp(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> getTotalDept(Map<String, Object> map) throws Exception;


	List<Map<String, Object>> getGrantQue(Map<String, Object> map, HttpSession session) throws Exception;
	List<Map<String, Object>> getGrantCalled(Map<String, Object> map, HttpSession session) throws Exception;
	
	//상담원 어플리케이션 계정 정보 동기화
	List<Map<String, Object>> getAppSyncEmp(Map<String, Object> map, HttpSession session) throws Exception;
	
	//IVR GET SMS msg
	List<Map<String, Object>> getSMSMsg(Map<String, Object> map) throws Exception;
	
	Map<String, Object> getEmpDtl(Map<String, Object> map) throws Exception;
	
	Map<String, Object> getTransTree(Map<String, Object> map) throws Exception;
	
	void setOracleSync(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getGrantBranch(Map<String, Object> map, HttpSession session) throws Exception;

	Map<String, Object> getApiWaitCall(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getCallBack(Map<String, Object> map, HttpSession session) throws Exception;

	//get dept from dnis
	List<Map<String, Object>> getDeptFromDnis(Map<String, Object> map) throws Exception;

}
