package com.solponge.web.view.product;

import com.solponge.domain.member.MemberVo;
import com.solponge.domain.product.productService;
import com.solponge.domain.product.productVo;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/com.solponge")
@SessionAttributes(names = SessionConst.LOGIN_MEMBER)
@RequiredArgsConstructor // 초기화 되지 않게 알아서 실행되는 녀석
public class produtController {
    @Autowired
    productService ps;

    /*@GetMapping("/main")
    public String mainpage(Model model){
        model.addAttribute("getproductNewTop8List", ps.getproductNewTop8List());
        model.addAttribute("getproductpopularTop8List", ps.getproductpopularTop8List());
        return "main";
    }*/

    @GetMapping("/productList")
    public String produtslist(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                              Model model, HttpServletRequest request){
        model.addAttribute("member",loginMember);
        List<productVo> data = ps.getproductList();
        int pageSize = 20; // number of items per page
        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, data.size());
        int totalPages = (int) Math.ceil((double) data.size() / pageSize);
        List<productVo> paginatedProducts = data.subList(start, end); // get the current page of products
        model.addAttribute("paginatedProducts", paginatedProducts);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("url", "?");
        return "product/productlist";
    }
    @GetMapping("/productList/search")
    public String produtsearchlist(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                                   Model model, HttpServletRequest request,
                                   @RequestParam("SearchSelect") String SearchSelec,
                                   @RequestParam("SearchValue") String SearchValue){
        model.addAttribute("member",loginMember);
        List<productVo> data = ps.produtsearchlist(SearchSelec, SearchValue);
        int pageSize = 20; // number of items per page
        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, data.size());
        int totalPages = (int) Math.ceil((double) data.size() / pageSize);
        List<productVo> paginatedProducts = data.subList(start, end); // get the current page of products
        model.addAttribute("paginatedProducts", paginatedProducts);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        String url = request.getQueryString();
        System.out.println(url);
        url = url.replaceAll("&page=[0-9]", "");
        String inputurl ="";
        if (url.contains("SearchSelect")){
            inputurl += "search?"+url+"&";
        } else {
            inputurl += "?";
        }
        model.addAttribute("url", inputurl);
        model.addAttribute("status", "Yes");
//        redirectAttributes.addAttribute("status", "Search");
        System.out.println(inputurl);
        return "product/productlist";
//        return "redirect:./";
//        return "redirect:productlist";
    }

    @GetMapping("/product/{productId}")
    public String produtpage(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                             @PathVariable int productId, Model model){
        model.addAttribute("member",loginMember);
        productVo vo = ps.getproduct(productId);
        System.out.println(productId);
        model.addAttribute("productVo", vo);
        return "product/productpage";
    }

    @PostMapping("/product/{productId}")
    public String produtprocess(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                                @PathVariable int productId, Model model,
                                @RequestParam Map<String,String> requestParams,
                                @RequestParam("quantityinput") String quantityinput){
        System.out.println("productId,"+productId);
        System.out.println("quantityinput,"+quantityinput);
        model.addAttribute("product_num",productId);
        model.addAttribute("quantityinput",quantityinput);
        model.addAttribute("member",loginMember);
        if (requestParams.containsKey("button1")) {
            return "redirect:/button1-page";
        } else {
            return "redirect:/error-page";
        }

    }



}


