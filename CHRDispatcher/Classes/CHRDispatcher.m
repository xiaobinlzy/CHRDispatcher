//
//  CHRDispatcher.m
//  Common
//
//  Created by DLL on 16/5/24.
//  Copyright © 2016年 DLL. All rights reserved.
//

#import "CHRDispatcher.h"


@implementation CHRDispatcher {
    NSMutableDictionary *_handlerMap;
    
}

+ (instancetype)sharedDispatcher {
    static dispatch_once_t onceToken;
    static CHRDispatcher *__dispatcher;
    dispatch_once(&onceToken, ^{
        __dispatcher = [[CHRDispatcher alloc] init];
    });
    return __dispatcher;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _handlerMap = [[NSMutableDictionary alloc] init];
        _router = [[CHRABRouter alloc]init];
    }
    return self;
}

- (void)invokeForPath:(NSString *)path andParams:(NSDictionary *)params {
    [self invokeForPath:path params:params andCallback:nil];
}

- (id)invokeForPath:(NSString *)path params:(NSDictionary *)params andCallback:(void (^)(NSDictionary *result))callback {
    if ( [path isEqualToString:@"goBack"] ) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NewPathAndParam *newPathAndParam =  [_router transferForPath:path params:params andCallback:callback];
        if (newPathAndParam) {
            id<CHRDispatchable> clazz = [self handleClassForPath:newPathAndParam.path];
            if (clazz) {
                return [clazz dispatcher:self invokeWithPath:newPathAndParam.path params:newPathAndParam.params andCallback:callback];
            }
        }
        id<CHRDispatchable> clazz = [self handleClassForPath:path];
        if (clazz) {
            return [clazz dispatcher:self invokeWithPath:path params:params andCallback:callback];
        }
    }
    return nil;
}

- (void)registHandleClass:(Class<CHRDispatchable>)clazz
                  forPath:(NSString *)path {
    path = [path lowercaseString];
    [_handlerMap setObject:clazz forKey:path];
}
- (void)unregistHandleClassForPath:(NSString *)path {
    path = [path lowercaseString];
    [_handlerMap removeObjectForKey:path];
}
- (id<CHRDispatchable>)handleClassForPath:(NSString *)path {
    path = [path lowercaseString];
    return [_handlerMap objectForKey:path];
}

- (BOOL)canPushViewController {
    return [self navigationController] != nil;
}

- (UIViewController *)topViewController {
    return [self navigationControllerInTopModal:YES].childViewControllers.lastObject;
}

- (UINavigationController *)navigationController {
    UIViewController *rootViewController = [(id)[UIApplication sharedApplication].delegate window].rootViewController;
    if ([rootViewController isKindOfClass:UINavigationController.class]) {
        return (UINavigationController *)rootViewController;
    }
    if ([rootViewController isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabBarController =
        (UITabBarController *)rootViewController;
        if ([tabBarController.selectedViewController
             isKindOfClass:UINavigationController.class]) {
            return tabBarController.selectedViewController;
        }
    }
    return nil;
}

- (void)pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController inTopModal:NO];
}

- (void)showModalViewController:(UIViewController *)viewController {
    UIViewController *parentViewController =  [(id)[UIApplication sharedApplication].delegate window].rootViewController;
    while (parentViewController.presentedViewController) {
        parentViewController = parentViewController.presentedViewController;
    }
    [parentViewController presentViewController:viewController
                                       animated:YES
                                     completion:NULL];
}

- (void)pushViewController:(UIViewController *)viewController inTopModal:(BOOL)isInModal {
    UINavigationController *navigationController = [self navigationControllerInTopModal:isInModal];
    
    if (navigationController) {
        [navigationController pushViewController:viewController animated:YES];
    }
}

- (UINavigationController *)navigationControllerInTopModal:(BOOL)isInModal {
    UINavigationController *navigationController = nil;
    if (isInModal) {
        UIViewController *topViewController =  [(id)[UIApplication sharedApplication].delegate window].rootViewController.presentedViewController;
        while (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        }
        if ([topViewController isKindOfClass:UINavigationController.class]) {
            navigationController = (UINavigationController *)topViewController;
        }
    }
    if (navigationController == nil) {
        navigationController = [self navigationController];
    }
    return navigationController;
}

@end
