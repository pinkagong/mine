package com.solponge.domain.order_manager.impl;


import com.solponge.domain.order_manager.OrderService;
import com.solponge.domain.order_manager.OrderVo;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class OrderServiceImpl implements OrderService {
    private final OrderDAO orderDAO;

    public OrderServiceImpl(OrderDAO orderDAO) {
        this.orderDAO = orderDAO;
    }


    @Autowired
    private com.solponge.domain.order_manager.impl.OrderDAO OrderDAO;



    @Override
    public String insertOrder(OrderVo vo) {
        return null;
    }

    @Override
    public void updateOrder(OrderVo vo) {
        OrderDAO.updateOrder(vo);
    }

    @Override
    public void deleteOrder(String payment_num) {

    }

    @Override
    public Order getBoard(Long itemId) {
        return null;
    }

    public List<OrderVo> getBoardList() {
        System.out.println("OrderServiceImpl...");
        return OrderDAO.getBoardList();
    }
}
