package com.vdc.ims.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vdc.ims.common.dao.AbstractDAO;
 
/**
 * @author Mir
 *
 */
@Repository("cmmEtcDAO")
public class CmmEtcDAO extends AbstractDAO{

    @Resource(name="sqlSessionMain")
    private SqlSessionTemplate sqlSession;

	//메인 대쉬보드
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> MainDash(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.MainDash", map);
    }
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> MainDashPrev(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.MainDashPrev", map);
    }





    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getMenu(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.getMenu", map);
    }

    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getMenu() throws Exception{
        return selectList(sqlSession, "cmmEtc.getMenu");
    }


	/**
	 * 서버 모니터링 관리
	*/
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getSvr(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.getSvr");
    }
    public void addSvr(Map<String, Object> map) throws Exception{
        insert(sqlSession, "cmmEtc.addSvr", map);
    }
    public void edtSvr(Map<String, Object> map) throws Exception{
        update(sqlSession, "cmmEtc.edtSvr", map);
    }
    public void delSvr(Map<String, Object> map) throws Exception{
    	update(sqlSession, "cmmEtc.delSvr", map);
    }
	/**
	 * 서버 모니터링 프로세스 등록
	*/
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getProc(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.getProc", map);
    }
    public void addProc(Map<String, Object> map) throws Exception{
        insert(sqlSession, "cmmEtc.addProc", map);
    }
    public void edtProc(Map<String, Object> map) throws Exception{
        update(sqlSession, "cmmEtc.edtProc", map);
    }
    public void delProc(Map<String, Object> map) throws Exception{
    	update(sqlSession, "cmmEtc.delProc", map);
    }
    
    /**
     * 녹취 청취 이력
     * */
    /*
    @SuppressWarnings("unchecked")
    public List<List<Object>> getListenHist(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.getListenHist", map);
    }
    */








	/*
	 * 총괄 현황 엑셀 다운로드
	 * */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExcelStt(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.ExcelStt", map);
    }
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExcelYearStt(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.ExcelYearStt", map);
    }
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExcelYearTotalStt(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.ExcelYearTotalStt", map);
    }

	/*
	 * 개인현황 엑셀 다운로드
	 * */
    @SuppressWarnings("unchecked")
    public Map<String, Object> WeekDay(Map<String, Object> map) throws Exception{
        return (Map<String, Object>) selectOne(sqlSession, "cmmEtc.WeekDay", map);
    }
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> Week(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.Week", map);
    }


    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getDnisList(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.DnisList", map);
    }
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getDeptList(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.DeptList", map);
    }
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getDivList(Map<String, Object> map) throws Exception{
        return selectList(sqlSession, "cmmEtc.DivList", map);
    }
    
}
