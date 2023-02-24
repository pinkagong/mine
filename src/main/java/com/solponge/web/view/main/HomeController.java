package com.solponge.web.view.main;

import com.solponge.domain.member.MemberVo;
import com.solponge.domain.member.impl.MemberServiceImpl;
import com.solponge.domain.product.productService;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/com.solponge")
public class HomeController {

   private final MemberServiceImpl memberService;
   private final productService productService;

    @GetMapping("/main")
    public String homeLogin(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember, Model model){
        model.addAttribute("member",loginMember);
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
        log.info("member={}",member);
        if(bindingResult.hasErrors()){
            return "member/joinForm";
        }

        combineString(member); //문자열 합치기 주소,이메일,폰

        Long join = memberService.join(member);
        log.info("joinedMember={}",join);
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


}
