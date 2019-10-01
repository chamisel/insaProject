package pm.insa.com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pm.insa.com.service.PmService;
import pm.insa.com.vo.Member;
import pm.insa.com.vo.PmVo;
import pm.insa.com.vo.PubVo;
import pm.insa.com.vo.SearchVo;
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
    
    }

  	//인사 등록 폼 컨트롤러
  	 @GetMapping("/insaInsert") 
  	 public ModelAndView insert(HttpServletRequest request, ModelAndView mav) {
  		System.out.println("[pmController mav"+mav);
		int newSabun = pmService.getNewSabun();
		System.out.println("[pmController newSabun]"+newSabun);
		mav.addObject("newSabun", newSabun);
		mav.setViewName("/insaInsert"); 
  		return mav;
  			  
  	}
  	//인사 등록 폼 액션 컨트롤러		
  	@RequestMapping("/insaInsert")
	 public ModelAndView insert(HttpServletRequest request, ModelAndView mav, @RequestBody PmVo pmVo) {
		System.out.println("[pmController pmVo]"+pmVo);
		pmService.insert(pmVo);
		return mav;
		
  	}

	//인사 조회 폼 컨트롤러
  	@RequestMapping("/insaList") 
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
			System.out.println("컨트롤러:::existThisMember:::"+isExist);
		}else{
			int sabun = Integer.parseInt(request.getParameter("sabun"));
			if(pmService.insaDetail(sabun)!=null){
				isExist=true;			//있으면 true
				System.out.println("컨트롤러:::existThisMember:::"+isExist);
			}else{
				isExist=false;			//없으면 false
				System.out.println("컨트롤러:::existThisMember:::"+isExist);
			}
		}
		System.out.println("컨트롤러:::existThisMember:::"+isExist);
		
		return isExist;
	}
	
	//리스트 조회
	@RequestMapping("/getAll")
	@ResponseBody
	public List<PmVo> getAll(HttpServletRequest request){
		System.out.println("[pmController getAll]");
		ModelAndView mav = new ModelAndView();
		List<PmVo> list = pmService.getAll();
		System.out.println("[pmController list]"+list);
		mav.addObject("list", list);
		mav.setViewName("insaList");
		return list;
	}
	//검색
	@RequestMapping("/search")
	@ResponseBody 
	public List<PmVo> search(HttpServletRequest request,@RequestBody SearchVo searchVo){
		System.out.println("[pmController search]");
		ModelAndView mav = new ModelAndView();
		List<PmVo> list = pmService.search(searchVo);
		System.out.println("controller 가져온 list: "+ list);
		mav.addObject("list", list);
		return list;
	}
	//공통 테이블
	@RequestMapping("/getcommonCode")
	@ResponseBody
	public List<PubVo> getCommonCode(HttpServletRequest request){
		System.out.println("------");
		ModelAndView mav = new ModelAndView();
		List<PubVo> getCommonCode = pmService.getCommonCode();
		System.out.println(getCommonCode);
		mav.addObject("getCommonCode", getCommonCode);
		return getCommonCode;
	}
	//삭제
	@RequestMapping("/del")
	public ModelAndView del(HttpServletRequest request, int sabun){
		System.out.println("컨트롤러 del sabun: "+request.getParameter("sabun"));
		ModelAndView mav = new ModelAndView();
		pmService.del(sabun);
		mav.setViewName("/insaDetail");
		return mav;
		
	}
		
	
	//업데이트
	@RequestMapping("/update")
	 public ModelAndView update(HttpServletRequest request, ModelAndView mav, @RequestBody PmVo pmVo) {
		System.out.println("[pmController pmVo]"+pmVo);
		pmService.update(pmVo);
		mav.setViewName("insaDetail");
		return mav;
		
 	}
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
		System.out.println("컨트롤러 insaDetail : 선택된 사번 : "+sabun);
		ModelAndView mav = new ModelAndView();
		PmVo list = pmService.insaDetail(Integer.parseInt(sabun));
		if(sabun!=null){
			System.out.println("컨트롤러 insaDetail : 받아온 사람 : "+list.toString());
			System.out.println("resources/image/1-pic_file.jpg : 리얼패스 : "+request.getSession().getServletContext().getRealPath("resources/image/1-pic_file.jpg"));
			mav.addObject("list", list);
		}
		mav.setViewName("/insaDetail");
		return mav;
	}
}
