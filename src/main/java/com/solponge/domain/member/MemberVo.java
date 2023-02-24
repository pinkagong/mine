package com.solponge.domain.member;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Data
@Setter
@Getter
public class MemberVo {
    private Long MEMBER_NO;

    private Grade MEMBER_GRADE;
    @NotEmpty
    private String MEMBER_ID;
    @NotEmpty
    private String MEMBER_PWD;
    @NotEmpty
    private String MEMBER_NAME;
    /**
     * 주소
     */
    private String MEMBER_ADDRESS;
    @NotEmpty
    private String MEMBER_ADDRESS1;
    @NotEmpty
    private String MEMBER_ADDRESS2;

    private String MEMBER_ADDRESS3;
    /**
     * 이메일
     */

    private String MEMBER_EMAIL;
    private String MEMBER_EMAIL1;
    private String MEMBER_EMAIL2;
    /**
     * 휴대폰
     */
    private String MEMBER_PHONE;
    private String MEMBER_PHONE1;
    private String MEMBER_PHONE2;
    private String MEMBER_PHONE3;

    private String MEMBER_DATE;

    public MemberVo() {
    }

    public MemberVo(String MEMBER_ID, String MEMBER_PWD, String MEMBER_NAME, String MEMBER_ADDRESS, String MEMBER_EMAIL, String MEMBER_PHONE) {
        this.MEMBER_ID = MEMBER_ID;
        this.MEMBER_PWD = MEMBER_PWD;
        this.MEMBER_NAME = MEMBER_NAME;
        this.MEMBER_ADDRESS = MEMBER_ADDRESS;
        this.MEMBER_EMAIL = MEMBER_EMAIL;
        this.MEMBER_PHONE = MEMBER_PHONE;
    }

    public MemberVo(String MEMBER_PWD, String MEMBER_ADDRESS, String MEMBER_EMAIL, String MEMBER_PHONE) {
        this.MEMBER_PWD = MEMBER_PWD;
        this.MEMBER_ADDRESS = MEMBER_ADDRESS;
        this.MEMBER_EMAIL = MEMBER_EMAIL;
        this.MEMBER_PHONE = MEMBER_PHONE;
    }

    public MemberVo(String MEMBER_PWD, String MEMBER_NAME, String MEMBER_ADDRESS, String MEMBER_EMAIL, String MEMBER_PHONE) {
        this.MEMBER_PWD = MEMBER_PWD;
        this.MEMBER_NAME = MEMBER_NAME;
        this.MEMBER_ADDRESS = MEMBER_ADDRESS;
        this.MEMBER_EMAIL = MEMBER_EMAIL;
        this.MEMBER_PHONE = MEMBER_PHONE;
    }
}
