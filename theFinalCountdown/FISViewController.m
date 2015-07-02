//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) NSInteger numberOfSeconds;
@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (nonatomic, strong) NSDateComponents *timeComponents;
@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    
[self.timerLabel setHidden:YES];

}


- (IBAction)startButtonTapped:(UIButton *)sender {
  
    
    self.pauseButton.enabled = YES;
    
    self.numberOfSeconds = self.timePicker.countDownDuration;
    
    self.timerLabel.text = [self changesSecondsIntoTheRightFormat];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                                selector:@selector(startCountDown)
                                   userInfo:nil
                                    repeats:YES];
    
    
    [self.timePicker setHidden:YES];
    [self.timerLabel setHidden:NO];
    
    
    if ([sender.titleLabel.text isEqualToString:@"Start"]) {
        
        [sender setTitle:@"Cancel" forState:UIControlStateNormal];
        
    } else {
        
        [self.timer invalidate];
        [self.timerLabel setHidden:YES];
        [self.timePicker setHidden:NO];
        [self.pauseButton setEnabled:NO];
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    
    }
}

-(NSString *)changesSecondsIntoTheRightFormat
{
    NSInteger seconds = self.numberOfSeconds % 60;
    NSInteger minutes = (self.numberOfSeconds / 60) % 60;
    NSInteger hours = self.numberOfSeconds / 3600;
    
   return [NSString stringWithFormat:@"%02li:%02li:%02li",hours, minutes, seconds];
}

-(void)startCountDown

{
    
    self.numberOfSeconds--;
    
    if (self.numberOfSeconds <= 0) {
        [self.timer invalidate];
    } else {
        
        self.timerLabel.text = [self changesSecondsIntoTheRightFormat];
    }
}

- (IBAction)pauseButtonTapped:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"Pause"]) {
        [sender setTitle:@"Resume" forState:UIControlStateNormal];
         [self.timer invalidate];
        
        
    } else {
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(startCountDown)
                                                    userInfo:nil
                                                     repeats:YES];
    }
   
}

@end
