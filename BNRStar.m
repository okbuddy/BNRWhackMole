//
//  BNRStar.m
//  BNRWhackMole
//
//  Created by zhk on 16/6/25.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRStar.h"

@implementation BNRStar



- (void)drawRect:(CGRect)rect {

    CGPoint center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius=self.bounds.size.width/2;
    float interval=-2*M_PI/5;
    float startPoint=3*M_PI/2;
    
    UIBezierPath* path0=[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:startPoint clockwise:NO];
    CGPoint point0=path0.currentPoint;
    [path0 addArcWithCenter:center radius:radius startAngle:startPoint endAngle:startPoint+interval clockwise:NO];
    CGPoint point1=path0.currentPoint;
    
    [path0 addArcWithCenter:center radius:radius startAngle:startPoint+interval endAngle:startPoint+2*interval clockwise:NO];
    CGPoint point2=path0.currentPoint;
    
    [path0 addArcWithCenter:center radius:radius startAngle:startPoint+2*interval endAngle:startPoint+3*interval clockwise:NO];
    CGPoint point3=path0.currentPoint;
    
    [path0 addArcWithCenter:center radius:radius startAngle:startPoint+3*interval endAngle:startPoint+4*interval clockwise:NO];
    CGPoint point4=path0.currentPoint;
    [path0 closePath];
    [path0 addClip];
    [[UIColor blueColor]setFill];
    [path0 fill];
    
    //draw the star
    UIBezierPath* path1=[UIBezierPath bezierPath];
    [path1 moveToPoint:point0];
    [path1 addLineToPoint:point2];
    [path1 addLineToPoint:point4];
    [path1 addLineToPoint:point1];
    [path1 addLineToPoint:point3];
    [path1 addLineToPoint:point0];
    [path1 addClip];
    //set gradient
    CGFloat location[3]={0,0.5,1};
    CGFloat component[12]={ 0.5, 0.5, 0.0, 1.0,
                            1.0, 1.0, 0.0, 1.0,
                            0.5, 0.5, 0.0, 1.0
    };
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient=CGGradientCreateWithColorComponents(space, component, location, 3);
    CGPoint start=CGPointMake(0, 0);
    CGContextRef currentcontext=UIGraphicsGetCurrentContext();
    CGPoint end=CGPointMake(self.bounds.size.width, self.bounds.size.height);
    CGContextDrawLinearGradient(currentcontext, gradient, start, end, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    //add edges and corners
    UIBezierPath* path2=[UIBezierPath bezierPath];
    [path2 moveToPoint:center];
    [path2 moveToPoint:point0];
    
    
    
}


@end
