package com.model2.mvc.web.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST )
	public void addUser( @RequestBody User user ) throws Exception {

		System.out.println("/user/json/addUser : POST");
		
		//Business Logic
		userService.addUser(user);
		System.out.println("addUser 한 정보 : "+ user);

	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		User user = userService.getUser(userId);
		System.out.println("getUser 한 정보 : "+ user);
		return user;
	}
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public void updateUser( @RequestBody User user, HttpSession session) throws Exception{

		System.out.println("/user/json/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		System.out.println("updateUser 한 정보 : "+ user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
	
	}
	

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			System.out.println("로그인 성공했다 !!!");
		}else {
			System.out.println("로그인 실패 !!!");
		}
		
		return dbUser;
	}
	
	
	@RequestMapping( value="json/checkDuplication/{userId}", method=RequestMethod.POST )
	public boolean checkDuplication( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/checkDuplication : POST");
		
		//Business Logic		
		boolean result = userService.checkDuplication(userId);
		
		if(!result) {
			System.out.println("이미 존재하는 ID 입니다.");
		}else {
			System.out.println("회원 가입 가능합니다.");
		}
		
		return result;
	}
	
	
	@RequestMapping( value="json/getUserList", method = RequestMethod.GET )
	public Map<String , Object > getUserList() throws Exception{
		
		System.out.println("/user/json/getUserList : GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
//		System.out.println("유저 리스트 : " + map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	
	@RequestMapping( value="json/getUserList", method=RequestMethod.POST )
	public Map<String , Object > getUserList( @RequestBody Search search, HttpServletRequest request) throws Exception{
		
		System.out.println("/user/json/getUserList : POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
//		List<User> list = (List<User>) map.get("list");
//		
//		System.out.println("검색 조건에 의한 1번째 유저 리스트 : " + list.get(0));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	
}