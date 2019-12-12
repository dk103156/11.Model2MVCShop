package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 구매관리 Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="addPurchase", method = RequestMethod.GET )
	public String addPurchase(@RequestParam("prodNo") int prodNo, Model model) throws Exception {

		System.out.println("/purchase/addPurchase : GET");
		
		// Business logic 수행
		Product product=productService.getProduct(prodNo);
	
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	
	@RequestMapping( value="addPurchase", method = RequestMethod.POST )
	public String addPurchase( @ModelAttribute("purchase") Purchase purchase, @RequestParam("prodNo") int prodNo, @RequestParam("buyerId") String buyerId) throws Exception {

		System.out.println("/purchase/addPurchase : POST");
		//Business Logic
		User user = new User();
		user.setUserId(buyerId);
		
		Product product = new Product();	
		product.setProdNo(prodNo);
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping( value="getPurchase", method = RequestMethod.GET )
	public String getPurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{

		System.out.println("/purchase/updatePurchase : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model 과 View 연결
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	

	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase( @ModelAttribute("purchase") Purchase purchase, Model model ) throws Exception{

		System.out.println("/purchase/updatePurchase : POST");
		//Business Logic		
		purchaseService.updatePurchase(purchase);
		
		// Model 과 View 연결
		model.addAttribute("purchase", purchaseService.getPurchase(purchase.getTranNo()));
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	
	@RequestMapping( value="listPurchase" )
	public String listPurchase( @ModelAttribute("search") Search search , Model model , HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		User user =(User)session.getAttribute("user");
		Map<String , Object> map = purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	
	@RequestMapping( value="listSale" )
	public String listSale(@ModelAttribute("search") Search search, Model model ) throws Exception {
		
		System.out.println("/purchase/listSale : GET / POST");
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String, Object> map = purchaseService.getSaleList(search);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);

		return "forward:/purchase/listSale.jsp";
	}
	
	
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	public String updateTranCode( @ModelAttribute("search") Search search, @RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode ) throws Exception {
		
		System.out.println("/purchase/updateTranCode : GET");
		
		// Business logic 수행
		Purchase purchase = purchaseService.getPurchase(tranNo);		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
			
		if(tranCode.equals("3")) {
			return "forward:/purchase/listPurchase";
		}else {
			return "forward:/purchase/listSale";
		}
		
		
	}
	
}//end of class