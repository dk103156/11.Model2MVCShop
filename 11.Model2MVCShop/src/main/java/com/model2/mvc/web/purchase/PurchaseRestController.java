package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;


//==> ���Ű��� RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase( @PathVariable int tranNo ) throws Exception {
		
		System.out.println("/purchase/json/getPurchase : GET");
		
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println("getPurchase �� ���� : "+ purchase);
		
		return purchase;		
	}
	
	
	@RequestMapping( value="json/addPurchase", method=RequestMethod.POST )
	public void addPurchase( @RequestBody Purchase purchase ) throws Exception {

		System.out.println("/purchase/json/addPurchase : POST");
		
		//Business Logic			
		purchaseService.addPurchase(purchase);
		System.out.println("addPurchase �� ���� : "+ purchase);
	}
	
	
	@RequestMapping( value="json/updatePurchase", method=RequestMethod.POST)
	public void updatePurchase( @RequestBody Purchase purchase ) throws Exception{

		System.out.println("/purchase/json/updatePurchase : POST");
		//Business Logic
		purchaseService.updatePurchase(purchase);	
		System.out.println("updatePurchase �� ���� : "+ purchase);
	}
	
	
	@RequestMapping( value="json/updateTranCode", method=RequestMethod.POST)
	public void updateTranCode( @RequestBody Purchase purchase ) throws Exception{

		System.out.println("/purchase/json/updateTranCode : POST");
		//Business Logic
		purchaseService.updateTranCode(purchase);	
		System.out.println("updateTranCode �� ���� : "+ purchase);
	}


	@RequestMapping( value="json/getPurchaseList/{buyerId}", method = RequestMethod.GET )
	public Map<String , Object > getPurchaseList(@PathVariable String buyerId) throws Exception{
		
		System.out.println("/purchase/json/getPurchaseList : GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		System.out.println("����(getPurchaseList) ����Ʈ : " + map.get("list"));
		
		map.put("resultPage", resultPage);
		map.put("search", search);		
		
		return map;
	}
	
	
	@RequestMapping( value="json/getSaleList", method=RequestMethod.GET )
	public Map<String , Object > getSaleList() throws Exception{
		
		System.out.println("/purchase/json/getSaleList : GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=purchaseService.getSaleList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
//		List<Purchase> list = (List<Purchase>) map.get("list"); 		
//		System.out.println("�Ǹ�(listSale) ����Ʈ : " + list.get(0));
		
		System.out.println("�Ǹ�(getSaleList) ����Ʈ : " + map.get("list"));
		
		map.put("resultPage", resultPage);
		map.put("search", search);		
		
		return map;
	}
	
	
	
}//end of class