//
//  ReRunViewController.m
//  ReFraction
//
//  Created by Rogue Andy on 16/9/22.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "ReRunViewController.h"
#import "ReContainerView.h"

@interface ReRunViewController ()

@property (nonatomic, strong) ReContainerView *containerView;

@end

@implementation ReRunViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSubview];
    [self loadLayout];

}

- (void)loadSubview {

    self.containerView = [ReContainerView initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 300) point:CGPointMake(150, 150)];
    self.containerView.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1];
    [self.view addSubview:self.containerView];

}

- (void)loadLayout {

    [self.containerView start];

}

@end
