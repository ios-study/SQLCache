//
//  ViewController.m
//  SQLFengZhuan
//
//  Created by 许惠占 on 2016/12/6.
//  Copyright © 2016年 许惠占. All rights reserved.
//

#import "ViewController.h"
#import "WYSQLCacheTool.h"
#import "WYSQLModel.h"

#define SQLName @"tb_Test"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    }

/*
 建表
 **/
- (IBAction)createTableClick:(UIButton *)sender {
    [WYSQLCacheTool CreateTable:SQLName];
}

/*
 插入
 **/
- (IBAction)insertClick:(UIButton *)sender {
    WYSQLModel *model = [[WYSQLModel alloc] init];
    model.goodsName = @"123";
    model.GoodsCode = @"adcd";
    model.CreateDate = @"2016-12-5";
    [WYSQLCacheTool SaveTable:SQLName WithModel:model];

}

/*
 更新
 **/
- (IBAction)updateClick:(UIButton *)sender {

    [WYSQLCacheTool UpdateSQLname:SQLName WithgoodsName:@"545454" WithGoodsCode:@"adcdgfgfg" With:1];

}

/*
 查询
 **/
- (IBAction)selectClick:(UIButton *)sender {
    NSArray *ary = [WYSQLCacheTool sqlName:SQLName];
    NSLog(@"ary---%lu---%@", (unsigned long)ary.count, ary);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
