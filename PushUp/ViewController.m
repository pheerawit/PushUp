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
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController (){
    SystemSoundID ready;
   }
@end

@implementation ViewController
int count;
NSTimer *timer;
int min;
int sec;
UIDevice *device;
int oldRpm;
int oldCon;
int oldTotal;
int newRpm;
int newCon;
int newTotal;
int conCount;


NSDictionary *record;
- (void)viewDidLoad
{

    count =0;
    device = [UIDevice currentDevice];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [_startB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stopB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentDirectory stringByAppendingPathComponent:@"Record.plist"];
    NSArray *stat = [[[NSArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    record = [stat objectAtIndex:0];
    oldRpm = [record[@"rpm"] intValue];
    oldCon = [record[@"conR"] intValue];
    oldTotal = [record[@"total"] intValue];
    NSLog(record[@"total"]);

}
- (void) proximityChanged:(NSNotification *)notification {
	UIDevice *device = [notification object];
    if(device.proximityState){
        count++;
        conCount ++;
        SystemSoundID pewPewSound1;
        NSString *pewPewPath = [[NSBundle mainBundle]
                                pathForResource:@"bleep" ofType:@"wav"];
        NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &pewPewSound1);
        AudioServicesPlaySystemSound(pewPewSound1);
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
    [_startB setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_stopB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceProximityStateDidChangeNotification" object:device];
   
    NSString *pewPewPath = [[NSBundle mainBundle]
                            pathForResource:@"readysetgo" ofType:@"wav"];
    NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &ready);
    AudioServicesPlaySystemSound(ready);
    [NSThread sleepForTimeInterval:4];
    if(timer == nil){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(setCommand) userInfo:nil repeats:YES];
    }
    device.proximityMonitoringEnabled = YES;
    if (device.proximityMonitoringEnabled == YES){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    }
    
    
}

- (IBAction)stop:(id)sender {
    [_startB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stopB setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    newTotal = oldTotal + count;
    int totaltime = (min*60)+sec;
    newRpm = ((float)count/totaltime)*60;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Record.plist"];
    if (newRpm > oldRpm){
        oldRpm = newRpm;
    }
    newCon = conCount;
    if (newCon >oldCon){
        oldCon = newCon;
    }
    NSString *rpmStr = [NSString stringWithFormat:@"%i",oldRpm];
    NSString *conStr = [NSString stringWithFormat:@"%i",oldCon];
    NSString *totalStr = [NSString stringWithFormat:@"%i",newTotal];
    NSArray *keys = [NSArray arrayWithObjects:@"rpm", @"conR",@"total", nil];
    NSArray *objects = [NSArray arrayWithObjects:rpmStr, conStr,totalStr, nil];
    NSDictionary *stat = [NSDictionary dictionaryWithObjects:objects
                                                     forKeys:keys];
    NSMutableArray *newRecord = [[NSMutableArray alloc]initWithObjects:stat, nil];
    [newRecord writeToFile:filePath atomically:YES];
    if(timer){
		[timer invalidate];
		timer = nil;
	}
    device.proximityMonitoringEnabled = NO;
    conCount =0;

}

- (IBAction)reset:(id)sender {
    [_startB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self stop:self];
    [_stopB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    min = 0;
    sec = 0;
    _show.text = [NSString stringWithFormat:@"0%i : 0%i",min,sec];
    count = 0;
    display.text = [NSString stringWithFormat:@"%i",count];
}
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self stop:self];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
- (void)viewWillDisappear:(BOOL)animated {
    device.proximityMonitoringEnabled = NO;
    [self reset:self];
}

@end
