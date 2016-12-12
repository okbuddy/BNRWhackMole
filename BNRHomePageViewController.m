//
//  BNRHomePageViewController.m
//  BNRWhackMole
//
//  Created by zhk on 16/6/22.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRHomePageViewController.h"
#import "BNRWhackMoleViewController.h"
#import "BNRStamp.h"
#import "BNRScoreViewController.h"


#define y (ff/12*sinf(0.01*x)+3*ff/12)
#define y1 (1.2*ff/9*sinf(0.024*x)+4*ff/9)

@interface BNRHomePageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image0;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UILabel *record0;
@property (weak, nonatomic) IBOutlet UILabel *record1;
@property (weak, nonatomic) IBOutlet UILabel *record2;
@property (weak, nonatomic) IBOutlet UIButton *begin;

@property(nonatomic)int currentTime;

@property(nonatomic)UILabel* currentRecord;
@property(nonatomic)UIImageView* currentImage;


@end

@implementation BNRHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.image0.alpha=0;
    self.image1.alpha=0;
    self.image2.alpha=0;
    NSArray* arr0=[NSArray arrayWithObjects:self.image0,self.image1,self.image2, nil];
    NSArray* arr1=[NSArray arrayWithObjects:@10,@30,@60, nil];
    NSArray* arr2=[NSArray arrayWithObjects:self.record0,self.record1,self.record2, nil];
    NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
    NSInteger index=[def integerForKey:@"index"];
    
    

    self.currentImage=arr0[index];
    self.currentImage.alpha=1;
    self.currentTime=[arr1[index] intValue];
    self.currentRecord=arr2[index];
    
    //get the record from the file
    self.record0.text=[NSString stringWithContentsOfFile:[self pathForTimeDuration:10] encoding:NSUTF8StringEncoding error:nil];
    if (!self.record0.text) {
        self.record0.text=@"Record: 0";
    }
    
    self.record1.text=[NSString stringWithContentsOfFile:[self pathForTimeDuration:30] encoding:NSUTF8StringEncoding error:nil];
    if (!self.record1.text) {
        self.record1.text=@"Record: 0";
    }
    
    self.record2.text=[NSString stringWithContentsOfFile:[self pathForTimeDuration:60] encoding:NSUTF8StringEncoding error:nil];
    if (!self.record2.text) {
        self.record2.text=@"Record: 0";
    }
    self.navigationItem.title=@"Whack A Mole";

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addSin];
}
-(void)viewDidAppear:(BOOL)animated
{
    self.image0.image=[UIImage imageNamed:@"arraw"];
    self.image1.image=[UIImage imageNamed:@"arraw"];
    self.image2.image=[UIImage imageNamed:@"arraw"];
    self.image0.contentMode=UIViewContentModeScaleAspectFit;
    self.image1.contentMode=UIViewContentModeScaleAspectFit;
    self.image2.contentMode=UIViewContentModeScaleAspectFit;


}
-(void)viewDidDisappear:(BOOL)animated
{
    for (UIView* view in self.view.subviews) {
        if ([view isKindOfClass:[BNRStamp class]]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - action
- (IBAction)select10:(id)sender {
    if (self.currentTime==10) {
        return;
    }
    self.currentTime=10;
    self.currentRecord=self.record0;
    self.currentImage.alpha=0;
    self.image0.alpha=1;
    self.currentImage=self.image0;
}
- (IBAction)select30:(id)sender {
    if (self.currentTime==30) {
        return;
    }
    self.currentTime=30;
    self.currentRecord=self.record1;
    self.currentImage.alpha=0;
    self.image1.alpha=1;
    self.currentImage=self.image1;
}
- (IBAction)select60:(id)sender {
    if (self.currentTime==60) {
        return;
    }
    self.currentTime=60;
    self.currentRecord=self.record2;
    self.currentImage.alpha=0;
    self.image2.alpha=1;
    self.currentImage=self.image2;
}
- (IBAction)gameStart:(id)sender {
  //change the default
    int a;
    BNRWhackMoleViewController* whack=[[BNRWhackMoleViewController alloc]init];

    switch (self.currentTime) {
        case 10:
            a=0;
            whack.interval=0.01;
            break;
        case 30:
            a=1;
            whack.interval=0.05;
            break;
        case 60:
            a=2;
            whack.interval=0.25;
            break;
            
        default:
            break;
    }
    NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
    [def setObject:[NSNumber numberWithInt:a] forKey:@"index"];
    //show the game
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        whack.interval*=2;
    }
    whack.time=self.currentTime;
    whack.record=self.currentRecord;
    [self.navigationController pushViewController:whack animated:YES];
//    BNRScoreViewController* ss=[[BNRScoreViewController alloc]init];
//    ss.isNewRecord=YES;
//    [self.navigationController presentViewController:ss animated:YES completion:nil];
}
-(NSString*)pathForTimeDuration:(int)time
{
    NSArray* doc=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [doc[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d",time]];
}


-(void)addSin
{
    float ff=[[UIScreen mainScreen] bounds].size.width;
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
        for (float interval=0; interval<(0.8*4); interval+=0.8) {
            BNRStamp* stamp=[[BNRStamp alloc]init];
            float x=-ff/6;
            
            stamp.frame=CGRectMake(x, y, ff/6, ff/6);
            
            [UIView animateKeyframesWithDuration:8 delay:interval options:UIViewKeyframeAnimationOptionRepeat animations:^{
                float rtime=0;
                float x=0;
                for (x=-ff/12 ; x<=13.5*ff/12; x+=ff/100) {
                    float time=rtime;
                    rtime+=0.98/(0.5*y+30);
                    
                    [UIView addKeyframeWithRelativeStartTime:time relativeDuration:rtime animations:^{
                        stamp.center=CGPointMake(x, y);
                        stamp.alpha-=0.006;
                    }];
                }
                
            } completion:nil];
            
            [self.view addSubview:stamp];
        }
    } else {
        for (float interval=0; interval<(0.8*4); interval+=0.8) {
            BNRStamp* stamp=[[BNRStamp alloc]init];
            float x=-ff/6;
            
            stamp.frame=CGRectMake(x, y1, ff/6, ff/6);
            
            
            [UIView animateKeyframesWithDuration:6 delay:interval options:UIViewKeyframeAnimationOptionRepeat animations:^{
                float rtime=0;
                float x=0;
                for (x=-ff/12 ; x<=13.5*ff/12; x+=ff/100) {
                    float time=rtime;
                    
                    rtime+=0.845/(0.5*y1+30);
                    
                    [UIView addKeyframeWithRelativeStartTime:time relativeDuration:rtime animations:^{
                        stamp.center=CGPointMake(x, y1);
                        stamp.alpha-=0.006;
                    }];
                }
            } completion:nil];
            
            [self.view addSubview:stamp];
        }
    }
//#define y1 (ff/9*sinf(0.024*x)+3*ff/9)

   
}

@end
