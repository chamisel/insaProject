package pm.insa.com.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import pm.insa.com.mapper.PmMapper;
import pm.insa.com.vo.Member;
import pm.insa.com.vo.PmVo;
import pm.insa.com.vo.PubVo;
import pm.insa.com.vo.SearchVo;
import pm.insa.com.vo.Test;

@Service
@Transactional
public class PmService {
	
	@Autowired
	PmMapper pmMapper;
	
		//TEST
		public void test(Test test) {
		System.out.println("[PmService test]"+test);
		pmMapper.test(test);
		}
		
		//인사 등록 폼 액션서비스 
		public void insert(PmVo pmVo) {
		System.out.println("[PmService insert2]"+pmVo);
		System.out.println("[pmMapper]"+pmMapper);
		pmMapper.insert(pmVo);
		
		}
		//인사 조회 서비스 
		public void select(PmVo pmVo) {
			System.out.println("[PmService pmVo]"+pmVo);
			System.out.println("[pmMapper]"+pmMapper);
			pmMapper.select();
	
		}
		//검색 
		public List<PmVo> search(SearchVo searchVo) {
			System.out.println("search 서비스");
			List<PmVo> list = pmMapper.search(searchVo);
			System.out.println("service 가져온 리스트"+list);
			return list;
		}
		//공통
		public List<PubVo> getCommonCode() {
			List<PubVo> list = pmMapper.getCommonCode();
			System.out.println("list"+list);
			return list;
		}
		//삭제
		public void del(int sabun) {
			pmMapper.del(sabun);
			
		}
		//업데이트
		public void update(PmVo pmVo) {
			pmMapper.update(pmVo);
		}
		//사번 증가
		public int getNewSabun() {
			int newSabun = pmMapper.getNewSabun();
			return newSabun;
		}
		//상세보기
		public PmVo insaDetail(int sabun) {
			PmVo list = pmMapper.insaDetail(sabun);
			return list;
		}
		public int sabunIncrease() {
			int newSabun = pmMapper.sabunIncrease();
			return newSabun;
		}
		//전체 검색
		public List<PmVo> getAll(){
			List<PmVo> list = pmMapper.getAll();
			return list;
		}
		
		public String fileSave(String path, String fileName, MultipartFile mFile) {
			pmMapper.fileSave(path, fileName, mFile);
			String fileFullPath = null;
			return fileFullPath;
		}
		public String saveFileToDB(int sabun, String file_type, MultipartFile mFile) {
			pmMapper.fileSave(sabun, file_type, mFile);
			String saveFileDb = null;
			return saveFileDb;
		}

}
