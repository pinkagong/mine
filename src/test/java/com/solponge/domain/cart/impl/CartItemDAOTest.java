package com.solponge.domain.cart.impl;

import com.solponge.domain.cart.CartItem;
import com.solponge.domain.cart.CartItemVo;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.member.impl.MemberDAO;
import com.solponge.domain.product.impl.productDAO;
import com.solponge.domain.product.productVo;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
class CartItemDAOTest {
    @Autowired
    MemberDAO memberDAO;
    @Autowired
    productDAO productDAO;
    @Autowired
    CartItemDAO cartItemDAO;


    @Test
    void save(){
        MemberVo member = memberDAO.memberFindByNo(40L);
        productVo product = productDAO.getproduct(1509);
        log.info("product={}",product);
        CartItemVo cartItemVo = new CartItemVo(new CartItem(member, product, 2));
        cartItemDAO.cartItemInsert(cartItemVo);

      //  CartItem cartItemVo1 = cartItemDAO.cartItemFindByNum(cartItemVo.getCART_ITEM_NUM());

      /*  CartItem cartItem = cartItemDAO.cartItemFindByNum(cartItemVo.getCART_ITEM_NUM());
        log.info("cartItem={}",cartItem);*/


    }



    @Test
    void select(){
        CartItemVo cartItemVo = cartItemDAO.cartItemFindByNum(14);
        log.info("cartItemVo.getCART_ITEM_STOCK={}",cartItemVo.getCART_ITEM_STOCK());

    }

    @Test
    void findAll(){
        List<CartItemVo> cartItemVos = cartItemDAO.cartITemFindAll();
        for (CartItemVo cartItemVo : cartItemVos) {
            log.info("cartItemVos={}",cartItemVo);
        }
    }

    @Test
    void update(){
        CartItemVo cartItemVo=new CartItemVo(1);
        cartItemDAO.cartItemUpdate(9,cartItemVo);
    }

    @Test
    void delete(){

        cartItemDAO.cartItemDelete(10);
    }

}