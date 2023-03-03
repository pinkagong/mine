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

    /**
     * 장바구니
     */
   /* @SneakyThrows
    @GetMapping("/{MEMBER_NO}/myPage/cart")
    public String cart(Model model,
                       HttpServletRequest request){
        //세션을 받아 계정객체 받아옴
        MemberVo member = getLoginMember(request);
        //---------------------------------------------------------
        List<CartListVo> cartListVos = cartService.cartList(Math.toIntExact(member.getMEMBER_NO()));


        //회원의 카트 vo 조회
        CartVo myCart = cartService.getMyCart(Math.toIntExact(member.getMEMBER_NO()));
        //cart 객체 생성
        Cart cart = myCart.toCart(myCart, member);

        for (CartListVo cartListVo : cartListVos) {
            //cartListVo를 cartItem 으로 변환 //현재상태 : member=null, productVo=cartListVo 에서 받아온 기초 정보(cart_item_num, cart_item_title, cart_item_price), cart_item_stock
            CartItem cartItem = cartListVo.toCartItem();
            //cartItem 의 product 정보를 진짜 해당 product 정보로 변환
            cartItem.setProduct(productService.getproduct(cartItem.getProduct().getProduct_num()));
            cartItem.setMember(member);
            //변환시킨 cartItem 을 미리 만든 cartItems 에 넣기
            cart.addCartItem(cartItem);

        }
        //----------------------------------------------------------
        //cartItem 을 넣은 cart 를 model 에 저장
        model.addAttribute("cart",cart);
        return "member/cart";
    }



    *//**
     * 장바구니 추가
     * @param productId
     * @param quantityinput
     * @param request
     *//*
    @GetMapping("/{MEMBER_NO}/myPage/cart/{productId}/{quantityinput}")
    public String cartSave(@PathVariable int productId,
                       @PathVariable int quantityinput,
                       HttpServletRequest request){

        MemberVo loginMember = getLoginMember(request);
        //받아온 상품번호로 상품객체 소환
        productVo getproduct = productService.getproduct(productId);
        //cartItem 객체를 생성하여 필요한 값을 cartItemVo로 전달
        CartItemVo cartItemVo = new CartItemVo(new CartItem(loginMember,getproduct, quantityinput));
        //받아온 상품정보를 CART_ITEM 에 저장
        int cart_Item_num = cartService.addItem(cartItemVo);
        log.info("장바구니에 추가된 상품정보={}",cartService.findItem(cart_Item_num));

        return "redirect:/com.solponge/member/"+loginMember.getMEMBER_NO()+"/mypage/cart";

    }*/



    /**
     * 마이페이지
     */

/*    @GetMapping("/{MEMBER_NO}/myPage")
    public String PostMyPage(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember, Model model){
        //세션에 회원 데이터가 없으면 home
        if(loginMember==null){
            return "/login";
        }
        //로그인 시
        model.addAttribute("member",loginMember);
        return "member/myPage";

    }*/

    @GetMapping("/{MEMBER_NO}/myPage")
    public String getMyPage(@SessionAttribute(name = SessionConst.LOGIN_MEMBER, required = false) MemberVo loginMember, Model model) {
        //세션에 로그인한 회원 데이터가 없으면 home
        if(loginMember == null) {
            return "redirect:/com.solponge/main";
        }
        //회원 정보 조회
        model.addAttribute("member", loginMember);
        return "member/updateForm";
    }

    @PostMapping("/{MEMBER_NO}/myPage")
    public String updateMember(@SessionAttribute(name = SessionConst.LOGIN_MEMBER, required = false) MemberVo loginMember,
                               HttpSession Session,
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
                               Model model) {
        model.addAttribute("member",loginMember);
        //세션에 로그인한 회원 데이터가 없으면 메인페이지로
        if(loginMember==null){
            return "redirect:/com.solponge/main";
        }
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
    public String deleteMember(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                               @PathVariable Long MEMBER_NO, HttpServletRequest request) {
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