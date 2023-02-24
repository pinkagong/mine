package com.solponge;

import com.solponge.web.view.login.interceptor.AdminLoginCheckInterceptor;
import com.solponge.web.view.login.interceptor.LoginCheckInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
@Configuration
public class WebConfig implements WebMvcConfigurer {
    public void addInterceptors(InterceptorRegistry registry){

        registry.addInterceptor(new AdminLoginCheckInterceptor())
                .order(1)
                .addPathPatterns("/com.solponge/admin/**");

        // LoginCheckInterceptor를 등록합니다.
        registry.addInterceptor(new LoginCheckInterceptor())
                .order(2)
                .addPathPatterns("/**")
                .excludePathPatterns(
                        "/com.solponge/main",
                        "/com.solponge/join",
                        "/com.solponge/login",
                        "/com.solponge/product/**",
                        "/css/**",
                        "/img/**",
                        "/js/**"

                );
        
    }
}
