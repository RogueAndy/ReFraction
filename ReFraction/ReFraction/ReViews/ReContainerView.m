//
//  ReContainerView.m
//  ReFraction
//
//  Created by Rogue Andy on 16/9/20.
//  Copyright © 2016年 RogueAndy. All rights reserved.
//

#import "ReContainerView.h"
#import "ReBlockView.h"

@interface ReContainerView()

@property (nonatomic) CGRect screenFrame;

@property (nonatomic) CGPoint originalPoint;



@property (nonatomic) CGFloat topCoordinate;

@property (nonatomic) CGFloat leftCoordinate;

@property (nonatomic) CGFloat rightCoordinate;

@property (nonatomic) CGFloat bottomCoordinate;



@property (nonatomic) CGFloat velocityX;

@property (nonatomic) CGFloat velocityY;



@property (nonatomic) CGFloat coordinateX;

@property (nonatomic) CGFloat coordinateY;



@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) ReBlockView *block;

@end

@implementation ReContainerView

+ (instancetype)initWithFrame:(CGRect)frame point:(CGPoint)point {

    ReContainerView *view = [[ReContainerView alloc] initWithFrame:frame];
    view.screenFrame = frame;
    view.originalPoint = point;
    [view setCoordinate:view.screenFrame];
    return view;

}

- (void)setOriginalPoint:(CGPoint)originalPoint {

    _originalPoint = originalPoint;
    
    self.coordinateX = self.originalPoint.x;
    self.coordinateY = self.originalPoint.y;

    self.block.center = self.originalPoint;
    
}

- (instancetype)initWithFrame:(CGRect)frame {

    if(self = [super initWithFrame:frame]) {
    
        [self loadInitData];
        [self loadSubview];
        [self loadLayout];
    
    }
    
    return self;

}

- (void)loadInitData {
    
    self.velocityX = [self setRandomVelocity];
    self.velocityY = [self setRandomVelocity];

}

- (void)loadSubview {

    self.block = [[ReBlockView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.block.layer.masksToBounds = YES;
    self.block.backgroundColor = [UIColor orangeColor];
    self.block.layer.cornerRadius = 15;
    [self addSubview:self.block];

}

- (void)loadLayout {

    

}

#pragma mark - 设置边框值

- (void)setCoordinate:(CGRect)screenFrame {

    self.leftCoordinate = 0.0;
    self.topCoordinate = 0.0;
    self.rightCoordinate = CGRectGetWidth(screenFrame);
    self.bottomCoordinate = CGRectGetHeight(screenFrame);

}

#pragma mark - 随机生成初始速度 ( -5 <= v <= 5 & v != 0)

- (CGFloat)setRandomVelocity {

    CGFloat randomSign = arc4random() % 2;
    CGFloat random = (arc4random() % 5 + 1) / 10.0;;
    return randomSign == 0 ? random : 0 - random;
    
}

#pragma mark - 外部调用

- (void)start {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(runloopBlock:) userInfo:nil repeats:YES];

}

- (void)runloopBlock:(NSTimer *)timer {
    
    [self run];
    
}

/* 对于一个不旋转的物体，需要知道它的  上下左右  的极点 **/

- (void)run {

    NSLog(@"~~~~~~~~~~ %f   %f", self.velocityX, self.velocityY);
    
    if(self.coordinateX - CGRectGetWidth(self.block.frame) / 2.0 < 0) {
    
        self.velocityX = 0 - self.velocityX;
        NSLog(@"~~~~~碰到了左边");
    
    }
    
    if(self.coordinateX + CGRectGetWidth(self.block.frame) / 2.0 > self.rightCoordinate) {
        
        self.velocityX = 0 - self.velocityX;
        NSLog(@"~~~~~碰到了右边");
        
    }
    
    if(self.coordinateY - CGRectGetWidth(self.block.frame) / 2.0 < 0) {
        
        self.velocityY = 0 - self.velocityY;
        NSLog(@"~~~~~碰到了上边");
        
    }
    
    if(self.coordinateY + CGRectGetWidth(self.block.frame) / 2.0 > self.bottomCoordinate) {
        
        self.velocityY = 0 - self.velocityY;
        NSLog(@"~~~~~碰到了下边");
        
    }
    
    self.coordinateX = self.coordinateX + self.velocityX;
    self.coordinateY = self.coordinateY + self.velocityY;

    self.block.center = CGPointMake(self.coordinateX, self.coordinateY);
    
}

@end
