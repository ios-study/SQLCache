//
//  WYSQLCacheTool.h
//  NestleShort
//
//  Created by tiannuo on 15/6/12.
//  Copyright (c) 2015年 Oftenfull. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WYSQLModel;
@interface WYSQLCacheTool : NSObject
/**
 *  创建一张表
 *
 *  @param Name 表名
 */
+ (void)CreateTable:(NSString *)Name;

/**
 *  查询
 *
 *  @param Name <#Name description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray*)SelectTableSQLname:(NSString *)sqlName WithgoodsName:(NSString *)goodsName WithGoodsCode:(NSString *)GoodsCode;


/**
 *  修改
 *
 *  @param Name  <#Name description#>
 *  @param text1 <#text1 description#>
 *  @param text2 <#text2 description#>
 *
 *  @return <#return value description#>
 */
+ (void)UpdateSQLname:(NSString *)sqlName WithgoodsName:(NSString *)goodsName WithGoodsCode:(NSString *)GoodsCode With:(int)ID;

+ (void)UpdateSQLnames:(NSString *)sqlName WithgoodsName:(NSString *)goodsName WithGoodsCode:(NSString *)GoodsCode With:(NSMutableArray *)Array;

/**
 *  保存
 *
 *  @param sales <#sales description#>
 */
+ (void)SaveTable:(NSString *)sqlName WithModel:(WYSQLModel*)sales;

/**
 *  删除
 *
 *  @param name <#name description#>
 */
+ (void)DeleteTable:(NSString*)name;

/**
 *  从数据库中读取数据
 *
 *  @param sqlName <#sqlName description#>
 *
 *  @return <#return value description#>
 */
+ (NSArray*)sqlName:(NSString*)sqlName;
@end
