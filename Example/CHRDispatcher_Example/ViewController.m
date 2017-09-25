//
//  ViewController.m
//  CHRDispatcher_Example
//
//  Created by DLL on 2017/9/26.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "ViewController.h"
#import <CHRDispatcher/CHRDispatcher.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)clickButton:(id)sender {
    [[CHRDispatcher sharedDispatcher] invokeForPath:@"path" andParams:@{@"stringProp": @"str", @"intProp": @"3.45", @"floatProp": @"1.23", @"boolProp": @"true", @"undefined": [NSNull null]}];
}


@end
