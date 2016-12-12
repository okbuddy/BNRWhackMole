//
//  BNRScoreViewController.h
//  BNRWhackMole
//
//  Created by zhk on 16/6/23.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRScoreViewController : UIViewController

@property (nonatomic)BOOL isNewRecord;
@property (nonatomic)int time;
@property (nonatomic)int number;
@property (nonatomic,copy)void (^m)(void);

@end
