package com.solponge.web.view.admin;


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

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/com.solponge/admin")
public class AdminController {
    @Autowired
    MemberServiceImpl memberService;

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

    /**
     * 메서드
     */
    private MemberVo getLoginMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }

}
