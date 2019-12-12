package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;


/*
 *	FileName :  PurchaseServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test )
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����, DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)

//==> Meta-Data �� �پ��ϰ� Wiring ����...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	//@Test
	public void testAddPurchase() throws Exception {
				
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();
		
			product.setProdNo(10050);
		purchase.setPurchaseProd(product);
			user.setUserId("user19");
		purchase.setBuyer(user);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("�տ���");
		purchase.setReceiverPhone("111-1111-1111");
		purchase.setDivyAddr("õ���");
		purchase.setDivyRequest("�ٵο�");
		purchase.setTranCode("1");
		purchase.setDivyDate("2019-11-11");
		
		purchaseService.addPurchase(purchase);
		
		purchase = purchaseService.getPurchase(10073); // tranNo

		//==> console Ȯ��
		//System.out.println(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals(10050, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user19", purchase.getBuyer().getUserId());
		Assert.assertEquals("1  ", purchase.getPaymentOption());
		Assert.assertEquals("�տ���", purchase.getReceiverName());
		Assert.assertEquals("111-1111-1111", purchase.getReceiverPhone());
		Assert.assertEquals("õ���", purchase.getDivyAddr());
		Assert.assertEquals("�ٵο�", purchase.getDivyRequest());
		Assert.assertEquals("1  ", purchase.getTranCode());
		Assert.assertEquals("2019-11-11 00:00:00.0", purchase.getDivyDate());
	}
	
	//@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
//		Product product = new Product();
//		User user = new User();
		//==> �ʿ��ϴٸ�...
//			product.setProdNo(10050);
//		purchase.setPurchaseProd(product);
//			user.setUserId("user19");
//		purchase.setBuyer(user);
//		purchase.setPaymentOption("1");
//		purchase.setReceiverName("�տ���");
//		purchase.setReceiverPhone("111-1111-1111");
//		purchase.setDivyAddr("õ���");
//		purchase.setDivyRequest("�ٵο�");
//		purchase.setTranCode("1");
//		purchase.setDivyDate("2019-11-11");
		
		purchase = purchaseService.getPurchase(10073); // tranNo

		//==> console Ȯ��
		//System.out.println(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals(10050, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user19", purchase.getBuyer().getUserId());
		Assert.assertEquals("1  ", purchase.getPaymentOption());
		Assert.assertEquals("�տ���", purchase.getReceiverName());
		Assert.assertEquals("111-1111-1111", purchase.getReceiverPhone());
		Assert.assertEquals("õ���", purchase.getDivyAddr());
		Assert.assertEquals("�ٵο�", purchase.getDivyRequest());
		Assert.assertEquals("1  ", purchase.getTranCode());
		Assert.assertEquals("2019-11-11 00:00:00.0", purchase.getDivyDate());

		Assert.assertNotNull(purchaseService.getPurchase(10051));
		Assert.assertNotNull(purchaseService.getPurchase(10052));
	}
	
	//@Test
	 public void testUpdatePurchase() throws Exception{
		 
		Purchase purchase = purchaseService.getPurchase(10073); // tranNo
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(10050, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user19", purchase.getBuyer().getUserId());
		Assert.assertEquals("1  ", purchase.getPaymentOption());
		Assert.assertEquals("�տ���", purchase.getReceiverName());
		Assert.assertEquals("111-1111-1111", purchase.getReceiverPhone());
		Assert.assertEquals("õ���", purchase.getDivyAddr());
		Assert.assertEquals("�ٵο�", purchase.getDivyRequest());
		Assert.assertEquals("1  ", purchase.getTranCode());
		Assert.assertEquals("2019-11-11 00:00:00.0", purchase.getDivyDate());

		purchase.setPaymentOption("2");
		purchase.setReceiverName("����ȣ");
		purchase.setReceiverPhone("999-9999-9999");
		purchase.setDivyAddr("����");
		purchase.setDivyRequest("������");
		purchase.setDivyDate("2019-11-22");
		
		purchaseService.updatePurchase(purchase);		
		
		purchase = purchaseService.getPurchase(10073); // tranNo
		Assert.assertNotNull(purchase);
		
		//==> console Ȯ��
		//System.out.println(purchase);
			
		//==> API Ȯ��
		Assert.assertEquals("2  ", purchase.getPaymentOption());
		Assert.assertEquals("����ȣ", purchase.getReceiverName());
		Assert.assertEquals("999-9999-9999", purchase.getReceiverPhone());
		Assert.assertEquals("����", purchase.getDivyAddr());
		Assert.assertEquals("������", purchase.getDivyRequest());
		Assert.assertEquals("1  ", purchase.getTranCode());
		Assert.assertEquals("2019-11-22 00:00:00.0", purchase.getDivyDate());
	 }
	 
	 
	 //@Test
	 public void testUpdateTranCode() throws Exception{
		 
		Purchase purchase = purchaseService.getPurchase(10072); // tranNo
		Assert.assertNotNull(purchase);		

		purchase.setTranCode("1");

		purchaseService.updateTranCode(purchase);		
		
		purchase = purchaseService.getPurchase(10072); // tranNo
		Assert.assertNotNull(purchase);
		
		//==> console Ȯ��
		System.out.println(purchase);
			
		//==> API Ȯ��
		Assert.assertEquals("2  ", purchase.getTranCode());
	 }
	 
	
	 //==>  �ּ��� Ǯ�� �����ϸ�....
	 @Test
	 public void testGetPurchaseListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String, Object> map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
		for (int i =0 ;  i < list.size() ; i++) {
			System.out.println( "<"+ ( i +1 )+"> ��° ���Ÿ�� => "+ list.get(i).toString() );
		}
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console Ȯ��
//		for (int i =0 ;  i < list.size() ; i++) {
//			System.out.println( "<"+ ( i +1 )+"> ��° ���Ÿ�� => "+ list.get(i).toString() );
//		}
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 
	 //@Test
	 public void testGetPurchaseListByProdNo() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("10022");
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
		for (int i =0 ;  i < list.size() ; i++) {
			System.out.println( "<"+ ( i +1 )+"> ��° ���Ÿ�� => "+ list.get(i).toString() );
		}
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = purchaseService.getPurchaseList(search, "user01");
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
//		for (int i =0 ;  i < list.size() ; i++) {
//			System.out.println( "<"+ ( i +1 )+"> ��° ���Ÿ�� => "+ list.get(i).toString() );
//		}
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 
	 //@Test
	 public void testGetPurchaseListByReceiverName() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("admin");
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "admin");
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
		for (int i =0 ;  i < list.size() ; i++) {
			System.out.println( "<"+ ( i +1 )+"> ��° ���Ÿ�� => "+ list.get(i).toString() );
		}
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = purchaseService.getPurchaseList(search, "user19");
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console Ȯ��
		for (int i =0 ;  i < list.size() ; i++) {
			System.out.println( "<"+ ( i +1 )+"> ��° ���Ÿ�� => "+ list.get(i).toString() );
		}
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }	 


}