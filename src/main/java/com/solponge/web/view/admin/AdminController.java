package com.solponge.web.view.admin;


import com.solponge.domain.product.productVo;
import com.solponge.domain.product.impl.productServiceImpl;
import com.solponge.domain.member.Grade;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.member.impl.MemberServiceImpl;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/com.solponge/admin")
public class AdminController {
    @Autowired
    MemberServiceImpl memberService;
    @Autowired
    productServiceImpl productService;

    /**
     * 회원정보 리스트
     */
    @GetMapping("/member")
    public String member(Model model) {
        model.addAttribute("members", memberService.findAll());
        log.info("findAll={}", memberService.findAll());
        return "/admin/member";
    }


    /**
     * 회원정보 수정
     */

    @GetMapping("/member/{member_No}/update")
    public String editMember(@PathVariable Long member_No, Model model,HttpServletRequest request) {
        MemberVo memberVo = getLoginMember(request);
        if (memberVo == null || memberVo.getMEMBER_GRADE() != Grade.ADMIN) {
            return "redirect:/com.solponge/main";
        }
        MemberVo member = memberService.findByNo(member_No);
        log.info("adminMember={}",member);
        model.addAttribute("member", member);
        return "admin/updateForm";
    }

    @PostMapping("/member/{member_No}/update")
    public String edit(HttpServletRequest request,
                       @PathVariable Long member_No, @ModelAttribute MemberVo member,
                       @RequestParam String member_Pwd,
                       @RequestParam String member_Address,
                       @RequestParam String member_Phone,
                       @RequestParam String member_Email,
                       RedirectAttributes redirectAttributes) {
        MemberVo memberVo = getLoginMember(request);
        if (memberVo == null || memberVo.getMEMBER_GRADE() != Grade.ADMIN) {
            return "redirect:/com.solponge/main";
        }
        log.info("member_No={}",member_No);
        log.info("beforeUpdate={}",member);
        MemberVo updateMember = new MemberVo(member_Pwd,member_Address,member_Email,member_Phone);
        memberService.update(member_No,updateMember);
        log.info("updateMember={}",memberService.findByNo(member_No));
        return "redirect:/com.solponge/admin/member";
    }

    /**
     * 회원 삭제
     */

    @GetMapping("/member/{member_No}/delete")
    public String deleteMember(@PathVariable Long member_No) {
        MemberVo member = memberService.findByNo(member_No);
        memberService.withdrawal(member);
        return "redirect:/com.solponge/admin/member";
    }

    @GetMapping("/product") //수정완료
    public String product(Model model, HttpServletRequest request) {
        List<productVo> data = productService.findAll();
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
//        model.addAttribute("products", productService.getBoardList());
        log.info("findAll={}", productService.findAll());
        return "admin/inqProduct";
    }


    @GetMapping("/product/{productNum}")
    public String deProduct(@PathVariable int productNum, Model model) {
        productVo product = productService.getproduct(productNum);
        System.out.println(product.getProduct_num());
        System.out.println(productNum);
        model.addAttribute("product", product);
        return "admin/deProduct";
    }

    @GetMapping("/product/add")
    public String addProduct() {
        return "admin/addProduct";
    }
    @PostMapping("/product/add")
    public String addProduct(productVo product, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        System.out.println("컨트롤러");
        String productcode = request.getParameter("myInput");
        System.out.println("addProduct_"+productcode);
        product.setProduct_code(productcode);
        String productNum = productService.insertproduct(product);
        redirectAttributes.addAttribute("productNum", productNum);
        redirectAttributes.addAttribute("status", "add");

        return "redirect:/com.solponge/admin/product";
    }

    @GetMapping("/product/{productNum}/edit") //수정중
    public String editProduct(@PathVariable int productNum, Model model, HttpServletRequest request) {
        System.out.println(productNum);
        MemberVo memberVo = getLoginMember(request);
        if (memberVo == null || memberVo.getMEMBER_GRADE() != Grade.ADMIN) {
            return "redirect:/com.solponge/main";
        }
        productVo product = productService.getproduct(productNum);
        log.info("product={}",product);
        System.out.println(product.getProduct_code());
        model.addAttribute("product", product);
        return "admin/editProduct";
    }

    @PostMapping("/product/{productNum}/edit") //수정중
    public String edit(@PathVariable int productNum, @ModelAttribute productVo product, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        System.out.println("컨트롤러");
        MemberVo memberVo = getLoginMember(request);
        if (memberVo == null || memberVo.getMEMBER_GRADE() != Grade.ADMIN) {
            return "redirect:/com.solponge/main";
        }
        log.info("productNum={}",productNum);
        log.info("product={}",product);
        String productcode = request.getParameter("myInput"); //, @RequestBody Map<String, String> request
//        productcode = productcode.replace("<p><br data-cke-filler=\"true\"></p>", "");
//        productcode = productcode.replace("<p><br data-cke-filler=\"true\"></p>", "");
//        productcode = ""+ productcode + "";
        System.out.println(productcode);
        product.setProduct_code(productcode);
        productService.updateproduct(product);
//        redirectAttributes.addAttribute("status", "edit");
        System.out.println("Call");
        return "redirect:";
    }

    @GetMapping("/product/{productNum}/delete")
    public String deleteProduct(@PathVariable int productNum) {
        System.out.println(productNum);
        productService.deleteproduct(productNum);
        return "redirect:/com.solponge/admin/product";
    }

    @PostMapping("/product/{productNum}/delete")
    public String delete(@PathVariable int productNum) {
        System.out.println(productNum);
        productService.deleteproduct(productNum);
        return "redirect:/com.solponge/admin/product";
    }

    /**
     * 메서드
     */
    private MemberVo getLoginMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }

    private productVo getLoginProduct(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (productVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }


}
