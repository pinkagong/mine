package com.solponge.web.view.order;

import com.solponge.domain.cart.CartService;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.order.OrderVo;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping()
public class OrderController {
    private final CartService cartService;

    @PostMapping("/com.solponge/member/{MEMBER_NO}/myPage/cart")
    public String postItem(HttpServletRequest request, @RequestParam("cartItems") List<String> cartItems, @RequestParam(value = "order", required = false) List<String> orderProductNums) {
        getLoginMember(request); //사용자 확인
        List<OrderVo> orderList = new ArrayList<>();

        if (cartItems.size() != 4) { // 리스트의 크기가 4일 때만 처리
            for (String cartItem : cartItems) {
                String[] cartItemArray = cartItem.split(",");
                int productNum = Integer.parseInt(cartItemArray[0]);
                int orderStock = Integer.parseInt(cartItemArray[1]);
                int memberNum = Integer.parseInt(cartItemArray[2]);
                int cartItemNum = Integer.parseInt(cartItemArray[3]);
                if (orderProductNums != null && orderProductNums.contains(Integer.toString(cartItemNum))) {
                    OrderVo order = new OrderVo();
                    order.setMEMBER_NUM(memberNum);
                    order.setPRODUCT_NUM(productNum);
                    order.setORDER_STOCK(orderStock);
                    orderList.add(order);
                }
            }
            }else{
            int productNum = Integer.parseInt(cartItems.get(0));
            int orderStock = Integer.parseInt(cartItems.get(1));
            int memberNum = Integer.parseInt(cartItems.get(2));
            int cartItemNum = Integer.parseInt(cartItems.get(3));

            if (cartItems.contains(Integer.toString(cartItemNum))) {
                //확인된 아이템들은 orderVo에 설정되어 orderList 에 저장됨
                OrderVo order = new OrderVo();
                order.setMEMBER_NUM(memberNum);
                order.setPRODUCT_NUM(productNum);
                order.setORDER_STOCK(orderStock);
                orderList.add(order);
            }
        }


        log.info("orderList={}", orderList);
        return null;
    }


    private MemberVo getLoginMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }

}
