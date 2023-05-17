package com.vdc.ims.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface CmmEtcService {
	
	/*메인 대쉬보드*/
	
	List<Map<String, Object>> MainDash(Map<String, Object> map, HttpSession session) throws Exception;
	List<Map<String, Object>> MainDashPrev(Map<String, Object> map, HttpSession session) throws Exception;

	
	//메뉴
	List<Map<String, Object>> getMenu(Map<String, Object> map, HttpSession session) throws Exception;
	
	/**
	 * 서버 모니터링 관리
	*/
	List<Map<String, Object>> getSvr(Map<String, Object> map) throws Exception;
	void addSvr(Map<String, Object> map, HttpSession session) throws Exception;
	void edtSvr(Map<String, Object> map, HttpSession session) throws Exception;
	void delSvr(Map<String, Object> map, HttpSession session) throws Exception;

	/**
	 * 서버 모니터링 프로세스 등록 
	*/
	List<Map<String, Object>> getProc(Map<String, Object> map) throws Exception;
	void addProc(Map<String, Object> map, HttpSession session) throws Exception;
	void edtProc(Map<String, Object> map, HttpSession session) throws Exception;
	void delProc(Map<String, Object> map, HttpSession session) throws Exception;


	/*
	 * 총괄 현황 엑셀 다운로드 
	 * */
	List<Map<String, Object>> ExcelStt(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> ExcelYearStt(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> ExcelYearTotalStt(Map<String, Object> map) throws Exception;
	
	/*
	 * 개인 현황 엑셀 다운로드 
	 * */
	Map<String, Object> WeekDay(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> Week(Map<String, Object> map) throws Exception;

	// dnis info
	List<Map<String, Object>> getDnisList(Map<String, Object> map) throws Exception;
	// dept info
	List<Map<String, Object>> getDeptList(Map<String, Object> map) throws Exception;
	// div info
	List<Map<String, Object>> getDivList(Map<String, Object> map) throws Exception;
}
