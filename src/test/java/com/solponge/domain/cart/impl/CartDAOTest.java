package com.solponge.domain.cart.impl;

import com.solponge.domain.cart.Cart;
import com.solponge.domain.cart.CartListVo;
import com.solponge.domain.cart.CartVo;
import com.solponge.domain.member.MemberVo;
import com.solponge.domain.member.impl.MemberDAO;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@Slf4j
class CartDAOTest {
    @Autowired
    MemberDAO memberDAO;
    @Autowired
    CartDAO cartDAO;

    /*MemberVo member = memberDAO.memberFindByNo(41L);*/

    @Test
    void cartInsert() {
        MemberVo member = memberDAO.memberFindByNo(40L);
        CartVo cartVo = new CartVo(Math.toIntExact(member.getMEMBER_NO()));
        log.info("cartVo={}",cartVo.getMEMBER_NUM());
        cartDAO.cartInsert(cartVo);
    }

    @Test
    void select(){
        CartVo cartVo = cartDAO.cartFindByNum(1);
        log.info("cartVo={}",cartVo.getCART_NUM());
        log.info("cartVo.member_no={}",cartVo.getMEMBER_NUM());
    }

    @Test
    void selectAll(){
        List<CartVo> cartVos = cartDAO.cartFindAll();
        for (CartVo cartVo : cartVos) {
            log.info("cartVos={}",cartVos);
        }

    }

    @Test
    void cartDelete(){
        MemberVo member = memberDAO.memberFindByNo(41L);
        cartDAO.cartDelete(3);
    }

    @Test
    void memberCartList(){
        List<CartListVo> cartListVos = cartDAO.showMemberCart(40);
            log.info("memberCartVos={}",cartListVos);
    }


}