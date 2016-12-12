//
//  BNRWhackMoleViewController.m
//  ColorBoard
//
//  Created by zhk on 16/6/15.
//  Copyright © 2016年 zhk. All rights reserved.
//

#import "BNRWhackMoleViewController.h"
#import "BNRMole.h"
#import "BNRHole.h"
#import "BNRScoreViewController.h"
#import "BNRStamp.h"
#import "BNRHomePageViewController.h"


@interface BNRWhackMoleViewController ()<UINavigationControllerDelegate>
@property (nonatomic,copy)NSArray* moles;
@property(nonatomic)float y0;
@property(nonatomic)float height0;



@property (weak, nonatomic) IBOutlet UIImageView *screen;
@property (weak, nonatomic) IBOutlet UIButton *takeP;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet BNRMole *mole0;
@property (weak, nonatomic) IBOutlet BNRMole *mole1;
@property (weak, nonatomic) IBOutlet BNRMole *mole2;
@property (weak, nonatomic) IBOutlet BNRMole *mole3;
@property (weak, nonatomic) IBOutlet BNRMole *mole4;
@property (weak, nonatomic) IBOutlet BNRMole *mole5;
@property (weak, nonatomic) IBOutlet BNRMole *mole6;
@property (weak, nonatomic) IBOutlet BNRMole *mole7;
@property (weak, nonatomic) IBOutlet BNRMole *mole8;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *whackNumberLabel;
@property(nonatomic) NSTimer* timer;

@property(nonatomic)int whackNumber;
@property(nonatomic)int missNumber;
@property(nonatomic)BOOL isOverFlow;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint0;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint4;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint5;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint6;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint8;
@property (nonatomic,copy)NSArray* constraints;


@end

@implementation BNRWhackMoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.constraints=[NSArray arrayWithObjects:self.bottomConstraint0,self.bottomConstraint1,self.bottomConstraint2,
                      self.bottomConstraint3,self.bottomConstraint4,self.bottomConstraint5,
                      self.bottomConstraint6,self.bottomConstraint7,self.bottomConstraint8,nil];
    self.moles=[NSArray arrayWithObjects:self.mole0,self.mole1,self.mole2,
                                         self.mole3,self.mole4,self.mole5,
                                         self.mole6,self.mole7,self.mole8,nil];
    for (BNRMole* mole in self.moles) {
        mole.expression=NORMAL;
        mole.enabled=NO;
        [mole addTarget:self action:@selector(beWhacked:) forControlEvents:UIControlEventTouchDown];
    }
    //timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    self.timer.tolerance=0.5*self.interval;
    
    //navigationItem
    UIBarButtonItem* item0=[[UIBarButtonItem alloc]initWithTitle:@"Pause" style:UIBarButtonItemStylePlain target:self action:@selector(beginOrContinue:)];
    UIBarButtonItem* item1=[[UIBarButtonItem alloc]initWithTitle:@"More Moles Out" style:UIBarButtonItemStylePlain target:self action:@selector(comeOut:)];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:item0, item1, nil];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.whackNumber=0;
    self.missNumber=0;
    self.isOverFlow=NO;
    self.whackNumberLabel.text=[NSString stringWithFormat:@"%d",0];
    self.slider.value=0;
    self.slider.maximumValue=self.time;
    
    self.label.text=[NSString stringWithFormat:@"%d",self.time];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.height0=self.mole0.frame.size.height;
    self.y0=self.mole0.frame.origin.y;
    for (BNRMole* mole in self.moles) {
        mole.initialOriginY=mole.frame.origin.y;
        int a=0;

    }
    [self comeOut:self];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    for (BNRMole* mole in self.moles) {
        mole.enabled=NO;
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark - @selector action
-(void)beginOrContinue:(UIBarButtonItem*)item
{
    if ([item.title isEqualToString:@"Pause"]) {
        item.title=@"Continue";
        item.enabled=NO;
        self.navigationItem.rightBarButtonItems[1].enabled=NO;
        
        NSTimer* timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(beEnabled:) userInfo:nil repeats:NO];
        timer.tolerance=0.4;
    } else {
        item.title=@"Pause";
        self.navigationItem.rightBarButtonItems[1].enabled=YES;

        [self comeOut:self];
    }
}
-(void)beEnabled:(NSTimer*)timer
{
    [timer invalidate];
    self.navigationItem.rightBarButtonItems[0].enabled=YES;
    
}

