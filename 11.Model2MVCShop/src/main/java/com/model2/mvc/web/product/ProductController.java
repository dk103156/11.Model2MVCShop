package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> ��ǰ���� Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	//@RequestMapping("/addProductView.do")
	//public String addProductView() throws Exception {
	@RequestMapping( value="addProduct", method=RequestMethod.GET )
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	
	//@RequestMapping("/addProduct.do")
//	@RequestMapping( value="addProduct", method=RequestMethod.POST )
//	public String addProduct( @ModelAttribute("product") Product product ) throws Exception {
//
//		System.out.println("/product/addProduct : POST");
//		//Business Logic
//		product.setManuDate(product.getManuDate().replace("-", ""));
//		productService.addProduct(product);
//		
//		return "forward:/product/addProduct.jsp";
//	}
	
	
//	���Ͼ��ε� ���
//	�ڡڡ� tomcat �� �����ϴ� ��� ( �߰����ڸ��� ȭ�鿡 �ٷ� ������ ) �ڡڡ�
//	private static final String UPLOAD_PATH_TOMCAT = "C:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\11.Model2MVCShop\\images\\uploadFiles"; 

//	�ڡڡ� git workspace �� �����ϴ� ��� ( �ε��Ǵµ� �ð��� �� �ɷ��� �߰� �� ��ǰ�˻��ؼ� ���� ����... ) �ڡڡ�
	private static final String UPLOAD_PATH = "C:\\Users\\user\\git\\11.Model2MVCShop\\11.Model2MVCShop\\WebContent\\images\\uploadFiles";
	
	// ���� �߰� �� :: Spring Multiple FileUpload Test
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@RequestParam("uploadFiles") ArrayList<MultipartFile> fileName, @ModelAttribute("product") Product product) throws Exception {
		
		String result = "";
		int i = 0;
		System.out.println("/product/addProduct : POST");
		for (MultipartFile files : fileName) {
			i++;
			result += saveFile(files);
			if (i != fileName.size()) {
				result += ":";
			}
		}
		System.out.println("result : " + result);
		
		//Business Logic
		product.setManuDate(product.getManuDate().replace("-", ""));
		product.setFileName(result);
		System.out.println("fileNameList : " + product.getFileNameList());
	
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}


	
	//@RequestMapping("/getProduct.do")
	@RequestMapping( value="getProduct", method=RequestMethod.GET )
	public String getProduct( @RequestParam("prodNo") int prodNo , @RequestParam("menu") String menu, Model model, HttpServletRequest request, HttpServletResponse response ) throws Exception {
				
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model �� View ����
		model.addAttribute("product", product);
		model.addAttribute("prodNo", prodNo);
		
		// ��ǰ Ŭ���ϴ� ���ÿ� �����丮 �߰�
		this.addHistory(request, response);
		
		if(menu.equals("manage")) {
			return "forward:/product/updateProductView.jsp";
		}else {
			return "forward:/product/getProduct.jsp";
		}
	}
	
	//@RequestMapping("/updateProduct.do")
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @RequestParam("uploadFiles") ArrayList<MultipartFile> fileName, @ModelAttribute("product") Product product, Model model ) throws Exception{

		String result = "";
		int i = 0;
		System.out.println("/product/updateProduct : POST");
		for (MultipartFile files : fileName) {
			i++;
			result += saveFile(files);
			if (i != fileName.size()) {
				result += ":";
			}
		}
		System.out.println("result : " + result);
		
		//Business Logic
		product.setManuDate(product.getManuDate().replace("-", ""));
		product.setFileName(result);
		
		productService.updateProduct(product);
		model.addAttribute("product", productService.getProduct(product.getProdNo()) );	
		
		return "forward:/product/readProduct.jsp?prodNo=" + product.getProdNo() + "&menu=manage";
	}
	
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping( value="listProduct" )
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("list2", map.get("list2"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
	// �ֱ� �� ��ǰ
	@RequestMapping("getHistory")
	public String getHistory(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		String history = null;
		String[] h = null;
		Cookie[] cookies = request.getCookies();

		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				System.out.println("\t\t\t\t Cookie : " + cookie.getName());
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
					System.out.println("\t\t\t\t getHistory cookie : " + history);
				}
			}
		}

		if (history != null) {
			h = history.split(",");
		}

		model.addAttribute("h", h);
		
		return "forward:/history.jsp";
	}
	
	
	// �ֱ� �� ��ǰ
	private void addHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Cookie[] cookies = request.getCookies();
		String tempValue = "";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("history")) {
					String cValue = (String) cookies[i].getValue();
					tempValue += cValue + ",";
				}
			}
		}
		tempValue += request.getParameter("prodNo");
		Cookie cookie = new Cookie("history", tempValue);
		System.out.println("\t\t\t\t controller history : " + tempValue);
		response.addCookie(cookie);
	}
	
	
	// ���� ���� �ڡڡ�
	private String saveFile(MultipartFile file) {

//	�̸� �ߺ����� �ʰ� �����̸� ����
		UUID uuid = UUID.randomUUID();
		String saveName = uuid + "_" + file.getOriginalFilename();

		System.out.println("File Save Name : " + saveName);

		File saveFile = new File(UPLOAD_PATH, saveName);
//		File saveFileTomcat = new File(UPLOAD_PATH_TOMCAT, saveName);

		try {
			file.transferTo(saveFile);
//			file.transferTo(saveFileTomcat);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return saveName;
	}
	
	
	
	
}