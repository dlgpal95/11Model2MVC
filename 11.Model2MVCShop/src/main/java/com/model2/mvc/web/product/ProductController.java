package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {

	/// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	// setter Method ���� ����

	public ProductController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@Value("#{commonProperties['fileroot']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	String fileroot;


	@RequestMapping(value = "addProduct", method = RequestMethod.GET)
	public ModelAndView addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");

		return new ModelAndView("redirect:/product/addProductView.jsp");
	}

/*	// @RequestMapping("/addProduct.do")
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product,
			@RequestParam("uploadFile") MultipartFile uploadFile) throws Exception {

		System.out.println("/product/addProduct : POST");
		// Business Logic
		String manuDate = product.getManuDate().replaceAll("-", "");
		product.setManuDate(manuDate);

		String fileName = uploadFile.getOriginalFilename();

		File f = new File(fileroot, fileName);
		// �ѹ��� ���ؼ� ������ ������ �����ϸ� �̸��� (1) ,
		// (���߿�)2��°���� �˻��ؼ� �̸��� ���غ���, Ȯ���� �տ� �ٸ� �̸��� �߰��ϵ��� �غ���
		if (f.exists()) {
			f = new File(fileroot, fileName + "(1)");
		}

		try {
			uploadFile.transferTo(f);
		} catch (IOException e) {
			e.printStackTrace();
		}

		product.setFileName(fileName);

		productService.addProduct(product);

		return new ModelAndView("forward:/product/addProduct.jsp");
	}
*/
	
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product,
			@RequestParam("uploadFile") MultipartFile uploadFile,@RequestParam("multiFile") ArrayList<String> multiFile) throws Exception {

		System.out.println("/product/addProduct : POST");
		// Business Logic
		String manuDate = product.getManuDate().replaceAll("-", "");
		product.setManuDate(manuDate);

		//�÷������� ���߿��� �ϳ����־��ٰ��� ������
		String fileName = multiFile.get(0);
		//String fileName = uploadFile.getOriginalFilename();

		File f = new File(fileroot, fileName);
		// �ѹ��� ���ؼ� ������ ������ �����ϸ� �̸��� (1) ,
		// (���߿�)2��°���� �˻��ؼ� �̸��� ���غ���, Ȯ���� �տ� �ٸ� �̸��� �߰��ϵ��� �غ���
		if (f.exists()) {
			f = new File(fileroot, fileName + "(1)");
		}

		try {
			uploadFile.transferTo(f);
		} catch (IOException e) {
			e.printStackTrace();
		}

		product.setFileName(fileName);

		productService.addProduct(product);

		return new ModelAndView("forward:/product/addProduct.jsp");
	}	
	
	// @RequestMapping("/getProduct.do")
	@RequestMapping(value = "getProduct")
	public ModelAndView getProduct(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu) throws Exception {

		System.out.println("/product/getProduct ");
		Product product = productService.getProduct(prodNo);

		String cookieNo = request.getParameter("prodNo");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product", product);

		String history = null;
		Cookie cookie2;

		Cookie[] cookies = request.getCookies();

		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
			String newhistory = null;

			if (history != null) {
				
				newhistory=history;
				
				String[] historyarray = history.split(",");

				boolean check = false;
				for (String string : historyarray) {
					if (string.equals(cookieNo)) {
						check = true;
					}
				}
				if (!check) {
					newhistory = history += "," + cookieNo;
				}
			} else {
				newhistory = cookieNo;
			}
			cookie2 = new Cookie("history", newhistory);
		} else {
			cookie2 = new Cookie("history", cookieNo);
		}

		cookie2.setPath("/");
		response.addCookie(cookie2);

		if (menu != null) {
			if (menu.equals("manage")) {
				modelAndView.setViewName("forward:/product/updateProductView.jsp");
				return modelAndView;
			} else {
				modelAndView.setViewName("forward:/product/getProduct.jsp");
				return modelAndView;
			}
		} else {
			modelAndView.setViewName("forward:/product/getProduct.jsp");
			return modelAndView;
		}
	}

	@RequestMapping(value = "updateProduct", method = RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo, Model model) throws Exception {

		System.out.println("/product/updateProduct : GET");
		// Business Logic
		Product product = productService.getProduct(prodNo);

		// Model �� View ����
		model.addAttribute("product", product);

		return new ModelAndView("forward:/product/updateProductView.jsp");
	}

	// @RequestMapping("/updateProduct.do")
	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public ModelAndView updateProduct(@ModelAttribute("product") Product product,
			@RequestParam("uploadFile") MultipartFile uploadFile, @RequestParam("prodNo") int prodNo, Model model)
			throws Exception {

		System.out.println("/product/updateProduct : POST");

		String manuDate = product.getManuDate().replaceAll("-", "");
		product.setManuDate(manuDate);

		String fileName = uploadFile.getOriginalFilename();

		File f = new File(fileroot, fileName);
		// �ѹ��� ���ؼ� ������ ������ �����ϸ� �̸��� (1) ,
		// (���߿�)2��°���� �˻��ؼ� �̸��� ���غ���, Ȯ���� �տ� �ٸ� �̸��� �߰��ϵ��� �غ���
		if (f.exists()) {
			f = new File(fileroot, fileName + "(1)");
		}

		try {
			uploadFile.transferTo(f);
		} catch (IOException e) {
			e.printStackTrace();
		}

		product.setFileName(fileName);

		productService.updateProduct(product);

		return new ModelAndView("redirect:/product/getProduct?prodNo=" + prodNo + "&menu=null");
	}

	// @RequestMapping("/listProduct.do")
	@RequestMapping(value = "listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, HttpServletRequest request)
			throws Exception {

		System.out.println("/product/listProduct : GET / POST");

		String originSearch = null;

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		if (search.getSearchKeyword() == null) {
			search.setSearchKeyword("");
		} else {
			if (search.getSearchCondition().equals("1") && !search.getSearchKeyword().equals("")) {
				originSearch = search.getSearchKeyword();
				String likeSearch = "%" + search.getSearchKeyword() + "%";
				search.setSearchKeyword(likeSearch);
			}
		}

		if (search.getSearchCondition() == null) {
			search.setSearchCondition("");
		}

		// Business logic ����
		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		search.setSearchKeyword(originSearch);
		
		System.out.println("��!!!!!!!!!!!"+search.getPriceSort());

		// Model �� View ����
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/product/listProduct.jsp");

		return modelAndView;
	}
	

	/*
	 * @RequestMapping("/addProductView.do") public String addProductView() throws
	 * Exception {
	 * 
	 * System.out.println("/addProductView.do");
	 * 
	 * return "redirect:/product/addProductView.jsp"; }
	 * 
	 * @RequestMapping("/addProduct.do") public String
	 * addProduct(@ModelAttribute("product") Product product) throws Exception {
	 * 
	 * System.out.println("/addProduct.do"); // Business Logic String manuDate =
	 * product.getManuDate().replaceAll("-", ""); product.setManuDate(manuDate);
	 * 
	 * productService.addProduct(product);
	 * 
	 * return "forward:/product/addProduct.jsp"; }
	 * 
	 * @RequestMapping("/getProduct.do") public String getProduct(HttpServletRequest
	 * request, HttpServletResponse response,@RequestParam("prodNo") int
	 * prodNo, @RequestParam("menu") String menu, Model model) throws Exception {
	 * 
	 * System.out.println("/getProduct.do");
	 * 
	 * Product product = productService.getProduct(prodNo);
	 * 
	 * String cookieNo = request.getParameter("prodNo");
	 * 
	 * model.addAttribute("product", product);
	 * 
	 * String history = null; Cookie[] cookies = request.getCookies(); if (cookies
	 * != null && cookies.length > 0) { for (int i = 0; i < cookies.length; i++) {
	 * Cookie cookie = cookies[i]; if (cookie.getName().equals("history")) { history
	 * = cookie.getValue(); } } String newhistory=history+=","+cookieNo; Cookie
	 * cookie = new Cookie("history", newhistory); response.addCookie(cookie); }
	 * else { Cookie cookie = new Cookie("history", cookieNo);
	 * response.addCookie(cookie); }
	 * 
	 * if (menu != null) { if (menu.equals("manage")) { return
	 * "forward:/product/updateProductView.jsp"; } else { return
	 * "forward:/product/getProduct.jsp"; } } else { return
	 * "forward:/product/getProduct.jsp"; } }
	 * 
	 * @RequestMapping("/updateProductView.do") public String
	 * updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws
	 * Exception {
	 * 
	 * System.out.println("/updateProductView.do"); // Business Logic Product
	 * product = productService.getProduct(prodNo);
	 * 
	 * // Model �� View ���� model.addAttribute("product", product);
	 * 
	 * return "forward:/product/updateProductView.jsp"; }
	 * 
	 * @RequestMapping("/updateProduct.do") public String
	 * updateProduct(@ModelAttribute("product") Product
	 * product, @RequestParam("prodNo") int prodNo, Model model) throws Exception {
	 * 
	 * System.out.println("/updateProduct.do");
	 * 
	 * productService.updateProduct(product);
	 * 
	 * return "redirect:/getProduct.do?prodNo=" + prodNo + "&menu=null"; }
	 * 
	 * @RequestMapping("/listProduct.do") public String
	 * listProduct(@ModelAttribute("search") Search search, Model model,
	 * HttpServletRequest request) throws Exception {
	 * 
	 * System.out.println("/listProduct.do");
	 * 
	 * String originSearch = null;
	 * 
	 * if (search.getCurrentPage() == 0) { search.setCurrentPage(1); }
	 * search.setPageSize(pageSize);
	 * 
	 * if (search.getSearchKeyword() == null) { search.setSearchKeyword(""); } else
	 * { if (search.getSearchCondition().equals("1") &&
	 * !search.getSearchKeyword().equals("")) { originSearch =
	 * search.getSearchKeyword(); String likeSearch = "%" +
	 * search.getSearchKeyword() + "%"; search.setSearchKeyword(likeSearch); } }
	 * 
	 * if (search.getSearchCondition() == null) { search.setSearchCondition(""); }
	 * 
	 * // Business logic ���� Map<String, Object> map =
	 * productService.getProductList(search);
	 * 
	 * Page resultPage = new Page(search.getCurrentPage(), ((Integer)
	 * map.get("totalCount")).intValue(), pageUnit, pageSize);
	 * System.out.println(resultPage);
	 * 
	 * search.setSearchKeyword(originSearch);
	 * 
	 * // Model �� View ���� model.addAttribute("list", map.get("list"));
	 * model.addAttribute("resultPage", resultPage); model.addAttribute("search",
	 * search);
	 * 
	 * return "forward:/product/listProduct.jsp"; }
	 */
}
