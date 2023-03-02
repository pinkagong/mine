package com.solponge.web.view.order;

import com.solponge.domain.cart.CartService;
import com.solponge.domain.cart.OrderVo;
import com.solponge.domain.member.impl.MemberServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/com.solponge/member/{MEMBER_NO}/myPage/cart")
public class OrderController {
    private final MemberServiceImpl memberService;
    private final com.solponge.domain.product.productService productService;
    private final CartService cartService;

    /**
     * 장바구니에서 보낸 값 받는 곳
     * @param request
     * @param cartItems
     * @return
     */

    @PostMapping("/com.solponge/member/{MEMBER_NO}/myPage/cart")
    public String postItem(HttpServletRequest request, @RequestParam("cartItems") List<String> cartItems){
        List<OrderVo> orderList =new ArrayList<>();

        for (String cartItem : cartItems) {
            String[] cartItemArray = cartItem.split(",");
            OrderVo order = new OrderVo();
            order.setMEMBER_NUM(Integer.parseInt(cartItemArray[2]));
            order.setPRODUCT_NUM(Integer.parseInt(cartItemArray[0]));
            order.setORDER_STOCK(Integer.parseInt(cartItemArray[1]));
            orderList.add(order);
        }
        log.info("orderList={}",orderList);
        /*orderList 에 값이 리스트 형식으로 출력됩니다.*/
        return null;

    }
}
