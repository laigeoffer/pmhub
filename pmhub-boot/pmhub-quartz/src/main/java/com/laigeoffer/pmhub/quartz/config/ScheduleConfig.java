//package com.laigeoffer.pmhub.job.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.scheduling.job.SchedulerFactoryBean;
//import javax.sql.DataSource;
//import java.util.Properties;
//
///**
// * 定时任务配置（单机部署建议删除此类和qrtz数据库表，默认走内存会最高效）
// * 
// * @author canghe
// */
//@Configuration
//public class ScheduleConfig
//{
//    @Bean
//    public SchedulerFactoryBean schedulerFactoryBean(DataSource dataSource)
//    {
//        SchedulerFactoryBean factory = new SchedulerFactoryBean();
//        factory.setDataSource(dataSource);
//
//        // quartz参数
//        Properties prop = new Properties();
//        prop.put("org.job.scheduler.instanceName", "RuoyiScheduler");
//        prop.put("org.job.scheduler.instanceId", "AUTO");
//        // 线程池配置
//        prop.put("org.job.threadPool.class", "org.job.simpl.SimpleThreadPool");
//        prop.put("org.job.threadPool.threadCount", "20");
//        prop.put("org.job.threadPool.threadPriority", "5");
//        // JobStore配置
//        prop.put("org.job.jobStore.class", "org.springframework.scheduling.job.LocalDataSourceJobStore");
//        // 集群配置
//        prop.put("org.job.jobStore.isClustered", "true");
//        prop.put("org.job.jobStore.clusterCheckinInterval", "15000");
//        prop.put("org.job.jobStore.maxMisfiresToHandleAtATime", "1");
//        prop.put("org.job.jobStore.txIsolationLevelSerializable", "true");
//
//        // sqlserver 启用
//        // prop.put("org.job.jobStore.selectWithLockSQL", "SELECT * FROM {0}LOCKS UPDLOCK WHERE LOCK_NAME = ?");
//        prop.put("org.job.jobStore.misfireThreshold", "12000");
//        prop.put("org.job.jobStore.tablePrefix", "QRTZ_");
//        factory.setQuartzProperties(prop);
//
//        factory.setSchedulerName("RuoyiScheduler");
//        // 延时启动
//        factory.setStartupDelay(1);
//        factory.setApplicationContextSchedulerContextKey("applicationContextKey");
//        // 可选，QuartzScheduler
//        // 启动时更新己存在的Job，这样就不用每次修改targetObject后删除qrtz_job_details表对应记录了
//        factory.setOverwriteExistingJobs(true);
//        // 设置自动启动，默认为true
//        factory.setAutoStartup(true);
//
//        return factory;
//    }
//}
