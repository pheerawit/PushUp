//
//  ViewController.m
//  PushUp
//
//  Created by Tan Ophaswongse on 9/9/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureDevice.h>
@interface ViewController ()
@end

@implementation ViewController
int count;
NSTimer *timer;
int min;
int sec;
- (void)viewDidLoad
{
    count =0;
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
    if (device.proximityMonitoringEnabled == YES){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) proximityChanged:(NSNotification *)notification {
	UIDevice *device = [notification object];
	NSLog(@"In proximity: %i", device.proximityState);
    if(device.proximityState){
        count++;
    }
    display.text = [NSString stringWithFormat:@"%i",count];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setCommand
{
    
    if(sec == 59){
        min += 1;
        sec = -1;
    }
    sec = sec + 1;
    NSString *result;
    if(sec <=9 && min <=9){
        result = [NSString stringWithFormat:@"0%i : 0%i",min,sec];
    }else if(sec <= 9 && min > 9){
        result = [NSString stringWithFormat:@"%i : 0%i",min,sec];
    }else if(sec > 9 && min <=9){
        result = [NSString stringWithFormat:@"0%i : %i",min,sec];
    }else if(sec > 9 && min > 9){
        result = [NSString stringWithFormat:@"%i : %i",min,sec];
    }
    //result = [NSString stringWithFormat:@"%i : %i",min,sec];
    _show.text = result;
}

- (IBAction)start:(id)sender {
    if(timer == nil){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(setCommand) userInfo:nil repeats:YES];
    }
}

- (IBAction)stop:(id)sender {
    if(timer){
		[timer invalidate];
		timer = nil;
	}
}

- (IBAction)reset:(id)sender {
    min = 0;
    sec = 0;
    [self stop:self];
    _show.text = [NSString stringWithFormat:@"0%i : 0%i",min,sec];
    count = 0;
    display.text = [NSString stringWithFormat:@"%i",count];
}


@end
