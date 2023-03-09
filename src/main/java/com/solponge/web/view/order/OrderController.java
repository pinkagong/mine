package com.solponge.web.view.order;

import com.solponge.domain.cart.CartService;

import com.solponge.domain.member.MemberService;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.order.OrderVo;
import com.solponge.domain.payment.PaymentService;
import com.solponge.domain.product.productService;
import com.solponge.domain.product.productVo;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;




@Controller
@Slf4j
@RequiredArgsConstructor

@RequestMapping("/com.solponge/member/{MEMBER_NO}")
public class OrderController {
    private final CartService cartService;

    @Autowired
    private PaymentService ps;
    @Autowired
    private productService ptsd;
    @Autowired
    private MemberService ms;

    @PostMapping("/payments")
    public String postItem(HttpServletRequest request, @RequestParam("cartItems") List<String> cartItems, @RequestParam(value = "order", required = false) List<String> orderProductNums,
                           Model model) {

        MemberVo loginMember = getLoginMember(request);//사용자 확인

        List<OrderVo> orderList = new ArrayList<>();
        int oneItem=4;

        if (cartItems.size() != oneItem) { // 하나의 상품만을 주문한것이 아닐때
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


        List<OrderVo> data = orderList;
        Map<String, Object> param = new HashMap<>();
        int total_price = 0;
        for (int i = 0; i < data.size(); i++){
            productVo input_product = ptsd.getproduct(data.get(i).getPRODUCT_NUM());
            int input_num = input_product.getProduct_num();
            param.put("img_"+input_num, input_product.getProduct_img());
            param.put("title_"+input_num, input_product.getProduct_title());
            param.put("price_"+input_num, input_product.getProduct_price());
            param.put("stock_"+input_num, data.get(i).getORDER_STOCK());
            total_price += input_product.getProduct_price() * data.get(i).getORDER_STOCK()+2500;
        }

        model.addAttribute("pinfo", param);
        model.addAttribute("oinfo", data);
        model.addAttribute("minfo", ms.findByNo(loginMember.getMEMBER_NO()));
        model.addAttribute("total_price",total_price);


        log.info("orderList={}", orderList);
        return "product/payments";

    }


    private MemberVo getLoginMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }

}
