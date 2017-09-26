//
//  CHRDispatcherMacro.h
//  Pods
//
//  Created by DLL on 2017/9/25.
//

#import <Foundation/Foundation.h>
#ifndef CHRDispatcherMacro_h
#define CHRDispatcherMacro_h

#define dispatcher_regist(__block__, ...) \
dispatcher_metamacro_regist_paths(__VA_ARGS__) \
+ (id)dispatcher:(CHRDispatcher *)dispatcher invokeWithPath:(NSString *)path params:(NSDictionary *)params andCallback:(void (^)(NSDictionary *result))callback { \
    return __block__(); \
}

#define dispatcher_regist_push(...) \
dispatcher_regist(^id(void) { \
    __strong typeof(self) vc = [[self alloc] init]; \
    [vc dispatcher_setValuesForKeys:params]; \
    [dispatcher pushViewController:(UIViewController *)vc]; \
    return vc; \
}, __VA_ARGS__)









#define dispatcher_metamacro_regist_paths(...) \
+ (void)load { \
    dispatcher_metamacro_regist_paths_(__VA_ARGS__) \
}

#define dispatcher_metamacro_regist_paths_(...) dispatcher_metamacro_concat(dispatcher_metamacro_regist_path_, dispatcher_metamacro_argscount(__VA_ARGS__))(__VA_ARGS__)


#define dispatcher_metamacro_regist_path_(PATH) [[CHRDispatcher sharedDispatcher] registHandleClass:self forPath:PATH];

#define dispatcher_metamacro_regist_path_1(PATH, ...) dispatcher_metamacro_regist_path_(PATH)
#define dispatcher_metamacro_regist_path_2(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_1(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_3(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_2(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_4(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_3(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_5(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_4(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_6(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_5(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_7(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_6(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_8(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_7(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_9(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_8(__VA_ARGS__)
#define dispatcher_metamacro_regist_path_10(PATH, ...) dispatcher_metamacro_regist_path_(PATH) dispatcher_metamacro_regist_path_9(__VA_ARGS__)



#define dispatcher_metamacro_if_is_1_1(...) __VA_ARGS__ dispatcher_metamacro_consume_
#define dispatcher_metamacro_if_is_1_0(...) dispatcher_metamacro_expand_

#define dispatcher_metamacro_if_is_1(VALUE) dispatcher_metamacro_concat(dispatcher_metamacro_if_is_1_, dispatcher_metamacro_is_1(VALUE))

#define dispatcher_metamacro_is_1(VALUE) dispatcher_metamacro_at(VALUE, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)


#define dispatcher_metamacro_argscount(...) dispatcher_metamacro_at(20, __VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

#define dispatcher_metamacro_at(N, ...) dispatcher_metamacro_concat(dispatcher_metamacro_at, N)(__VA_ARGS__)

// metamacro_at expansions
#define dispatcher_metamacro_at0(...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at1(_0, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at2(_0, _1, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at3(_0, _1, _2, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at4(_0, _1, _2, _3, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at5(_0, _1, _2, _3, _4, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at6(_0, _1, _2, _3, _4, _5, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at7(_0, _1, _2, _3, _4, _5, _6, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at8(_0, _1, _2, _3, _4, _5, _6, _7, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at9(_0, _1, _2, _3, _4, _5, _6, _7, _8, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at10(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at11(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at12(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at13(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at14(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at15(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at16(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at17(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at18(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at19(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, ...) dispatcher_metamacro_head(__VA_ARGS__)
#define dispatcher_metamacro_at20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...) dispatcher_metamacro_head(__VA_ARGS__)


#define dispatcher_metamacro_concat_(A, B) A ## B
#define dispatcher_metamacro_concat(A, B) dispatcher_metamacro_concat_(A, B)

#define dispatcher_metamacro_head_(FIRST, ...) FIRST
#define dispatcher_metamacro_head(...) dispatcher_metamacro_head_(__VA_ARGS__, 0)

#define dispatcher_metamacro_expand_(...) __VA_ARGS__
#define dispatcher_metamacro_consume_(...)

#endif /* CHRDispatcherMacro_h */
