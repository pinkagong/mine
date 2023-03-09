package com.solponge.web.view.payment;


import com.solponge.domain.cart.CartService;
import com.solponge.domain.member.MemberService;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.payment.PaymentService;
import com.solponge.domain.payment.payVO;
import com.solponge.domain.product.productService;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RequestMapping("/com.solponge/member/{MEMBER_NO}")
@SessionAttributes(names = SessionConst.LOGIN_MEMBER)
@RequiredArgsConstructor // 초기화 되지 않게 알아서 실행되는 녀석
@RestController
public class JsonController {

    @Autowired
    private PaymentService ps;
    @Autowired
    private productService ptsd;
    @Autowired
    private MemberService ms;
    @Autowired
    private CartService cs;


    @PostMapping(value = "/payments/su")
    @ResponseBody
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void insertPayment(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                                @RequestBody(required = false) payVO payVO, HttpServletRequest request) {
        System.out.println("ajax/json 넘기는곳");
        System.out.println(payVO.getPayment_num());

        for (int i=0; i < payVO.getProduct_num().length; i++){
            System.out.println(payVO.getPayment_num()+ payVO.getProduct_num()[i]+ loginMember.getMEMBER_NO()+ payVO.getPayment_stock()[i]+ payVO.getPhone()+ payVO.getEmail()+ payVO.getAddress()+ payVO.getDelivery_info());
            ps.insertPayment(payVO.getPayment_num(), payVO.getProduct_num()[i], loginMember.getMEMBER_NO(), payVO.getPayment_stock()[i], payVO.getPhone(), payVO.getEmail(), payVO.getAddress(), payVO.getDelivery_info());

        }
    }

}
