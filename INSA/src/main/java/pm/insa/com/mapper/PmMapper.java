package pm.insa.com.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import pm.insa.com.vo.Member;
import pm.insa.com.vo.PmVo;
import pm.insa.com.vo.PubVo;
import pm.insa.com.vo.SearchVo;
import pm.insa.com.vo.Test;

@Mapper
public interface PmMapper {
	//TEST
	public void test(Test test);
	//인사 등록 폼 액션
	public void insert(PmVo pmVo);
	//인사 조회
	public void select();
	//리스트 조회
	public List<Member> getAll();
	//검색 리스트
	public List<PmVo> search(SearchVo svo);
	//공통 테이블
	public List<PubVo> getCommonCode();
	//삭제
	public void del(int sabun);
	//업데이트
	public void update(PmVo pmVo);
	//입력페이지 초기화, 새 사번
	public int getNewSabun();
	//상세보기
	public PmVo insaDetail(int sabun);
	//사번 증가
	public int sabunIncrease();
	//파일 저장
	public void fileSave(String path, String fileName, MultipartFile mFile);
	//파일 db 저장
	public String fileSave(int sabun, String file_type, MultipartFile mFile);
	
	
}
