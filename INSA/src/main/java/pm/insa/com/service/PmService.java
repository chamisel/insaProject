package pm.insa.com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import pm.insa.com.mapper.PmMapper;
import pm.insa.com.vo.Member;
import pm.insa.com.vo.PmVo;
import pm.insa.com.vo.PubVo;
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
		//인사 등록 서비스 
		public void insert(PmVo pmVo) {
		System.out.println("[PmService pmVo]"+pmVo);
		System.out.println("[pmMapper]"+pmMapper);
		pmMapper.insert(pmVo); 
		}
		//인사 조회 서비스 
		public void select(PmVo pmVo) {
			System.out.println("[PmService pmVo]"+pmVo);
			System.out.println("[pmMapper]"+pmMapper);
			pmMapper.insert(pmVo); 
		}
		//검색 
		public List<Member> search(Member member) {
			List<Member> list = pmMapper.search(member);
			// TODO Auto-generated method stub
			return list;
		}
		//공통
		public List<PubVo> getCommonCode() {
			List<PubVo> list = pmMapper.getCommonCode();
			return list;
		}
		public void del(int parseInt) {
			pmMapper.del(parseInt);
			
		}
		public void update(Member member) {
			pmMapper.update(member);
		}
		public int getNewSabun() {
			int newSabun = pmMapper.getNewSabun();
			return newSabun;
		}
		public List<PmVo> insaDetail(int sabun) {
			List<PmVo> list = pmMapper.insaDetail(sabun);
			return list;
		}
		public int sabunIncrease() {
			pmMapper.sabunIncrease();
			return 0;
		}
		public List<Member> getAll(){
			List<Member> list = pmMapper.getAll();
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
		//투입 여부 바인딩
		public List<PubVo> putYn(){
			List<PubVo> list = pmMapper.putYn();
			return list;
		}

}
