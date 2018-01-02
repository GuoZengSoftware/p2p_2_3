package com.animo.controller.fontviews;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by Administrator on 2017/12/28.
 */
@Controller
@RequestMapping("/")
public class DynamicFontViews {

    @GetMapping("dyna")
    public String dyna(){
        return "dyna";
    }
    @GetMapping("list")
    public String list(){
        return "dynamic/qlistdyna";
    }

    @GetMapping("listdyna")
    public String listdyna(){
        return "dynamic/qlistdynamic";
    }

    @GetMapping("byqlist")
    public ModelAndView byIddync(Integer id){
        ModelAndView mav = new ModelAndView("dynamic/qlistdynamic");
        mav.addObject("id",id);
        return mav;
    }

}