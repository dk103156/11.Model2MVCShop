package com.model2.mvc.web.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception {
		
		System.out.println("/product/json/getProduct : GET");
		
		//Business Logic
		Product product = productService.getProduct(prodNo);		
		System.out.println("getProduct 한 정보 : "+ product);
		
		return product;		
	}
	
	
	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public void addProduct( @RequestBody Product product ) throws Exception {

		System.out.println("/product/json/addProduct : POST");
		
		//Business Logic
		System.out.println("::"+product);
		productService.addProduct(product);
		System.out.println("addProduct 한 정보 : "+ product);
	}
	
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST)
	public void updateProduct( @RequestBody Product product ) throws Exception{

		System.out.println("/product/json/updateProduct : POST");
		//Business Logic
		//product.setManuDate(manuDate.replace("-", ""));
		productService.updateProduct(product);		
		System.out.println("updateProduct 한 정보 : "+ product);
	}


	@RequestMapping( value="json/getProductList", method = RequestMethod.GET )
	public Map<String , Object > getProductList() throws Exception{
		
		System.out.println("/product/json/getProductList : GET");
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		 System.out.println("상품 리스트 : " + map.get("list")); 
		 
		map.put("resultPage", resultPage);
		map.put("search", search);		
		
		return map;
	}
	
	
	@RequestMapping( value="json/getProductList", method=RequestMethod.POST )
	public Map<String , Object > getProductList( @RequestBody Search search ) throws Exception{
		
		System.out.println("/product/json/getProductList : POST");
		
		if(search.getCurrentPage() == 0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);		
		System.out.println(resultPage);
		
		 List<Product> list = (List<Product>) map.get("list"); 
		
		 System.out.println("검색 조건에 의한 1번째 상품 리스트 : " + list.get(0)); 
		 
		map.put("resultPage", resultPage);
		map.put("search", search);		
		map.put("list", map.get("list"));
		
		return map;
	}
	
	
	// 오토 컴플릿
	@RequestMapping( value = "json/autoProduct" )
	public List<String> autoProduct ( @RequestBody Map<String, String> jsonMap ) throws Exception {
		
		System.out.println("/product/json/autoProduct : POST");
		
		System.out.println("----------------------------jsonMap----------------------------"+jsonMap);
		List<String> checkData = productService.getAutoProduct(jsonMap.get("dataName"), jsonMap.get("dataType"));
		System.out.println("----------------------------checkData----------------------------"+checkData);
		List<String> autoCommit = new ArrayList<String>();
		
		for ( int i = 0; i < checkData.size(); i++ ) {
			if( ! autoCommit.contains(checkData.get(i)) ) {
				autoCommit.add(checkData.get(i));
			}
		}
		System.out.println("----------------------------autoCommit----------------------------"+autoCommit);
		
		return autoCommit;
	}	
	
	
	
}//end of class