-(void)timerTick:(NSTimer*)timer
{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Continue"]) {
        return;
    }
    //in case of overflow sometime
    if (self.isOverFlow) {
        self.missNumber=0;
        self.isOverFlow=NO;
        [self comeOut:self];
        
    }
    
    float n=self.slider.value;
    n+=self.interval;
    if (fabsf(n-roundf(n))<self.interval/2) {
        self.label.text=[NSString stringWithFormat:@"%d",self.time-(int)roundf(n)];
    }
    
    self.slider.value=n;
    
    
    if (fabsf(n-self.time)<self.interval/2) {
        //remove the timer
        [self.timer invalidate];
        //show the score
        BNRScoreViewController* score=[[BNRScoreViewController alloc]init];
        score.modalPresentationStyle=UIModalPresentationCustom;
        score.time=self.time;
        score.number=self.whackNumber;
        int record=[[self.record.text substringFromIndex:8] intValue];
        if (self.whackNumber>record) {
            score.isNewRecord=YES;
            self.record.text=[NSString stringWithFormat:@"Record: %d",self.whackNumber];
            //save the record
            NSError* err=nil;
            BOOL b=[self.record.text writeToFile:[self pathForTimeDuration:self.time] atomically:YES encoding:NSUTF8StringEncoding error:&err];
            if (!b) {
                [NSException raise:@"saving record failed" format:@"Reason:%@",err.localizedDescription];
            }
            
            
        } else {
            score.isNewRecord=NO;
        }
        
        score.m=^{
            //in case
            self.whackNumber=0;
            self.missNumber=0;
            self.isOverFlow=NO;
            //intialization
            
            self.whackNumberLabel.text=[NSString stringWithFormat:@"%d",0];
            self.slider.value=0;
            self.label.text=[NSString stringWithFormat:@"%d",0];
            [self comeOut:self];
            //set the timer
            self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
            self.timer.tolerance=0.2*self.interval;
            
        };
        
        [self presentViewController:score animated:YES completion:nil];
    }
}

#pragma mark - save

-(NSString*)pathForTimeDuration:(int)time
{
    NSArray* doc=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [doc[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d",time]];
}
#pragma mark - animation

-(IBAction)comeOut:(id)sender
{
    //stop
    if (fabsf(self.slider.value-self.time)<self.interval/2) {
        return;
    }
    //pause
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Continue"]) {
        return;
    }
    //is mole sender
    int index=arc4random()%9;
    BNRMole* mole=self.moles[index];
    NSLayoutConstraint* constraint=self.constraints[index];
    if ([sender isKindOfClass:[BNRMole class]]) {
        while (mole.enabled||mole==sender) {
            index=arc4random()%9;
            mole=self.moles[index];
            constraint=self.constraints[index];
        }
    }
    mole.enabled=YES;
    float intercept=0.9*mole.frame.size.width;
    
    mole.expression=NORMAL;
    //0.8
    [UIView animateWithDuration:0.9 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        constraint.constant=-intercept;
        CGRect next=mole.frame;
        next.origin.y=mole.initialOriginY-intercept;
        mole.frame=next;
    
    } completion:^(BOOL B){
        if (mole.enabled) {
            mole.enabled=NO;
            [self comeOut:mole];
            
            [UIView animateWithDuration:0.07 animations:^{
                mole.expression=SMILE;
                constraint.constant=-1.1*intercept;
                CGRect next=mole.frame;
                next.origin.y=mole.initialOriginY-1.1*intercept;
                mole.frame=next;
                
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 delay:0 options:0 animations:^{
                    constraint.constant=0;
                    CGRect next=mole.frame;
                    next.origin.y=mole.initialOriginY;
                    mole.frame=next;
                    
                } completion:nil];
            }];
            
        }
    }];
        
    
    
    
}

-(IBAction)beWhacked:(id)sender
{

    ++self.whackNumber;
    self.whackNumberLabel.text=[NSString stringWithFormat:@"%d",self.whackNumber];
    
    BNRMole* mole=sender;
    mole.enabled=NO;
    NSUInteger index=[self.moles indexOfObjectIdenticalTo:mole];
    NSLayoutConstraint* constraint=self.constraints[index];
    //add the hammer
    UIImageView* hammer=[[UIImageView alloc]init];
    hammer.backgroundColor=[UIColor clearColor];
    hammer.image=[UIImage imageNamed:@"hammer"];
    hammer.contentMode=UIViewContentModeScaleAspectFill;
    CGRect frame=mole.frame;
    float width=frame.size.width;
    frame.origin.x+=5*width/9;
    frame.origin.y-=4.3*width/9;
    frame.size.width=3*width/3;
    frame.size.height=3*width/3;
    hammer.frame=frame;
    hammer.transform=CGAffineTransformMakeRotation(-5*M_PI_2/8);
    [self.view addSubview:hammer];

    [self comeOut:mole];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        hammer.transform=CGAffineTransformMakeRotation(-1*M_PI_2/8);
    } completion:^(BOOL finished) {
        [hammer removeFromSuperview];
    }];
    
    mole.expression=CRY;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:0 animations:^{
            float distance=0.7*constraint.constant;
            constraint.constant=0+distance;
            CGRect next=mole.frame;
            next.origin.y=mole.initialOriginY+distance;
            mole.frame=next;

        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                constraint.constant=0;
                CGRect next=mole.frame;
                next.origin.y=mole.initialOriginY;
                mole.frame=next;
                
            } completion:nil];

        }];;
    
}




@end




