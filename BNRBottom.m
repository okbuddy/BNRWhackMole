//
//  BNRBottom.m
//  BNRWhackMole
//
//  Created by zhk on 16/6/25.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRBottom.h"

@implementation BNRBottom

-(void)drawRect:(CGRect)rect
{
    
    float width=self.bounds.size.width;
    UIBezierPath* path0=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0*width, -0.125/2*width, 0.3*width, 0.125*width)];
    UIBezierPath* path1=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.35*width, -0.125/2*width, 0.3*width, 0.125*width)];
    UIBezierPath* path2=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.7*width, -0.125/2*width, 0.3*width, 0.125*width)];
    [[UIColor brownColor]setFill];
    [path0 fill];
    [path1 fill];
    [path2 fill];

    
}

@end
