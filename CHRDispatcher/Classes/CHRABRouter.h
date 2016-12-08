//
//  CHRABRouter.h
//  Common
//
//  Created by it on 16/10/25.
//  Copyright © 2016年 DLL. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "CHRABRouterModel.h"
#import "NewPathAndParam.h"


@interface CHRABRouter : NSObject


@property (copy, nonatomic) NSDictionary *transferRules;

//返回新的参数和路径
- (NewPathAndParam *)transferForPath:(NSString *)path params:(NSDictionary *)params andCallback:(void (^)(NSDictionary *result))callback;

@end
