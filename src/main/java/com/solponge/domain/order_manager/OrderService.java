package com.solponge.domain.order_manager;



import com.solponge.domain.member.MemberVo;
import com.solponge.domain.product.productVo;
import org.hibernate.criterion.Order;

import java.util.List;

public interface OrderService {

    // CRUD
    String insertOrder(OrderVo vo);

    void updateOrder(OrderVo vo);

    void deleteOrder(String payment_num);

    Order getBoard(Long itemId);

    List<OrderVo> getBoardList();
}