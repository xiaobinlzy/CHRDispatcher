//
//  CHRDispatcherMacro.h
//  Pods
//
//  Created by DLL on 2017/9/25.
//

#import <Foundation/Foundation.h>
#ifndef CHRDispatcherMacro_h
#define CHRDispatcherMacro_h

#define DISPATCHER_REGIST(__path__, __block__) \
+ (void)load { \
    [[CHRDispatcher sharedDispatcher] registHandleClass:(Class<CHRDispatchable>)self forPath:__path__]; \
} \
+ (id)dispatcher:(CHRDispatcher *)dispatcher invokeWithPath:(NSString *)path params:(NSDictionary *)params andCallback:(void (^)(NSDictionary *result))callback { \
    return __block__(); \
}

#define DISPATCHER_REGIST_PUSH(__path__) \
DISPATCHER_REGIST(__path__, ^id() { \
    id vc = [[self alloc] init]; \
    if ([params isKindOfClass:NSDictionary.class]) { \
        for (NSString *key in params) { \
            id value = params[key]; \
            objc_property_t property = class_getProperty(self, [key cStringUsingEncoding:NSUTF8StringEncoding]); \
            if (property) { \
                if ([value isKindOfClass:NSString.class]) { \
                    char *type = property_copyAttributeValue(property, "T"); \
                    switch (type[0]) { \
                        case 'f': \
                        case 'd': \
                        case 'c': \
                        case 's': \
                        case 'i': \
                        case 'l': \
                        case 'q': \
                        case 'I': \
                        case 'S': \
                        case 'L': \
                        case 'Q': \
                        case 'B': \
                        { \
                            NSScanner *scanner = [[NSScanner alloc] initWithString:value]; \
                            double number; \
                            [scanner scanDouble:&number]; \
                            value = [NSNumber numberWithDouble:number]; \
                        } \
                            break; \
                    } \
                    if (type) { \
                        free(type); \
                    } \
                } \
                [self setValue:value forKey:key]; \
            } \
        } \
    } \
    [dispatcher pushViewController:vc]; \
    return vc; \
})

#endif /* CHRDispatcherMacro_h */
