//
//  CHRABRouter.m
//  Common
//
//  Created by it on 16/10/25.
//  Copyright © 2016年 DLL. All rights reserved.
//

#import "CHRABRouter.h"


@implementation CHRABRouter


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[self filePath]];
        if (dic) {
            _transferRules = dic;
        }
    }
    return self;
}

- (NSString *)filePath {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ABTestRouterPath"];
}

- (void)setTransferRules:(NSDictionary *)transferRules {
    _transferRules = [transferRules copy];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [_transferRules writeToFile:[self filePath] atomically:YES];
    });
}

- (NewPathAndParam *)transferForPath:(NSString *)path params:(NSDictionary *)params andCallback:(void (^)(NSDictionary *))callback
{
    NSDictionary *rules = self.transferRules;
    if (rules.count > 0) {
        NewPathAndParam *newPathParam = [[NewPathAndParam alloc] init];
        CHRABRouterModel *model = [rules objectForKey:path];
        if (model) {
            newPathParam.path = model.targetPath;
            NSDictionary *newParams = [self newParamsFromOriginParams:params andRouterParamArray:model.routerParamArray];
            newPathParam.params = newParams;
            return newPathParam;
        }
    }
    return nil;
}

// 根据router参数转换规则，和原有参数，获取新的参数集合。
- (NSDictionary *)newParamsFromOriginParams:(NSDictionary *)originParams andRouterParamArray:(NSArray *)routerParamArray
{
    if (originParams == nil) {
        originParams = [NSDictionary dictionary];
    }
    NSMutableDictionary *newParams = [[NSMutableDictionary alloc] initWithDictionary:originParams];
    for (CHRABRouterModelParam *param in routerParamArray) {
        NSString *value = param.value;
        NSString *key = param.key;
        if (key && value) {
            id newValue = [self paramValueFromKey:key value:value andOriginParams:originParams];
            if (newValue) {
                [newParams setObject:newValue forKey:key];
            }
        }
    }
    return newParams;
}

- (id)paramValueFromKey:(NSString *)key value:(NSString *)value andOriginParams:(NSDictionary *)originParams;
{
    id result = nil;
    id newValue = [value copy];
    // 正则匹配字符串{xx.x}
    NSString *regex = @"\\{[\\w.]+\\}";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regular matchesInString:value options:0 range:NSMakeRange(0, [value length])];
    for (NSTextCheckingResult *match in matches) {
        NSRange range = [match range];
        NSString *toBeReplacedKey = [value substringWithRange:range];
        // 取出花括号中的参数名
        NSString *originKey = [toBeReplacedKey substringWithRange:NSMakeRange(1, range.length - 2)];
        id transferedValue = [self paramValueFromOriginParams:originParams andOriginKey:originKey];
        if (transferedValue) {
            if ([transferedValue isKindOfClass:[NSString class]]) { // 转换后，如果参数值是字符串，则直接替换原来参数
                newValue = [newValue stringByReplacingOccurrencesOfString:toBeReplacedKey withString:transferedValue];
            } else {
                if (NSEqualRanges(range, NSMakeRange(0, [value length]))) { // 如果是对象并且range一致，则用对象作为参数
                    newValue = transferedValue;
                } else {
                    newValue = nil;
                }
                break;
            }
        } else {
            newValue = nil;
            break;
        }
    }
    if (newValue) {
        result = newValue;
    }
    return result;
}


// 根据原来的参数集合，和router要取的参数名，获取参数值
- (id)paramValueFromOriginParams:(NSDictionary *)originParams andOriginKey:(NSString *)originKey
{
    id result = nil;
    // 将目标key按照.来拆分，用来多次取得参数值
    NSArray *targetValues = [originKey componentsSeparatedByString:@"."];
    if (targetValues.count > 0) {
        // 取第一个参数值
        result = [originParams objectForKey:targetValues[0]];
        // 取第一次之后的参数值
        for (int i = 1; i < targetValues.count; i++) {
            NSString *v = targetValues[i];

            if ([result isKindOfClass:[NSDictionary class]]) { // 从字典取值
                result = [result objectForKey:v];
                if (result == nil) {
                    break;
                }
            } else if (result) { // 从对象取属性
                SEL selector = NSSelectorFromString(v);
                if ([result respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    result = [result performSelector:selector];
#pragma clang diagnostic pop
                } else {
                    break;
                }
                if (result == nil) {
                    break;
                }
            }
        }
    }
    return result;
}



@end
