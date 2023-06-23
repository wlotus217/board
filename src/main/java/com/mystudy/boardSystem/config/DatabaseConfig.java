package com.mystudy.boardSystem.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.transaction.annotation.EnableTransactionManagement;
 
@Configuration
@MapperScan(basePackages="com.mystudy.boardSystem.mapper") // Mapper 패키지 위치 입력하면 된다.
@EnableTransactionManagement
public class DatabaseConfig {
 
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        //sessionFactory.setTypeAliasesPackage("com.mystudy.boardSystem.vo, com.mystudy.boardSystem.paging");
        
        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
      	// sql 파일들 위치 입력하면 된다.
        sessionFactory.setMapperLocations(resolver.getResources("mybatis/mapper/*.xml")); 
        sessionFactory.setConfigLocation(resolver.getResource("mybatis/mybatis-config.xml"));
  
        return sessionFactory.getObject();
    }
    
    @Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
      final SqlSessionTemplate sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
      return sqlSessionTemplate;
    }
}