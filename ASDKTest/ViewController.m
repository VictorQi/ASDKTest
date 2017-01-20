//
//  ViewController.m
//  ASDKTest
//
//  Created by v.q on 2017/1/11.
//  Copyright © 2017年 Victor Qi. All rights reserved.
//

#import "ViewController.h"
#import "mainView.h"
#import "Utilities.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = @"Main";
        self.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    mainView *mView = [[mainView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mView];
}

@end
