//
//  BNRScoreViewController.m
//  BNRWhackMole
//
//  Created by zhk on 16/6/23.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRScoreViewController.h"
#import "BNRWhackMole-Swift.h"
#import "BNRStamp.h"

@interface BNRScoreViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet BNRStamp *stamp;
@property (weak, nonatomic) IBOutlet UIImageView *star;

@end

@implementation BNRScoreViewController


-(instancetype)init
{
    self=[super init];
    
    if (self) {
        self.modalPresentationStyle=UIModalPresentationCustom;
        self.transitioningDelegate=self;
        self.view.layer.cornerRadius=36;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.isNewRecord) {
        self.star.image=[UIImage imageNamed:@"star"];
        self.stamp.alpha=0;
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    if (self.isNewRecord) {
        if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
            self.label.font=[UIFont fontWithName:@"Chalkboard SE" size:42];
        } else {
            self.label.font=[UIFont fontWithName:@"Chalkboard SE" size:20];

        }
        self.label.textColor=[UIColor yellowColor];
        self.label.text=[NSString stringWithFormat:@"%ds: NEW RECORD: %d",self.time, self.number];
    } else {
        self.label.text=[NSString stringWithFormat:@"%ds: Whacked Moles: %d",self.time, self.number];
        
    }
}
#pragma mark - UIViewControllerTransitioningDelegate

-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    Custom* custom=[[Custom alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    return custom;
}


-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    CustomAnimation* ani=[[CustomAnimation alloc]initWithIsPresenting:true];
    return ani;
    
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CustomAnimation* ani=[[CustomAnimation alloc]initWithIsPresenting:false];
    return ani;
}


#pragma mark - action
- (IBAction)takePicture:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    UIButton* bb=sender;
    [bb setTitle:@"Picture Saved" forState:UIControlStateNormal];
    bb.enabled=NO;
}
- (IBAction)OneMoreAgain:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.m) {
        self.m();
    }
}

- (IBAction)backToHome:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    UINavigationController* nav=(UINavigationController*)self.presentingViewController;
    [nav popViewControllerAnimated:NO];
}




@end
