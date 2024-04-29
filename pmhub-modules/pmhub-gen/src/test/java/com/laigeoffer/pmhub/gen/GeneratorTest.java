//package com.laigeoffer.pmhub.gen;
//
//import com.baomidou.mybatisplus.annotation.FieldFill;
//import com.baomidou.mybatisplus.core.toolkit.StringPool;
//import com.baomidou.mybatisplus.gen.AutoGenerator;
//import com.baomidou.mybatisplus.gen.InjectionConfig;
//import com.baomidou.mybatisplus.gen.config.*;
//import com.baomidou.mybatisplus.gen.config.po.TableFill;
//import com.baomidou.mybatisplus.gen.config.po.TableInfo;
//import com.baomidou.mybatisplus.gen.config.rules.NamingStrategy;
//import com.baomidou.mybatisplus.gen.engine.VelocityTemplateEngine;
//import com.laigeoffer.pmhub.base.core.core.domain.BaseCoreEntity;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
///**
// * 直接生成必要的类和自动填充字段
// * 简易版，不会生成过多其他代码，只会生成具体类
// * 自动填充字段：create_time,update_time,deleted,create_by,update_by
// * 输入输出位置在本项目下基本固定，无需更改
// *
// * @author     ：canghe
// * @date       ：2023/07/21 15:52
// */
//public class GeneratorTest {
//
//
//    /** ！！！开始》》》》》》》》》以下信息需要你手动更改  */
//
//    /**
//     * 需要生成的表，多个逗号隔开
//     * 获取数据库表数组
//     * mysql -uroot -proot -s  -N -e "select table_name from information_schema.tables where table_schema='security-rbac';"|awk '{print "\""$1"\","}'
//     */
//    final static String[] tables ={
//            "pmhub_category_code_rule"
//
//    };
//    /**
//     * 修改作者
//     */
//    private final static String AUTHOR = "canghe";
//
//    /**
//     * 修改模块简称
//     */
//    private final static String YOUR_MODULE = "codeautoflow";
//
//    /**
//     * 文件类是否生成控制（主要作用，当表结构更新，可通过此自动刷新实体类和xml配置，其他类不再生成）
//     * true：默认都生成
//     * false：只生成entity和mapper.xml 用于开发中表结构更新，自动更新entity和mapper.xml
//     */
//    // 是否生成controller、service、serviceImpl、mapper、dto、vo（适用于前期表结构调整，仅改变entity和xml）
//    private final static boolean IS_GENERATE_STH = false;
//
//    /** ！！！结束》》》》》》》》》以上信息需要你手动更改  */
//
//
//
//    /** 以下配置一次配好后无需修改  */
//
//
//    /** 1、数据源配置（开发or测试环境）  */
//    // url
//    private final static String DATASOURCE_URL = "jdbc:mysql://47.109.46.103:5506/pmhub-manage?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8";
//
//    // DriverName
//    private final static String DATASOURCE_DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
//
//
//    // username
//    private final static String DATASOURCE_USER_NAME = "dev";
//
//    // password
//    private final static String DATASOURCE_PASSWORD = "JKzQwhS@up-hVHRPgwnb";
//
//    /** 2、项目配置 */
//    // 项目路径
//    private final static String PROJECTPATH = System.getProperty("user.dir");
//
//    // 模块名称
//    private final static String MODULE = "pmhub-" + YOUR_MODULE;
//
//
//
//
//    /** 3、包配置(包名主要给模板引用)  */
//    // 父包名
//    private final static String PARENT = "com.laigeoffer.pmhub." + YOUR_MODULE;
//
//    // controller包名
//    private final static String PACK_CONTROLLER = "com.laigeoffer.pmhub.web.controller." + YOUR_MODULE;
//
//    // service包名
//    private final static String PACK_SERVICE = PARENT + ".service";
//
//    // serviceImpl包名
//    private final static String PACK_SERVICE_IMPL = PARENT + ".service.impl";
//
//    // mapper包名
//    private final static String PACK_MAPPER = PARENT + ".mapper";
//
//    // entity包名
//    private final static String PACK_ENTITY = PARENT + ".domain.entity";
//
//    // dto包名
//    private final static String PACK_DTO = PARENT + ".domain.dto";
//
//    // vo包名
//    private final static String PACK_VO = PARENT + ".domain.vo";
//
//
//    /** 4、文件存储路径  */
//    // controller存储路径（一般无需配置，用PATH_COMMON，本项目特殊。controller统一在admin下故单独配置）
//    private final static String PATH_CONTROLLER = PROJECTPATH +  "/pmhub-admin/src/main/java/com/pmhub/web/controller/" + YOUR_MODULE;
//
//    // service、serviceImpl、dto、vo、entity、mapper存储路径
//    private final static String PATH_COMMON = PROJECTPATH + "/"  + MODULE +  "/src/main/java/com/pmhub/" + YOUR_MODULE;
//
//    // mapper.xml存储路径
//    private final static String PATH_XML = PROJECTPATH + "/" + MODULE + "/src/main/resources/mapper/" + YOUR_MODULE;
//
//
//    /** 5、自定义生成类模板控制（默认在本项目下的templates文件夹下面，如需使用自己的模板，可新建，并在此处引入即可）  */
//    // 自定义controller模板
//    private final static String TEMPLATE_CONTROLLER = "/templates/controller.java.vm";
//
//    // 自定义service模板
//    private final static String TEMPLATE_SERVICE = "/templates/service.java.vm";
//
//    // 自定义serviceImpl模板
//    private final static String TEMPLATE_SERVICE_IMPL = "/templates/serviceImpl.java.vm";
//
//    // 自定义mapper模板
//    private final static String TEMPLATE_MAPPER = "/templates/mapper.java.vm";
//
//    // 自定义dto模板
//    private final static String TEMPLATE_DTO = "/templates/dto.java.vm";
//
//    // 自定义vo模板
//    private final static String TEMPLATE_VO = "/templates/vo.java.vm";
//
//    // 自定义entity模板
//    private final static String TEMPLATE_ENTITY = "/templates/entity.java.vm";
//
//    // 自定义mapper.xml模板
//    private final static String TEMPLATE_MAPPER_XML = "/templates/mapper.xml.vm";
//
//
//    /** 6、表前缀（根据实际情况修改）  */
//
//    private final static String TABLE_PREFIX = "pmhub_";
//
//
//
//    /**
//     * 直接运行就可生成对应的类
//     */
//    public static void main(String[] args) {
//
//        // 1、定义代码生成器
//        AutoGenerator mpg = new AutoGenerator();
//
//        // 2、自定义需要填充的字段（需要实现MetaObjectHandler，配置填充策略，本项目实现类：MetaObjectHandlerConfig）
//        List<TableFill> tableFillList = tableFills();
//
//        // 3、全局配置
//        setGlobalConfig(mpg);
//
//        // 4、数据源配置
//        setDatasource(mpg);
//
//        // 5、包配置
//        packageConfig(mpg);
//
//        // 6、自定义配置(自定义模板配置，如controller、mapper.xml、dto、vo等)
//        injectionConfig(mpg);
//
//        // 7、模板配置
//        templateConfig(mpg);
//
//
//        // 8、策略配置
//        strategyConfig(tableFillList, mpg);
//
//        // 9、选择引擎
//        // 选择 freemarker 引擎需要指定如下加，注意 pom 依赖必须有！
////        mpg.setTemplateEngine(new FreemarkerTemplateEngine());
//        mpg.setTemplateEngine(new VelocityTemplateEngine());
//
//        // 10、执行
//        mpg.execute();
//    }
//
//    /**
//     * 策略配置
//     * @param tableFillList  自定义需要填充的字段
//     * @param mpg  代码生成器
//     */
//    private static void strategyConfig(List<TableFill> tableFillList, AutoGenerator mpg) {
//        StrategyConfig strategy = new StrategyConfig();
//        strategy.setNaming(NamingStrategy.underline_to_camel);
//        strategy.setColumnNaming(NamingStrategy.underline_to_camel);
//
//        strategy.setSuperEntityClass(BaseCoreEntity.class);
//        strategy.setEntityLombokModel(true);
//        strategy.setInclude(tables);
////        strategy.setSuperEntityColumns("id");
//        strategy.setControllerMappingHyphenStyle(true);
//        strategy.setRestControllerStyle(true);
//        strategy.setTablePrefix(TABLE_PREFIX);//表前缀
//        strategy.setTableFillList(tableFillList);//设置填充字段，主要针对日期
//        mpg.setStrategy(strategy);
//    }
//
//    /**
//     * 自定义配置
//     * @param mpg          代码生成器
//     */
//    private static void injectionConfig(AutoGenerator mpg) {
//        // 自定义配置(自选模板配置)
//        InjectionConfig cfg = new InjectionConfig() {
//            @Override
//            public void initMap() {
//                Map<String, Object> map = new HashMap<>();
//                // 自定义dto包路径
//                map.put("dtoPackage", PACK_DTO);
//                // 自定义vo包路径
//                map.put("voPackage", PACK_VO);
//                setMap(map);
//            }
//        };
//
//        // 自定义输出配置
//        List<FileOutConfig> focList = new ArrayList<>();
//
//        // 配置自定义entity模板
//        focList.add(new FileOutConfig(TEMPLATE_ENTITY) {
//            @Override
//            public String outputFile(TableInfo tableInfo) {
//                return PATH_COMMON + "/domain/entity/" + tableInfo.getEntityName() + StringPool.DOT_JAVA;
//            }
//        });
//
//        // 配置自定义mapper.xml模版
//        focList.add(new FileOutConfig(TEMPLATE_MAPPER_XML) {
//            @Override
//            public String outputFile(TableInfo tableInfo) {
//                // 自定义输入文件名称
//                return PATH_XML + "/"  + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_XML;
//            }
//        });
//
//
//        if (IS_GENERATE_STH) {
//            //配置自定义controller模版
//            focList.add(new FileOutConfig(TEMPLATE_CONTROLLER) {
//                @Override
//                public String outputFile(TableInfo tableInfo) {
//                    return PATH_CONTROLLER + "/" + tableInfo.getEntityName() + "Controller" + StringPool.DOT_JAVA;
//                }
//            });
//
//            // 配置自定义service模版
//            focList.add(new FileOutConfig(TEMPLATE_SERVICE) {
//                @Override
//                public String outputFile(TableInfo tableInfo) {
//                    return PATH_COMMON + "/service/" + tableInfo.getEntityName() + "Service" + StringPool.DOT_JAVA;
//                }
//            });
//
//            // 配置自定义serviceImpl模版
//            focList.add(new FileOutConfig(TEMPLATE_SERVICE_IMPL) {
//                @Override
//                public String outputFile(TableInfo tableInfo) {
//                    return PATH_COMMON + "/service/impl/" + tableInfo.getEntityName() + "ServiceImpl" + StringPool.DOT_JAVA;
//                }
//            });
//
//            //自定义生成dto类
//            focList.add(new FileOutConfig(TEMPLATE_DTO) {
//                @Override
//                public String outputFile(TableInfo tableInfo) {
//                    return PATH_COMMON + "/domain/dto/"  + tableInfo.getEntityName() + "DTO" + StringPool.DOT_JAVA;
//                }
//            });
//
//
//            //自定义生成VO类
//            focList.add(new FileOutConfig(TEMPLATE_VO) {
//                @Override
//                public String outputFile(TableInfo tableInfo) {
//                    return PATH_COMMON + "/domain/vo/"  + tableInfo.getEntityName() + "VO" + StringPool.DOT_JAVA;
//                }
//            });
//
//            // 自定义生层mapper
//            focList.add(new FileOutConfig(TEMPLATE_MAPPER) {
//                @Override
//                public String outputFile(TableInfo tableInfo) {
//                    return PATH_COMMON + "/mapper/"  + tableInfo.getEntityName() + "Mapper" + StringPool.DOT_JAVA;
//                }
//            });
//
//        }
//
//
//        cfg.setFileOutConfigList(focList);
//        mpg.setCfg(cfg);
//    }
//
//    /**
//     * 模板配置(自定义生成路径)
//     * @param mpg 代码生成器
//     */
//    private static void templateConfig(AutoGenerator mpg) {
//        TemplateConfig tc = new TemplateConfig();
//        // 自定义生成路径,不用默认的
//        tc.setController(null);
//        tc.setService(null);
//        tc.setServiceImpl(null);
//        tc.setMapper(null);
//        tc.setEntity(null);
//        tc.setXml(null);
//        mpg.setTemplate(tc);
//    }
//
//
//    /**
//     * 包配置
//     * @param mpg  代码生成器
//     */
//    private static void packageConfig(AutoGenerator mpg) {
//        PackageConfig pc = new PackageConfig();
////        pc.setModuleName(scanner("模块名"));
//        //根据实际项目名称修改
//        pc.setParent(null);//不设置的原因是，本项目的controller是统一放在admin包下面的，故每个子包都配置完整包名
//
//        // controller、service、serviceImpl、mapper、entity、xml是mybatis-plus默认识别的包名，可直接在这配置，对于其他包名如dto、vo等，需要在自定义配置中配置
//        pc.setController(PACK_CONTROLLER);
//        pc.setService(PACK_SERVICE);
//        pc.setServiceImpl(PACK_SERVICE_IMPL);
//        pc.setMapper(PACK_MAPPER);
//        pc.setEntity(PACK_ENTITY);
//        mpg.setPackageInfo(pc);
//    }
//
//    /**
//     * 全局配置
//     * @param mpg 代码生成器
//     */
//    private static void setGlobalConfig(AutoGenerator mpg) {
//        GlobalConfig gc = new GlobalConfig();
//        gc.setOutputDir(PROJECTPATH + "/" + MODULE + "/src/main/java");
//        gc.setAuthor(AUTHOR);
//        gc.setOpen(false);
//        gc.setServiceName("%sService");
//        gc.setServiceImplName("%sServiceImpl");
//        // 是否覆盖已有文件
//        gc.setFileOverride(true);
//        gc.setBaseResultMap(true);
//        gc.setBaseColumnList(true);
//
//        mpg.setGlobalConfig(gc);
//    }
//
//    /**
//     * 自定义需要填充的字段
//     */
//    private static List<TableFill> tableFills() {
//        // 自定义需要填充的字段
//        List<TableFill> tableFillList = new ArrayList<TableFill>();
//        //如 每张表都有一个创建时间、修改时间
//        //而且这基本上就是通用的了，新增时，创建时间和修改时间同时修改
//        //修改时，修改时间会修改，
//        //虽然像Mysql数据库有自动更新几只，但像ORACLE的数据库就没有了，
//        //使用公共字段填充功能，就可以实现，自动按场景更新了。
//        //如下是配置
//        TableFill createTime = new TableFill("create_time", FieldFill.INSERT);
//        TableFill updateTime = new TableFill("update_time", FieldFill.INSERT_UPDATE);
//        TableFill deleted = new TableFill("deleted", FieldFill.INSERT);
//        TableFill createBy = new TableFill("create_by", FieldFill.INSERT);
//        TableFill updateBy = new TableFill("update_by", FieldFill.INSERT_UPDATE);
//
//        tableFillList.add(createTime);
//        tableFillList.add(updateTime);
//        tableFillList.add(deleted);
//        tableFillList.add(createBy);
//        tableFillList.add(updateBy);
//        return tableFillList;
//    }
//
//    /**
//     * 数据源配置
//     * @param mpg 代码生成器
//     */
//    private static void setDatasource(AutoGenerator mpg) {
//        DataSourceConfig dsc = new DataSourceConfig();
//        dsc.setUrl(DATASOURCE_URL);
//        // dsc.setSchemaName("public");
//        //mysql驱动
//        dsc.setDriverName(DATASOURCE_DRIVER_NAME);
//        dsc.setUsername(DATASOURCE_USER_NAME);
//        dsc.setPassword(DATASOURCE_PASSWORD);
//        mpg.setDataSource(dsc);
//    }
//}
