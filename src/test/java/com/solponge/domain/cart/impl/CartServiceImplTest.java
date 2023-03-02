package com.solponge.domain.cart.impl;

import com.solponge.domain.cart.CartListVo;
import com.solponge.domain.cart.CartVo;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
@SpringBootTest
@Slf4j
class CartServiceImplTest {
    @Autowired
    private  CartServiceImpl cartService;


    @Test
    void cartList() {
        List<CartListVo> cartListVos = cartService.cartList(40);
        log.info("cartListTest={}",cartListVos);


    }

    @Test
    void get(){
        CartVo myCart = cartService.getMyCart(112);
        log.info("myCart={}",myCart);
    }
}