package com.solponge.web.view.login;
import com.solponge.domain.member.login.LoginService;
import com.solponge.domain.member.MemberVo;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/com.solponge")
public class LoginController {
    private final LoginService loginService;

    @GetMapping("/login")
    String loginGet(@ModelAttribute("loginForm") LoginForm form){

        return "member/loginForm";
    }

    @PostMapping("/login")
    String loginPost(@Validated @ModelAttribute("loginForm")LoginForm form, BindingResult bindingResult, HttpServletRequest request){

        if(bindingResult.hasErrors()){
            return "member/loginForm";
        }
        MemberVo loginMember = loginService.login(form.getMemberId(), form.getMemberPwd());

        if (loginMember==null){//회원을 못 찾을때
            bindingResult.reject("loginFail","아이디 또는 비밀번호가 맞지 않습니다.");
            return "member/loginForm";
        }
        //로그인 성공처리
        //세션이 있으면 있는 세션 반환, 없으면 신규 세션 생성 반환
        HttpSession session = request.getSession();
        //세션에 로그인 회원정보 보관
        session.setAttribute(SessionConst.LOGIN_MEMBER, loginMember);

        log.info("member={}",form);
        return "redirect:/com.solponge/main";
    }

    @GetMapping("/logout")
    public String logOut(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if (session!=null){
            session.invalidate();
        }
        return "redirect:/com.solponge/main";


    }

    private static void expiredCookie(HttpServletResponse response,String cookieName) {
        Cookie cookie = new Cookie("memberId", null);
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }


}
