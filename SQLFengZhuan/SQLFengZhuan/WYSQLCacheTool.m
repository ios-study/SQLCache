//
//  WYSQLCacheTool.m
//  NestleShort
//
//  Created by tiannuo on 15/6/12.
//  Copyright (c) 2015年 Oftenfull. All rights reserved.
//

#import "WYSQLCacheTool.h"
#import "FMDB.h"
#import "WYSQLModel.h"

@implementation WYSQLCacheTool
static FMDatabase *_db;
//where是条件
//创建表: creat table 表名 (字段名 字段数据类型 是否为主键, 字段名 字段数据类型, 字段名 字段数据类型...)
//查: select 字段名 (或者*) from 表名 where 字段名 = 值
//增: insert into 表名 (字段1, 字段2...) values (值1, 值2...)
//改: update 表名 set 字段 = 值 where 字段 = 值
//删: delete from 表名 where 字段 = 值
+ (void)initialize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"mySqlCache.db"];
    NSLog(@"filePath---%@----%@", filePath, cachePath);
    // 创建一个数据库
    _db = [FMDatabase databaseWithPath:filePath];
    if([_db open]){
        NSLog(@"打开成功");
    }else{
        NSLog(@"打开失败");
    }
}

+ (void)CreateTable:(NSString *)Name
{
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (ID integer primary key autoincrement,goodsName text,GoodsCode text,CreateDate text);",Name];
    
   
    BOOL flag =[_db executeUpdate:sql];
    if (flag) {
        NSLog(@"flag创建成功");
    }else{
        NSLog(@"flag创建失败");
    }
}
+ (NSArray*)SelectTableSQLname:(NSString *)sqlName WithgoodsName:(NSString *)goodsName WithGoodsCode:(NSString *)GoodsCode
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where goodsName like '%%%@%%' or GoodsCode like '%%%@%%';",sqlName,goodsName,GoodsCode];
    
    FMResultSet *set = [_db executeQuery:sql];
    
    
    NSMutableArray *marray = [NSMutableArray array];
   
    while ([set next]) {
        
//        [set stringForColumn:@"goodsName"];
//        [set stringForColumn:@"GoodsCode"];
//        NSData *data = [set dataForColumn:@"dict"];
//       NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        WYSQLModel *model = [[WYSQLModel alloc] init];
        model.ID = [set intForColumn:@"ID"];
        model.goodsName = [set stringForColumn:@"goodsName"];
        model.GoodsCode = [set stringForColumn:@"GoodsCode"];
        model.CreateDate = [set stringForColumn:@"CreateDate"];
        [marray addObject:model];
    }
    return marray;
}

+ (void)UpdateSQLname:(NSString *)sqlName WithgoodsName:(NSString *)goodsName WithGoodsCode:(NSString *)GoodsCode With:(int)ID
{
//    NSNumber *number = [NSNumber numberWithInteger:[GoodsCode integerValue]];
    NSString *sql = [NSString stringWithFormat:@"update %@ set GoodsCode = '%@' , goodsName = '%@' where ID = '%d'",sqlName,GoodsCode,goodsName, ID];
   // XHZLog(@"sql--%@",sql);
    
    BOOL flag = [_db executeUpdate:sql];
    if (flag) {
        NSLog(@"更新成功");
       
    }else{
        NSLog(@"更新失败");
        
    }
}

+ (void)UpdateSQLnames:(NSString *)sqlName WithgoodsName:(NSString *)goodsName WithGoodsCode:(NSString *)GoodsCode With:(NSMutableArray *)Array
{
    //    NSNumber *number = [NSNumber numberWithInteger:[GoodsCode integerValue]];
    NSString *sql = [NSString stringWithFormat:@"update %@ set dict = ? where GoodsCode = '%@' and goodsName = '%@'",sqlName,GoodsCode,goodsName];
    // XHZLog(@"sql--%@",sql);
    
    
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:Array];
    
    BOOL flag = [_db executeUpdate:sql,dictData];
    if (flag) {
        // XHZLog(@"success");
        
    }else{
        //  XHZLog(@"failure");
        
    }
}

+ (void)SaveTable:(NSString *)sqlName WithModel:(WYSQLModel*)sales;
{
//    for (NSDictionary *salesDict in sales) {
    
        NSString *goodsName = sales.goodsName;
        NSString *GoodsCode = sales.GoodsCode;
        NSString *CreateDate = sales.CreateDate;
        //  XHZLog(@"goodsName%@-GoodsCode%@----salesDict%@",goodsName,GoodsCode,salesDict);
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:salesDict];
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (goodsName,GoodsCode,CreateDate) values(?,?,?);",sqlName];
      //  NSNumber *number = [NSNumber numberWithInteger:[GoodsCode integerValue]];
        BOOL flag = [_db executeUpdate:sql,goodsName,GoodsCode,CreateDate];
        if (flag) {
            NSLog(@"sqlName插入成功 ");
        }else{
            NSLog(@"sqlName插入失败");
        }
//    }
}
+ (NSArray*)sqlName:(NSString*)sqlName
{
    // 进入程序第一次获取的查询语句
    NSString *sql = [NSString stringWithFormat:@"select *from %@",sqlName];
   // XHZLog(@"sql----%@",sql);
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *arrM = [NSMutableArray array];
    
    while ([set next]) {
//        NSData *data = [set dataForColumn:@"dict"];
//        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        WYSQLModel *model = [[WYSQLModel alloc] init];
        model.ID = [set intForColumn:@"ID"];
        model.goodsName = [set stringForColumn:@"goodsName"];
        model.GoodsCode = [set stringForColumn:@"GoodsCode"];
        model.CreateDate = [set stringForColumn:@"CreateDate"];
        
        [arrM addObject:model];
    }
    return arrM;
}
+ (void)DeleteTable:(NSString*)name
{
    
}
@end
