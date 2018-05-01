package kr.or.ddit.auth.dao;

import java.util.List;

import kr.or.ddit.vo.ResourceVO;

public interface IResourcesDAO {
	/**
	 * 보호되는 자원의 목록을 조회
	 * (자원의 URL, 자원에 접근이 허가된 권한들) 
	 * @return
	 */
	public List<ResourceVO> selectResources();
}
