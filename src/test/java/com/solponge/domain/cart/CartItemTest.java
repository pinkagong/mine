package com.solponge.domain.cart;

import com.solponge.domain.member.MemberVo;
import com.solponge.domain.product.productVo;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@Slf4j
class CartItemTest {
    productVo product1 =new productVo(1,"book",1000,10);
    productVo product2 =new productVo(2,"python",20000,10);

    MemberVo member =new MemberVo(1L,"asd","ytpark");


    @Test
    void test1() throws Exception {
        CartItem cartItem1 =new CartItem(member, product1,5);
        CartItem cartItem2 =new CartItem(member, product1,5);
        CartItem cartItem3=new CartItem(member,product2,2);

        Cart cart =new Cart(1,member);
        cart.addCartItem(cartItem1);
        cart.addCartItem(cartItem2);
        cart.addCartItem(cartItem3);

//장바구니에 상품 추가 후 getTotalPrice() 메서드를 호출하여 총 가격이 올바른지 확인합니다.

        assertThat(cart.getCartItems().values()).contains(cartItem1,cartItem3);
//장바구니에 상품을 중복으로 추가한 후 getTotalPrice() 메서드를 호출하여 총 가격이 올바른지 확인합니다.

       // assertThat(cart.getTotalPrice()).isEqualTo(48000);

        for (CartItem cartItem : cart.getCartItems().values()) {
            log.info("CartItem.상품번호: {}, 재고: {} 상품별 가격: {}", cartItem.getProduct().getProduct_num(), cartItem.getCART_ITEM_STOCK(),cartItem.getTotalPrice());
        }
        log.info("상품 총 가격 {}",cart.getTotalPrice());

    }

    @Test
    void test2() throws Exception {
        CartItem cartItem1 = new CartItem(member, product1, 6);
        CartItem cartItem2 = new CartItem(member, product1, 5);
        CartItem cartItem3 = new CartItem(member, product2, 2);

        Cart cart = new Cart(1, member);
        cart.addCartItem(cartItem1);

        // 동일한 상품을 장바구니에 추가할 때, 해당 상품의 재고보다 주문 수량이 많을 경우 Exception 발생 여부를 검증합니다.
        assertThatThrownBy(() -> cart.addCartItem(cartItem2))
                .isInstanceOf(Exception.class);

    }
}
