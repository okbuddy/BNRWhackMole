//
//  BNRMole.m
//  ColorBoard
//
//  Created by zhk on 16/6/15.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRMole.h"

@implementation BNRMole

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.expression=NORMAL;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    float f1=self.bounds.size.width;
    float f2=self.bounds.size.height;
    UIBezierPath* path=[[UIBezierPath alloc]init];
    CGPoint center=CGPointMake(f1/2, f1/2);
    CGFloat radius=f1/2;
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI clockwise:NO];
    [path addLineToPoint:CGPointMake(0, f2)];
    [path addLineToPoint:CGPointMake(f1, f2)];
    [path closePath];
    [[UIColor orangeColor] setFill];
    [path fill];
    
    UIBezierPath* path1=[[UIBezierPath alloc]init];
    //5
    path1.lineWidth=f1/33;
    path1.lineCapStyle=kCGLineCapRound;
    switch (self.expression) {
        case NORMAL:
            //add eyes
            [path1 moveToPoint:CGPointMake(f1/3, 9*f1/30)];
            [path1 addLineToPoint:CGPointMake(f1/3, 15*f1/30)];
            
            [path1 moveToPoint:CGPointMake(2*f1/3, 9*f1/30)];
            [path1 addLineToPoint:CGPointMake(2*f1/3, 15*f1/30)];

            break;
        case CRY:
            //add cry eyes
            [path1 moveToPoint:CGPointMake(11*f1/30, 9*f1/30)];
            [path1 addLineToPoint:CGPointMake(8*f1/30, 15*f1/30)];
            
            [path1 moveToPoint:CGPointMake(19*f1/30, 9*f1/30)];
            [path1 addLineToPoint:CGPointMake(22*f1/30, 15*f1/30)];
            break;
        case SMILE:
            //add smile eyes
            [path1 moveToPoint:CGPointMake(12*f1/30, 14*f1/30)];
            [path1 addArcWithCenter:CGPointMake(9*f1/30, 14*f1/30) radius:3*f1/30 startAngle:0 endAngle:M_PI clockwise:NO];
            [path1 moveToPoint:CGPointMake(24*f1/30, 14*f1/30)];
            [path1 addArcWithCenter:CGPointMake(21*f1/30, 14*f1/30) radius:3*f1/30 startAngle:0 endAngle:M_PI clockwise:NO];
            break;
            
        default:
            break;
    }
    
    //draw eyes
    [[UIColor blackColor] setStroke];
    [path1 stroke];
    //add nose
    UIBezierPath* path2=[[UIBezierPath alloc]init];
    //10
    path2.lineWidth=f1/15;
    path2.lineCapStyle=kCGLineCapRound;
    [path2 moveToPoint:CGPointMake(13*f1/30, 2*f1/3)];
    [path2 addLineToPoint:CGPointMake(17*f1/30, 2*f1/3)];
    
    [[UIColor redColor] setStroke];
    [path2 stroke];
    
    
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touch began");
//}
@end
