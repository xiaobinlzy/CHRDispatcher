//
//  CHRABRouterModel.m
//  Common
//
//  Created by it on 16/10/27.
//  Copyright © 2016年 DLL. All rights reserved.
//

#import "CHRABRouterModel.h"


@implementation CHRABRouterModelParam

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_key forKey:@"key"];
    [aCoder encodeObject:_value forKey:@"value"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        _key = [aDecoder decodeObjectForKey:@"key"];
        _value = [aDecoder decodeObjectForKey:@"value"];
    }
    return self;
}

@end


@implementation CHRABRouterModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_originPath forKey:@"originPath"];
    [aCoder encodeObject:_targetPath forKey:@"targetPath"];
    [aCoder encodeObject:_routerParamArray forKey:@"routerParamArray"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        _originPath = [aDecoder decodeObjectForKey:@"originPath"];
        _targetPath = [aDecoder decodeObjectForKey:@"targetPath"];
        _routerParamArray = [aDecoder decodeObjectForKey:@"routerParamArray"];
    }
    return self;
}

@end
