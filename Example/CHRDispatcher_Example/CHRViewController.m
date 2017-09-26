//
//  CHRViewController.m
//  CHRDispatcher_Example
//
//  Created by DLL on 2017/9/26.
//  Copyright © 2017年 xiaobinlzy. All rights reserved.
//

#import "CHRViewController.h"
#import <CHRDispatcher/CHRDispatcher.h>

@interface CHRViewController ()

@end

@implementation CHRViewController

dispatcher_regist_push(@"path", @"path1", @"path3", @"path4")

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}


@end
