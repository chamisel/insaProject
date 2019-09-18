package pm.insa.com.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pm.insa.com.service.PmService;
import pm.insa.com.vo.Member;
import pm.insa.com.vo.PmVo;
import pm.insa.com.vo.PubVo;
import pm.insa.com.vo.Test;

@Controller
public class HomeController {
    
	@Autowired
	PmService pmService;
    @RequestMapping(value="/")
    public String index() {
       return "index";
    }
    
    
  //TEST
  	@RequestMapping(value="/test") 
  	public ModelAndView test(HttpServletRequest request, ModelAndView mav) {
  		System.out.println("[pmController test �� ��Ʈ�ѷ�]"); 
  		mav.setViewName("/test");
       return mav;
  	  
  	  }
  	  

  	//TEST
  	@PostMapping("/test") 
  	public ModelAndView test(HttpServletRequest request, ModelAndView mav, Test test) { 
  		System.out.println("[pmController test ��  �׼� ��Ʈ�ѷ�]"+mav);
  		System.out.println("[pmController test]"+test);
  		pmService.test(test);
  		mav.setViewName("/test");
  		return mav;
    
    }//인사 등록 폼 컨트롤러
  	 @GetMapping("/insaInsert") 
  	 public ModelAndView insert(HttpServletRequest request, ModelAndView mav) {
  		System.out.println("[pmController mav"+mav);
  		List<PubVo> putYn = pmService.putYn();
		mav.addObject("putYn", putYn);
  		mav.setViewName("/insaInsert"); 
  		return mav;
  			  
  	}
  	//인사 조회 폼 액션 컨트롤러		
	 @PostMapping("/insaInsert") 
	 public ModelAndView insert(HttpServletRequest request, ModelAndView mav, PmVo pmVo) {
		System.out.println("[pmController mav]"+mav);
		System.out.println("[pmController pmVo]"+pmVo); pmService.insert(pmVo);
		mav.setViewName("/insaInsert"); 
  		return mav;
  			  
  	}

  	//인사 조회 폼 컨트롤러
	@GetMapping("/insaList") 
  	public ModelAndView selectInsa(HttpServletRequest request, ModelAndView mav) {
		System.out.println("[pmController selectInsa]"); 
		mav.setViewName("/insaList");
		return mav;
	
	}
	@RequestMapping(value="existThisMember")
	public @ResponseBody boolean existThisMember(HttpServletRequest request){
		Boolean isExist;
		System.out.println("컨트롤러:::existThisMember:::사번:::"+request.getParameter("sabun"));
		if(request.getParameter("sabun")==null){
			isExist=false;
		}else{
			int sabun = Integer.parseInt(request.getParameter("sabun"));
			if(pmService.insaDetail(sabun)!=null){
				isExist=true;			//있으면 true
			}else{
				isExist=false;			//없으면 false
			}
		}
		System.out.println("컨트롤러:::existThisMember:::"+isExist);
		
		return isExist;
	}
	//리스트 조회
	@RequestMapping("/getAll")
	public ModelAndView getAll(HttpServletRequest request){
		System.out.println("[pmController getAll]");
		ModelAndView mav = new ModelAndView();
		List<Member> list = pmService.getAll();
		System.out.println("[pmController list]"+list);
		mav.addObject("list", list);
		mav.setViewName("/insaList");
		System.out.println("[pmController insaList]"+mav);
		return mav;
	}
	//검색
	@GetMapping("/search")
	@ResponseBody
	public List<Member> search(HttpServletRequest request, ModelAndView mav, Member member) throws Exception{
		System.out.println("[pmController search]");
		List<Member> list = pmService.search(member);
		for(Member m : list){
			System.out.println("컨트롤러 search: "+m.toString());
		}
		mav.addObject("search", list);
		mav.setViewName("/insaList");
		return list;
	}
	//공통 테이블
	@RequestMapping("/getcommonCode")
	@ResponseBody
	public List<PubVo> getCommonCode(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		List<PubVo> getCommonCode = pmService.getCommonCode();
		mav.addObject("getCommonCode", getCommonCode);
		return getCommonCode;
	}
	//삭제 - 수정필요
	@RequestMapping("/del")
	public String del(HttpServletRequest request){
		System.out.println("컨트롤러 del sabun: "+request.getParameter("sabun"));
		pmService.del(Integer.parseInt(request.getParameter("sabun")));
		return "getPage";
	}
	//업데이트
	//입력페이지 초기화시, 새 사번 가져오기
	@RequestMapping("/reset")
	@ResponseBody
	public ModelAndView reset_insertPage(){
		ModelAndView mav = new ModelAndView();
		int newSabun=pmService.getNewSabun();
		System.out.println("[pmController newSabun]"+newSabun);
		mav.addObject("newSabun", newSabun);
		mav.setViewName("/insaInsert");
		return mav;
	}
	//사번 증가
	@RequestMapping("/max")
	public int sabunIncrease(){
		ModelAndView mav = new ModelAndView();
		int newSabun = pmService.sabunIncrease();
		mav.setViewName("/insaInsert");
		return newSabun;
	}
	//상세 보기
	@RequestMapping("/insaDetail")
	public ModelAndView getMember(HttpServletRequest request, @RequestParam("pickSabun") String sabun){
		System.out.println("컨트롤러 getOne : 선택된 사번 : "+sabun);
		ModelAndView mav = new ModelAndView();
		if(sabun!=null){
			List<PmVo> list = pmService.insaDetail(Integer.parseInt(sabun));
			System.out.println("컨트롤러 getOne : 받아온 사람 : "+list.toString());
			System.out.println("resources/image/1-pic_file.jpg : 리얼패스 : "+request.getSession().getServletContext().getRealPath("resources/image/1-pic_file.jpg"));
			mav.addObject("list", list);
			mav.setViewName("/insaDetail");
		}
		return mav;
	}
	//put_yn 바인딩
	@RequestMapping("/putYn")
	public ModelAndView putYn(HttpServletRequest request) {
		System.out.println("[pmController putYn]");
		ModelAndView mav = new ModelAndView();
		
		return mav;
		
	}
}
