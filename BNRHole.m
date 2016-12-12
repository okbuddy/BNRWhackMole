//
//  BNRHole.m
//  BNRWhackMole
//
//  Created by zhk on 16/6/16.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRHole.h"
#import "BNRMole.h"

@implementation BNRHole
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self=[super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor=[UIColor redColor];
//    }
//    CGRect ff=CGRectMake(0, 0, 250, 250);
//    BNRMole* mole=[[BNRMole alloc]initWithFrame:ff];
//    [self addSubview:mole];
//    return self;
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    UIBezierPath* path=[UIBezierPath bezierPathWithOvalInRect:self.bounds];

    [[UIColor brownColor] setFill];
    [path fill];

}


@end
