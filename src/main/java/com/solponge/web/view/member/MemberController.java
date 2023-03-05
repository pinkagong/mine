package com.solponge.web.view.member;

import com.solponge.domain.cart.*;
import com.solponge.domain.cart.impl.CartServiceImpl;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.member.impl.MemberServiceImpl;
import com.solponge.domain.product.productService;
import com.solponge.domain.product.productVo;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/com.solponge/member")
public class MemberController {
    private final MemberServiceImpl memberService;
    private final productService productService;
    private final CartService cartService;


    @GetMapping("/{MEMBER_NO}/myPage")
    public String getMyPage(Model model, HttpServletRequest request) {
        MemberVo loginMember = getLoginMember(request);

        //회원 정보 조회
        model.addAttribute("member", loginMember);
        return "member/updateForm";
    }

    @PostMapping("/{MEMBER_NO}/myPage")
    public String updateMember(HttpSession Session,
                               RedirectAttributes redirectAttributes,
                               @RequestParam String member_pwd,
                               @RequestParam String email1,
                               @RequestParam String email2,
                               @RequestParam String sample6_postcode,
                               @RequestParam String sample6_address,
                               @RequestParam String sample6_detailAddress,
                               @RequestParam String firstnum,
                               @RequestParam String secnum,
                               @RequestParam String thrnum,
                               Model model,
                               HttpServletRequest request) {
        MemberVo loginMember = getLoginMember(request);
        //회원 정보 업데이트
        updateMember(loginMember, member_pwd, email1, email2,
                sample6_postcode, sample6_address, sample6_detailAddress,
                firstnum, secnum, thrnum);
        //업데이트한 회원정보를 세션에 저장
        sessionSave(loginMember, Session);
        return "main";
    }

    private void sessionSave(MemberVo loginMember, HttpSession Session) {
        // 업데이트된 멤버 객체 찾기
        MemberVo updateMemeber = memberService.findByNo(loginMember.getMEMBER_NO());
        log.info("updatedMember={}",updateMemeber);
        //세션에 업데이트된 찾은 회원 정보 저장
        Session.setAttribute(SessionConst.LOGIN_MEMBER,updateMemeber);
    }

    private void updateMember(MemberVo loginMember, String member_pwd, String email1, String email2, String sample6_postcode, String sample6_address, String sample6_detailAddress, String firstnum, String secnum, String thrnum) {
        String email = email1 + "@" + email2;
        String address = sample6_postcode + "/" + sample6_address + "/" + sample6_detailAddress;
        String phone = firstnum + "-" + secnum + "-" + thrnum;
        //멤버 수정정보 생성
        MemberVo memberVo = new MemberVo(member_pwd,address,email,phone);
        //멤버 업데이트
        memberService.update(loginMember.getMEMBER_NO(),memberVo);
    }

    @GetMapping("/{MEMBER_NO}/myPage/delete")
    public String deleteMember(@PathVariable Long MEMBER_NO, HttpServletRequest request) {
        MemberVo loginMember = getLoginMember(request);
        MemberVo member = memberService.findByNo(MEMBER_NO);
        memberService.withdrawal(member);
        HttpSession session = request.getSession(false);
        if (session!=null){
            session.invalidate();
        }
        return "redirect:/com.solponge/main";
    }

    /**
     * 세션에서 회원정보 받아옴
     * @param request
     * @return
     */

    private MemberVo getLoginMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }

}