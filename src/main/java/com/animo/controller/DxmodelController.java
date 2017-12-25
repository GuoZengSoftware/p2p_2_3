package com.animo.controller;

import com.animo.common.Pager;
import com.animo.common.ServerResponse;
import com.animo.pojo.Dxmodel;
import com.animo.service.DxmodelService;
import com.animo.service.JklxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by CHEN JX on 2017/12/22.
 */
@RestController
@RequestMapping("/dxmodel/data/json")
public class DxmodelController {

    @Autowired
    private DxmodelService dxmodelService;


    /**
     * 短信模板保存
     * @param dxmodel
     * @return
     */
    @PostMapping("save")
    public ServerResponse save(Dxmodel dxmodel) {

        return dxmodelService.save(dxmodel);
    }

    /**
     * 短信模板移除
     * @param dxid
     * @return
     */
    @RequestMapping("remove")
    public ServerResponse removeById(Integer dxid) {
        return dxmodelService.removeById(dxid);
    }

    /**
     * 短信模板修改
     * @param dxmodel
     * @return
     */
    @RequestMapping("update")
    public ServerResponse update(Dxmodel dxmodel) {
     return dxmodelService.update(dxmodel);
    }


    /**
     * 短信模板分页
     * @param pageNo
     * @param pageSize
     * @return
     */
    @RequestMapping("pager")
    public Pager pager(int pageNo,int pageSize) {
        return dxmodelService.listPager(pageNo,pageSize);
    }
}
