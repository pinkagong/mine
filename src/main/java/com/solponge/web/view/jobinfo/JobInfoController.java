package com.solponge.web.view.jobinfo;


import com.solponge.domain.JobScrap.InfScrapVO;
import com.solponge.domain.JobScrap.JobScrapService;
import com.solponge.domain.JobScrap.companyScrapVO;
import com.solponge.domain.jobinfo.JopInfoService;
import com.solponge.domain.jobinfo.JopInfoVo;
import com.solponge.domain.member.MemberVo;
import com.solponge.web.view.login.session.SessionConst;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/com.solponge")
@SessionAttributes(names = SessionConst.LOGIN_MEMBER)
@RequiredArgsConstructor // 초기화 되지 않게 알아서 실행되는 녀석
public class JobInfoController {
    @Autowired
    private final JobScrapService jobscrapService;
    @Autowired
    private final JopInfoService jopinfoService;

    @GetMapping("/jobinfolist")
    public String jobinfolist(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                              Model model, HttpServletRequest request){
        model.addAttribute("member",loginMember);
//        model.addAttribute("getJopInfoList", jopinfoService.getJopInfoList());
        int data = jopinfoService.getJopInfoList();
        System.out.println(data);
        int pageSize = 20; // number of items per page
        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, data);
        int totalPages = (int) Math.ceil((double) data / pageSize);
//        List<JopInfoVo> paginatedProducts = data.subList(start, end); // get the current page of products
        List<JopInfoVo> paginatedProducts = jopinfoService.getJopInfoListpage(start, end);
        model.addAttribute("paginatedjobinfo", paginatedProducts);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("url", "?");
        try{
            Long userNo = loginMember.getMEMBER_NO();
            System.out.println(userNo);
            String id = loginMember.getMEMBER_ID();
            System.out.println(id);
            if(id !=null) {
                System.out.println("비교시작");
                List<companyScrapVO> cvo = jobscrapService.getcompanyScrapVOScrapList(userNo);
                List<InfScrapVO> ivo = jobscrapService.getinfoScrapVOScrapList(userNo);
                Map<String, String> params_company = new HashMap<>();
                Map<String, String> params_info = new HashMap<>();
                for(companyScrapVO c :cvo){
                    params_company.put("response_"+c.getCompanyName(), c.getCompanyName());
                }
                for(InfScrapVO c :ivo){
                    params_info.put("response_"+c.getInfoname(), c.getInfoname());
                }
                model.addAttribute("JobScrap", params_company);
                model.addAttribute("JobScrap2", params_info);
            }
        }catch (Exception e){
            System.out.println("오류발생");
        }
        return "jobinfo/jobinfotlist";
    }

    @GetMapping("/jobinfolist/search")
    public String jobinfosearchlist(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                                   Model model, HttpServletRequest request,
                                   @RequestParam("SearchSelect") String SearchSelec,
                                   @RequestParam("SearchValue") String SearchValue){
        model.addAttribute("member",loginMember);
        int data = jopinfoService.JopInfosearchlist_count(SearchSelec, SearchValue);
        System.out.println(data);
        int pageSize = 20; // number of items per page
        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, data);
        int totalPages = (int) Math.ceil((double) data / pageSize);
        List<JopInfoVo> paginatedProducts = jopinfoService.JopInfosearchlist_page(SearchSelec, SearchValue, start, end); // get the current page of products
        model.addAttribute("paginatedjobinfo", paginatedProducts);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        String url = request.getQueryString();
        System.out.println(url);
        if (url.contains("&page=")){
            int idx = url.indexOf("&page=");
            url = url.substring(0, idx);
        }
