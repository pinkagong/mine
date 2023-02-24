package com.solponge.domain.product.impl;

import com.solponge.domain.product.productVo;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class productDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    public List<productVo> produtsearchlist(String SearchSelect, String SearchValue) {
        System.out.println("===> Spring JDBC로 produtsearchlist() 기능 처리");
        System.out.println(SearchSelect);
        System.out.println(SearchValue);
        Map<String, Object> param = new HashMap<>();
        switch (SearchSelect){
            case "all":
                param.put("SearchValue", SearchValue);
                break;
            case "product_title":
                param.put("SearchValue", SearchValue);
                break;
            case "product_writer":
                param.put("SearchValue", SearchValue);
                break;
        }
        return sqlSession.selectList("collection_of_sql_statements.Searchlist_"+SearchSelect, param);
    }

    //CRUD
    public List<productVo> getproductList() {
        System.out.println("===> Spring JDBC로 getproductList() 기능 처리");
        return sqlSession.selectList("collection_of_sql_statements.list");
    }
    public List<productVo> getproductNewTop8List() {
        System.out.println("===> Spring JDBC로 getproductNewTop8List() 기능 처리");
        return sqlSession.selectList("collection_of_sql_statements.list_new_8");
    }
    public List<productVo> getproductpopularTop8List() {
        System.out.println("===> Spring JDBC로 getproductpopularTop8List() 기능 처리");
        return sqlSession.selectList("collection_of_sql_statements.list_popular_6");
    }

    public productVo getproduct(int product_num){
        System.out.println("===> Spring JDBC로 getproduct() 기능 처리");
        Map<String, Object> param = new HashMap<>();
        param.put("product_num", product_num);
        return sqlSession.selectOne("collection_of_sql_statements.product", param);
    }

}
