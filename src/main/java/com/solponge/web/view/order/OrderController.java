package com.solponge.web.view.order;

import com.solponge.domain.cart.CartService;
import com.solponge.domain.order.OrderVo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
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
    public String postItem(HttpServletRequest request, @RequestParam("cartItems") List<String> cartItems) {
        List<OrderVo> orderList = new ArrayList<>();
        //cart.jsp 파일에 order 라는 name 을 가진 체크박스의 값을 가지고 옴 = cart 의 저장 키 값은 cart_item_num 이므로 order 는 cart_item_num 이 추출됨.
        String[] orderItems = request.getParameterValues("order");
        if (orderItems != null) {

            List<String> orderProductNums = Arrays.asList(orderItems);
            log.info("----------------주문 카트아이템 번호={}",orderProductNums);
            for (String cartItem : cartItems) {
                String[] cartItemArray = cartItem.split(",");
                int productNum = Integer.parseInt(cartItemArray[0]);
                int orderStock = Integer.parseInt(cartItemArray[1]);
                int memberNum = Integer.parseInt(cartItemArray[2]);
                int cartItemNum = Integer.parseInt(cartItemArray[3]);
                    //jsp 에서 넘어오는 값은 String 이므로 현재 cart_item_num 이 존재하는지 String 으로 변환하여 확인
                if (orderProductNums.contains(Integer.toString(cartItemNum))) {
                    //확인된 아이템들은 orderVo에 설정되어 orderList 에 저장됨
                    OrderVo order = new OrderVo();
                    order.setMEMBER_NUM(memberNum);
                    order.setPRODUCT_NUM(productNum);
                    order.setORDER_STOCK(orderStock);
                    orderList.add(order);
                }
            }
        }
        log.info("orderList={}", orderList);
        return null;
    }


}
