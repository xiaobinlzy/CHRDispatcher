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
    [vc dispatcher_setValuesForKeys:params]; \
    [dispatcher pushViewController:vc]; \
    return vc; \
})

#endif /* CHRDispatcherMacro_h */
