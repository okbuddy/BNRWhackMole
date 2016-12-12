//
//  BNRMole.h
//  ColorBoard
//
//  Created by zhk on 16/6/15.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NORMAL 0
#define CRY    1
#define SMILE  2

@interface BNRMole : UIControl
@property(nonatomic) int expression;
@property(nonatomic) float initialOriginY;

@end
