package com.animo.job;

import com.animo.pojo.Reward;
import com.animo.pojo.Usermoney;
import com.animo.service.RewardService;
import com.animo.service.UserMoneyService;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.SpringHandlerInstantiator;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2018/1/2.
 */
@Component(value = "giveAwardJob")
public class GiveAward {

    Logger logger = LoggerFactory.getLogger(GiveAward.class);

    //查奖励未发放的，定时 发放（改reward表状态，更新usermoney表数据）
    @Autowired
    private RewardService rewardService;

   @Autowired
    private UserMoneyService userMoneyService;

    public void execute() {
        logger.info("give award...");
        try{
            List<Reward> rewards = rewardService.selectByStatus("未发放");
            for (Reward r : rewards) {
                r.setStatus("已发放");
                r.setRewardTime((Date) Calendar.getInstance().getTime());


                Usermoney usermoney = userMoneyService.selectByUid(r.getUid());//通过uid查出对应的用户资金表数据
                BigDecimal jlmoney = usermoney.getJlmoney() == null ? BigDecimal.valueOf(0) : usermoney.getJlmoney();
                usermoney.setJlmoney(jlmoney.add(r.getMoney()));//奖励
                BigDecimal symoney = usermoney.getSymoney() == null ? BigDecimal.valueOf(0) : usermoney.getSymoney();
                usermoney.setSymoney(symoney.add(r.getMoney()));//收益
                BigDecimal kymoney = usermoney.getKymoney() == null ? BigDecimal.valueOf(0) : usermoney.getKymoney();
                usermoney.setKymoney(kymoney.add(r.getMoney()));//可用余额
                BigDecimal zmoney = usermoney.getZmoney() == null ? BigDecimal.valueOf(0) : usermoney.getZmoney();
                usermoney.setZmoney(zmoney.add(r.getMoney()));
                rewardService.update(r);
                userMoneyService.update(usermoney);
            }
            System.out.println("都已发放完");
        }catch (NullPointerException e) {
            System.out.println("没有要发放的");
        }

    }
}
