package com.solponge.domain.member.impl;

import com.solponge.domain.member.MemberVo;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
public class TEst {
    @Autowired
    MemberDAO memberDAO;
    @Autowired
    MemberServiceImpl memberService;

    @Test
    void jo(){
        MemberVo member=new MemberVo(
                "memberIasdasdd",
                "memberPassword",
                "memberName",
                "asdasdasdasdas",
                "email",
                "101-2131-5135"
        );
        memberService.join(member);
    }

    @Test
    void update(){
        MemberVo memberVo =new MemberVo("zxc","asdsa/123/123","asdasda@asdasda","123-1233-3123");
        memberService.update(100L,memberVo);
    }

    @Test
    void findAll(){
        List<MemberVo> all = memberService.findAll();
        log.info("all={}",all);

    }
}
