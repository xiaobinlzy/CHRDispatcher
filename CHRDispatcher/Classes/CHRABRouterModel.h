//
//  CHRABRouterModel.h
//  Common
//
//  Created by it on 16/10/27.
//  Copyright © 2016年 DLL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CHRABRouterModelParam : NSObject
;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@end


@interface CHRABRouterModel : NSObject

@property (nonatomic, copy) NSString *originPath;
@property (nonatomic, copy) NSString *targetPath;
@property (nonatomic, strong) NSArray<CHRABRouterModelParam *> *routerParamArray;


@end
