package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;


//==> ���Ű������� CRUD �߻�ȭ/ĸ��ȭ�� DAO Interface Definition  
public interface PurchaseDao {
	
	// INSERT
	public void addPurchase(Purchase purchase) throws Exception;
	
	// SELECT ONE
	public Purchase getPurchase(int tranNo) throws Exception;
	
		public Purchase getPurchase2(int prodNo) throws Exception;
	
	// SELECT LIST 	
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception;
	
	// SELECT LIST
	public List<Purchase> getSaleList(Search search) throws Exception;
	
	public int getTotalCountSale() throws Exception;
		
	// UPDATE (��������)
	public void updatePurchase(Purchase purchase) throws Exception;
	
	// UPDATE (TranCode)
	public void updateTranCode(Purchase purchase) throws Exception;
	
	// �Խ��� Page ó���� ���� ��ü Row(totalCount)  return �ڡڡ�
	public int getTotalCount(String buyerId) throws Exception ;
	
}