//        url = url.replaceAll("&page=\\w", "");
        String inputurl ="";
        if (url.contains("SearchSelect")){
            inputurl += "search?"+url+"&";
        } else {
            inputurl += "?";
        }
        System.out.println("들어가는 url: "+inputurl);
        model.addAttribute("url", inputurl);
        model.addAttribute("status", "Yes");
        try{
            Long userNo = loginMember.getMEMBER_NO();
            System.out.println(userNo);
            String id = loginMember.getMEMBER_ID();
            System.out.println(id);
            if(id !=null) {
                System.out.println("비교시작");
                List<companyScrapVO> cvo = jobscrapService.getcompanyScrapVOScrapList(userNo);
                List<InfScrapVO> ivo = jobscrapService.getinfoScrapVOScrapList(userNo);
                Map<String, String> params_company = new HashMap<>();
                Map<String, String> params_info = new HashMap<>();
                for(companyScrapVO c :cvo){
                    params_company.put("response_"+c.getCompanyName(), c.getCompanyName());
                }
                for(InfScrapVO c :ivo){
                    params_info.put("response_"+c.getInfoname(), c.getInfoname());
                }
                model.addAttribute("JobScrap", params_company);
                model.addAttribute("JobScrap2", params_info);
            }
        }catch (Exception e){
            System.out.println("오류발생");
        }

        return "jobinfo/jobinfotlist";
    }

    @GetMapping("/jobinfolist/{companyname}")
    public String companynamejobinfolist(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                                   Model model, HttpServletRequest request,
                                   @PathVariable String companyname){
        System.out.println("회사모음");
        System.out.println(companyname);
        model.addAttribute("member",loginMember);
        List<JopInfoVo> data = jopinfoService.getCompanyTojobinfoList(companyname);
//        System.out.println(data);
        int pageSize = 10; // number of items per page
        int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, data.size());
        int totalPages = (int) Math.ceil((double) data.size() / pageSize);
        List<JopInfoVo> paginatedProducts = data.subList(start, end);
        model.addAttribute("paginatedjobinfo", paginatedProducts);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        String url = request.getRequestURI();
        System.out.println("url은"+url);
        if (url.contains("&page=")){
            int idx = url.indexOf("&page=");
            url = url.substring(0, idx);
        }
//        url = url.replaceAll("&page=\\w", "");
        String inputurl ="";
        if (url.contains("SearchSelect")){
            inputurl += "search?"+url+"&";
        } else {
            inputurl += "?";
        }
        System.out.println("들어가는 url: "+inputurl);
        model.addAttribute("url", inputurl);
        model.addAttribute("status", "Yes");
        try{
            Long userNo = loginMember.getMEMBER_NO();
            System.out.println(userNo);
            String id = loginMember.getMEMBER_ID();
            System.out.println(id);
            if(id !=null) {
                System.out.println("비교시작");
                List<companyScrapVO> cvo = jobscrapService.getcompanyScrapVOScrapList(userNo);
                List<InfScrapVO> ivo = jobscrapService.getinfoScrapVOScrapList(userNo);
                Map<String, String> params_company = new HashMap<>();
                Map<String, String> params_info = new HashMap<>();
                for(companyScrapVO c :cvo){
                    params_company.put("response_"+c.getCompanyName(), c.getCompanyName());
                }
                for(InfScrapVO c :ivo){
                    params_info.put("response_"+c.getInfoname(), c.getInfoname());
                }
                model.addAttribute("JobScrap", params_company);
                model.addAttribute("JobScrap2", params_info);
            }
        }catch (Exception e){
            System.out.println("오류발생");
        }

        return "jobinfo/companytlist";
    }



    @GetMapping("/jobinfo/{INFONUM}")
    public String jobinfopage(@SessionAttribute(name = SessionConst.LOGIN_MEMBER,required = false) MemberVo loginMember,
                              @PathVariable int INFONUM, Model model){
        System.out.println("INFONUM,"+INFONUM);
        JopInfoVo vo = jopinfoService.getJopInfo(INFONUM);
        model.addAttribute("member",loginMember);
        System.out.println(INFONUM);
        model.addAttribute("JopInfoVo", vo);
        try{
            Long userNo = loginMember.getMEMBER_NO();
            System.out.println(userNo);
            String id = loginMember.getMEMBER_ID();
            System.out.println(id);
            if(id !=null) {
                System.out.println("비교시작");
                List<companyScrapVO> cvo = jobscrapService.getcompanyScrapVOScrapList(userNo);
                List<InfScrapVO> ivo = jobscrapService.getinfoScrapVOScrapList(userNo);
                Map<String, String> params_company = new HashMap<>();
                Map<String, String> params_info = new HashMap<>();
                for(companyScrapVO c :cvo){
                    params_company.put("response_"+c.getCompanyName(), c.getCompanyName());
                    System.out.println(c.getCompanyName());
                }
                for(InfScrapVO c :ivo){
                    params_info.put("response_"+c.getInfoname(), c.getInfoname());
                }
                model.addAttribute("JobScrap", params_company);
                model.addAttribute("JobScrap2", params_info);
            }
        }catch (Exception e){
            System.out.println("오류발생");
        }

        return "jobinfo/jobinfopage";
    }

    private MemberVo getLoginMember(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null ? (MemberVo) session.getAttribute(SessionConst.LOGIN_MEMBER) : null;
    }
}
