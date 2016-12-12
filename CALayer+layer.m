//
//  CALayer+layer.m
//  BNRWhackMole
//
//  Created by zhk on 16/6/26.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "CALayer+layer.h"


@implementation CALayer (layer)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
