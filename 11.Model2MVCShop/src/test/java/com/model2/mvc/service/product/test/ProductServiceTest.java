package com.model2.mvc.service.product.test;

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
import com.model2.mvc.service.product.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
		"classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml",
		"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	// ==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	 //@Test
	public void testAddProduct() throws Exception {

		Product product = new Product();
		product.setProdName("ġŲ");
		product.setProdDetail("���ֿ��Բ�");
		product.setManuDate("1995");
		product.setPrice(1000);
		product.setFileName("11.img");

		productService.addProduct(product);

		// product = productService.getProduct("ġŲ");

		// ==> console Ȯ��
		 System.out.println(product);

		// ==> API Ȯ��
		Assert.assertEquals("ġŲ", product.getProdName());
		Assert.assertEquals("���ֿ��Բ�", product.getProdDetail());
		Assert.assertEquals("1995", product.getManuDate());
		Assert.assertEquals(1000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());

	}

	// @Test
	public void testGetProduct() throws Exception {

		Product product = new Product();

		// 10080 = PROD_NO (PARAMETER��)
		product = productService.getProduct(10080);

		// ==> console Ȯ��
		// System.out.println(product);

		// ==> API Ȯ��
		Assert.assertEquals("ġŲ", product.getProdName());
		Assert.assertEquals("���ֿ��Բ�", product.getProdDetail());
		Assert.assertEquals("1995", product.getManuDate());
		Assert.assertEquals(1000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());

		/*
		 * Assert.assertNotNull(userService.getUser("user02"));
		 * Assert.assertNotNull(userService.getUser("user05"));
		 */
	}

	// @Test
	public void testUpdateProduct() throws Exception {

		Product product = productService.getProduct(10080);
		Assert.assertNotNull(product);

		Assert.assertEquals("ġŲ", product.getProdName());
		Assert.assertEquals("���ֿ��Բ�", product.getProdDetail());
		Assert.assertEquals("1995", product.getManuDate());
		Assert.assertEquals(1000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());

		product.setProdName("ġŲ");
		product.setProdDetail("����+����!���Բ�");
		product.setManuDate("19950801");
		product.setPrice(5000);
		product.setFileName("11.img");

		productService.updateProduct(product);

		product = productService.getProduct(10080);
		Assert.assertNotNull(product);

		// ==> console Ȯ��
		// System.out.println(product);

		// ==> API Ȯ��
		Assert.assertEquals("ġŲ", product.getProdName());
		Assert.assertEquals("����+����!���Բ�", product.getProdDetail());
		Assert.assertEquals("19950801", product.getManuDate());
		Assert.assertEquals(5000, product.getPrice());
		Assert.assertEquals("11.img", product.getFileName());
	}

	 @Test
	// ����Ʈ ��κ���
	public void testGetProductListAll() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// Ű����� �����氡��
		search.setSearchCondition("");
		search.setSearchKeyword("");
/*		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");*/
		// �緮���� �ٲٱⰡ��
		search.setShippingCondition("");
		search.setPriceSort("");

		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}

	// @Test
	public void testGetProductListByProdNo() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("0");
		search.setSearchKeyword("10080");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(1, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

		System.out.println("=======================================");

		search.setSearchCondition("0");
		search.setSearchKeyword("" + System.currentTimeMillis());
		map = productService.getProductList(search);

		list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}

	// @Test
	public void testGetProductListByProductName() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("1");
		search.setSearchKeyword("%ġŲ%");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(2, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

		System.out.println("=======================================");

		search.setSearchCondition("1");
		search.setSearchKeyword("" + System.currentTimeMillis());
		map = productService.getProductList(search);

		list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}

	// @Test
	public void testGetProductListByPrice() throws Exception {

		Search search = new Search();
		search.setCurrentPage(2);
		search.setPageSize(3);
		search.setSearchCondition("2");
		search.setSearchKeyword("22");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(2, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

		System.out.println("=======================================");

		search.setSearchCondition("2");
		search.setSearchKeyword("" + System.currentTimeMillis());
		map = productService.getProductList(search);

		list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);
	}
	// @Test
	// �Ǹ��߸� ����
	public void testGetProductShippingListBySale() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// Ű����� �����氡��
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// �緮���� �ٲٱⰡ��
		search.setShippingCondition("0");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}

	// @Test
	// ���ſϷḸ ����
	public void testGetProductShippingListByBuy() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// Ű����� �����氡��
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// �緮���� �ٲٱⰡ��
		search.setShippingCondition("1");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(1, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}

	// @Test
	// ����߸� ����
	public void testGetProductShippingListByDelivery() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// Ű����� �����氡��
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// �緮���� �ٲٱⰡ��
		search.setShippingCondition("2");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(1, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}

	//@Test
	// ��ۿϷḸ ����
	public void testGetProductShippingListByDeliveryCompleted() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// Ű����� �����氡��
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		// �緮���� �ٲٱⰡ��
		search.setShippingCondition("3");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(0, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}
	
	//@Test
	// ���ݳ�����
	public void testGetProductPriceSortListHigh() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// Ű����� �����氡��
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		search.setShippingCondition("0");
		// �緮���� �ٲٱⰡ��
		search.setPriceSort("high");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}
	
	//@Test
	// ���ݳ�����
	public void testGetProductPriceSortListLow() throws Exception {

		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(3);
		// Ű����� �����氡��
		search.setSearchCondition("1");
		search.setSearchKeyword("%1%");
		search.setShippingCondition("0");
		// �緮���� �ٲٱⰡ��
		search.setPriceSort("low");
		Map<String, Object> map = productService.getProductList(search);

		List<Object> list = (List<Object>) map.get("list");
		Assert.assertEquals(3, list.size());

		// ==> console Ȯ��
		System.out.println(list);

		Integer totalCount = (Integer) map.get("totalCount");
		System.out.println(totalCount);

	}
}