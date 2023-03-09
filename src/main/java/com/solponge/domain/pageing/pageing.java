package com.solponge.domain.pageing;

import com.solponge.domain.product.productVo;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class pageing {
    int pageSize;
    int currentPage;
    int start;
    int end;
    int totalPages;
    public pageing(int pageSize, HttpServletRequest request, List<?> data, Model model){
        this.pageSize=pageSize;
        this.currentPage=(request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
        this.start = (currentPage - 1) * pageSize;
        this.end = Math.min(start + pageSize, data.size());
        this.totalPages = (int) Math.ceil((double) data.size() / pageSize);
        List<?> subVo = data.subList(start, end);
        model.addAttribute("paginatedProducts", subVo);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("url", "?");
    }
}
