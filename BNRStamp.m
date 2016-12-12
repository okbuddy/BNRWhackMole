//
//  BNRStamp.m
//  BNRWhackMole
//
//  Created by zhk on 16/6/25.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRStamp.h"
#import "BNRMole.h"


@implementation BNRStamp

-(instancetype)init
{
    self=[super init];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    UIBezierPath* path0=[UIBezierPath bezierPathWithOvalInRect:self.bounds];
    UIColor* color=[UIColor colorWithRed:0/255.0 green:210/255.0 blue:255/255.0 alpha:1];
    [color setFill];
    [path0 fill];
    [path0 addClip];
    //draw hole
    CGRect hole=self.bounds;
    hole.origin.y=5*hole.size.height/8;
    hole.size.height/=4;
    UIBezierPath* path1=[UIBezierPath bezierPathWithOvalInRect:hole];
    [[UIColor brownColor]setFill];
    [path1 fill];
    //draw mole
    float width=self.bounds.size.width;
    CGRect rect1=CGRectMake(0.15*width, 0.15*width, 0.7*width, 0.6*width);
    BNRMole* mole=[[BNRMole alloc]initWithFrame:rect1];
    [self addSubview:mole];
    
}

@end
