//
//  CHRDispatcher.h
//  Common
//
//  Created by DLL on 16/5/24.
//  Copyright © 2016年 DLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHRABRouter.h"

@class CHRDispatcher;
@protocol CHRDispatchable <NSObject>

@required
+ (void)dispatcher:(CHRDispatcher *)dispatcher
    invokeWithPath:(NSString *)path
            params:(NSDictionary *)params
       andCallback:(void (^)(NSDictionary *result))callback;

@end

@interface CHRDispatcher : NSObject

+ (instancetype)sharedDispatcher;

@property (strong, nonatomic, readonly) UIViewController *topViewController;

/**
 *  获取栈顶导航控制器
 *
 *  @return 导航控制器
 */
- (UINavigationController *)navigationController;

/**
 *  通过path和参数直接调用
 *
 *  @param path   path
 *  @param params 调用参数
 */
- (void)invokeForPath:(NSString *)path andParams:(NSDictionary *)params;

/**
 *  通过path、参数调用，并且设置回调target和action
 *
 *  @param path   path
 *  @param params 调用参数
 *  @param target 回调对象
 *  @param action 回调SEL
 */
- (void)invokeForPath:(NSString *)path
               params:(NSDictionary *)params
          andCallback:(void (^)(NSDictionary *result))callback;

/**
 *  注册跳转页面
 *
 *  @param clazz 跳转页面class对象
 *  @param path  对应Url path
 */
- (void)registHandleClass:(Class<CHRDispatchable>)clazz
                  forPath:(NSString *)path;
/**
 *  注销跳转页面
 *
 *  @param path 对应url path 注意：path不区分大小写
 */
- (void)unregistHandleClassForPath:(NSString *)path;

/**
 *  当前ViewController栈是否可以pushViewController
 */
@property(readonly) BOOL canPushViewController;

/**
 *  尝试从navigationController push viewController
 *
 *  @param viewController 要进栈的ViewController
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 *  尝试从navigationController push viewController。如果不是要在登录等模态视图的navigationController中push，isInModal不要传YES。
 *
 *  @param viewController 要push的viewController
 *  @param isInModal      是否在模态视图中push。如果否，则会在keyWindow.rootViewController中进行push
 */
- (void)pushViewController:(UIViewController *)viewController inTopModal:(BOOL)isInModal;

/**
 *  显示模态ViewController
 *
 *  @param viewController 要显示的viewController
 */
- (void)showModalViewController:(UIViewController *)viewController;

/**
 *  获取当前的UINavigationController
 *
 *  @param isInModal 如果为NO，则返回根视图的UINavigationController。如果为YES，则会取最顶部模态UINavigationController
 *
 *  @return 当前的UINavigationController
 */
- (UINavigationController *)navigationControllerInTopModal:(BOOL)isInModal;




@property (strong, nonatomic)CHRABRouter *router;

@end
