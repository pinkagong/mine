package com.solponge.web.view.login.interceptor;

import com.solponge.domain.member.Grade;
import com.solponge.domain.member.MemberVo;
import com.solponge.web.view.login.session.SessionConst;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
public class AdminLoginCheckInterceptor extends LoginCheckInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();
        log.info("인증 체크 인터셉터 실행{}", requestURI);
        HttpSession session = request.getSession(false);
        // 세션이 null 인지 확인합니다. 여기서 null 이면 LoginCheckInterceptor로 검증이 가기 전에
        // 예외가 터져서 끝나버립니다.
        if (session == null) {
            response.sendRedirect("/com.solponge/login");
            return false;
        }

        MemberVo memberVo = (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER);
        if (memberVo.getMEMBER_GRADE() != Grade.ADMIN) {
            log.info("미인증 사용자 요청 id={}", memberVo.getMEMBER_ID());
            response.sendRedirect("/com.solponge/login");
            return false;
        }
        return true;
    }
}
