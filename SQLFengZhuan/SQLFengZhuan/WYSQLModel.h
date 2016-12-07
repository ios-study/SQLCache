//
//  WYSQLModel.h
//  SQLFengZhuan
//
//  Created by 许惠占 on 2016/12/7.
//  Copyright © 2016年 许惠占. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYSQLModel : NSObject
@property (nonatomic, assign) int ID;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *GoodsCode;
@property (nonatomic, copy) NSString *CreateDate;
@end
