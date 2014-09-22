//
//  EmerViewController.m
//  PushUp
//
//  Created by Pheerawit Charuvajana on 9/22/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import "EmerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface EmerViewController (){
    SystemSoundID help1;
    SystemSoundID help2;
    SystemSoundID help3;
    SystemSoundID help4;
}

@end
@implementation EmerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)call:(id)sender {
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2135554321"]];
    NSLog(@"hello");
}

- (IBAction)help1:(id)sender {
  
    NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"Beedo_3" ofType:@"wav"];
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &help1);
    AudioServicesPlaySystemSound(help1);
    
}

- (IBAction)help2:(id)sender {
    NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"Help_eiei" ofType:@"wav"];
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &help2);
    AudioServicesPlaySystemSound(help2);
}

- (IBAction)help3:(id)sender {
  
    NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"Help" ofType:@"wav"];
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &help3);
    AudioServicesPlaySystemSound(help3);
}

- (IBAction)StopSound:(id)sender {
    AudioServicesDisposeSystemSoundID(help1);
    AudioServicesDisposeSystemSoundID(help2);
    AudioServicesDisposeSystemSoundID(help3);
}

@end
