package com.solponge.domain.order_manager.impl;

import com.solponge.domain.order_manager.OrderVo;
import com.solponge.domain.product.productVo;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Repository
public class OrderDAO {
    @Autowired
    SqlSessionTemplate sqlSession;

    public List<OrderVo> ordersearchlist(String SearchSelect, String SearchValue) {
        System.out.println("===> Spring JDBC로 produtsearchlist() 기능 처리");
        System.out.println(SearchSelect);
        System.out.println(SearchValue);
        Map<String, Object> param = new HashMap<>();
        switch (SearchSelect){
            case "payment_num":
                param.put("SearchValue", SearchValue);
                break;
            case "MEMBER_ID":
                param.put("SearchValue", SearchValue);
                break;
        }
        return sqlSession.selectList("order.Searchlist_"+SearchSelect, param);
    }

    //CRUD
    // 글 상세 조회
    public productVo getproduct(int product_num){
        System.out.println("===> Spring JDBC로 getproduct() 기능 처리");
        Map<String, Object> param = new HashMap<>();
        param.put("product_num", product_num);
        return sqlSession.selectOne("collection_of_sql_statements.product", param);
    }


    // 글 수정
    public void updateOrder(OrderVo vo) {
        System.out.println("DAO_updateOrder");
        if (vo == null) {
            // vo가 null인 경우 예외 처리를 수행하거나, 로그를 출력하는 등의 작업을 수행할 수 있습니다.
            // 이 경우 메소드를 실행하지 않고 바로 리턴하도록 합니다.
            System.out.println("null 값임"+vo);
            return;
        }
        Map<String, Object> param = new HashMap<>();
        param.put("delivery_num", vo.getDelivery_num());
        param.put("payment_num", vo.getPayment_num());
        System.out.println(vo.getDelivery_num());
        sqlSession.update("order.updateOrder", param);
    }

    // 글 삭제
    public void deleteBoard(int product_num) {
        Map<String, Object> param = new HashMap<>();
        param.put("NUM", product_num);
        System.out.println("===> Spring JDBC로 deleteBoard() 기능 처리");
        sqlSession.delete("collection_of_sql_statements.deletepro", param);
    }

    public OrderVo getMyOrder(String paymentNum){
        Map<String,Object> param=new HashMap<>();
        param.put("PAYMENT_NUM",paymentNum);
        return sqlSession.selectOne("order.getMyOrder",param);

    }

    // 글 목록 조회
    public List<OrderVo> getBoardList() {
        System.out.println("===> Spring JDBC로 getBoardList() 기능 처리");
        return sqlSession.selectList("order.list");
    }
}
