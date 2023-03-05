package com.solponge.web.view.main;

import com.solponge.domain.cart.CartService;
import com.solponge.domain.cart.CartVo;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.member.impl.MemberServiceImpl;
import com.solponge.domain.product.productService;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/com.solponge")
public class HomeController {

   private final MemberServiceImpl memberService;
   private final productService productService;
   private final CartService cartService;

    @GetMapping("/main")
    public String home(Model model, HttpServletRequest request){
        MemberVo member = getLoginMember(request);
        model.addAttribute("getproductNewTop8List", productService.getproductNewTop8List());
       model.addAttribute("getproductpopularTop8List", productService.getproductpopularTop8List());
        return "main";
    }
    @GetMapping("/join")
    String getJoin(@ModelAttribute("member") MemberVo member){
        return "member/joinForm";
    }

    @PostMapping("/join")
    public String postJoin(@Validated @ModelAttribute("member") MemberVo member, BindingResult bindingResult){
        List<MemberVo> all = memberService.findAll();
        for (MemberVo memberVo : all) {
            String memberId = memberVo.getMEMBER_ID();
            if(member.getMEMBER_ID().equals(memberId)){
                bindingResult.rejectValue("MEMBER_ID","idCheckFail","이미 존재하는 회원입니다.");
            }
        }

        if (member.getMEMBER_PHONE2()==null||member.getMEMBER_PHONE3()==null) {
            bindingResult.rejectValue("MEMBER_PHONE", "NotEmpty", "휴대폰번호를 모두 입력해주세요.");
        }

        if(member.getMEMBER_PWD()!=member.getMEMBER_PWD_CHECK()){
            bindingResult.rejectValue("MEMBER_PWD_CHECK","pwdCheckFail","비밀번호가 일치하지 않습니다.");
            log.info("join.bindingResult={}",bindingResult);
        }
        log.info("member={}",member);
        if(bindingResult.hasErrors()){
            return "member/joinForm";
        }

        combineString(member); //문자열 합치기 주소,이메일,폰

        Long join = memberService.join(member);
        log.info("joinedMember={}",join);
        //회원가입 시 카트 생성
        int cart = cartService.createCart(new CartVo(Math.toIntExact(join)));
        log.info("cartCreated={}",cart);
        return "member/addComplete";
    }



    private static void combineString(MemberVo member) {
        String address = member.getMEMBER_ADDRESS1() + "/" + member.getMEMBER_ADDRESS2() + "/" + member.getMEMBER_ADDRESS3();
        member.setMEMBER_ADDRESS(address);

        String email = member.getMEMBER_EMAIL1() +"@"+ member.getMEMBER_EMAIL2();
        member.setMEMBER_EMAIL(email);

        String phone = member.getMEMBER_PHONE1() + "-" + member.getMEMBER_PHONE2() + "-" + member.getMEMBER_PHONE3();
        member.setMEMBER_PHONE(phone);
    }
    private MemberVo getLoginMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }

}
