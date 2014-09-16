//
//  TimeAtkViewController.m
//  PushUp
//
//  Created by Tan Ophaswongse on 9/9/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import "TimeAtkViewController.h"
#import <AudioToolbox/AudioToolbox.h>
@interface TimeAtkViewController ()

@end

@implementation TimeAtkViewController
int minute;
int count2;
int secDisplay;
SystemSoundID pewPewSound;
NSURL *pewPewURL;
NSArray *mins;
NSArray *second;
NSString *minlbl;
NSString *seclbl;
NSTimer *timer;
UIDevice *device;
int oldRpmT;
int oldConT;
int oldTotalT;
int newRpmT;
int newConT;
int newTotalT;
int conCountT;
int beginMin;
int beginSec;
NSDictionary *recordT;
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
    // Do any additional setup after loading the view.
    mins = [[NSArray alloc]init];
    second = [[NSArray alloc]init];
    for(int i=0; i<=60; i++){
        second = [second arrayByAddingObject:[NSString stringWithFormat:@"%i",i]];
    }
    for(int i=0; i<=30; i++){
        mins = [mins arrayByAddingObject:[NSString stringWithFormat:@"%i",i]];
    }
    self.setTime.dataSource = self;
    self.setTime.delegate = self;
    // Do any additional setup after loading the view.
    


}
- (void)viewWillAppear:(BOOL)animated{
    count2 =0;
    _display2.text = [NSString stringWithFormat:@"%i",count2];
    [_startAtk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentDirectory stringByAppendingPathComponent:@"Record.plist"];
    NSArray *stat = [[[NSArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    recordT = [stat objectAtIndex:0];
    oldRpmT = [recordT[@"rpm"] intValue];
    oldConT = [recordT[@"conR"] intValue];
    oldTotalT = [recordT[@"total"] intValue];
    NSLog(@"%i", oldTotalT);
    [super viewDidLoad];
    //set visible
    //NSLog(@"Time Atk");
    device.proximityMonitoringEnabled = NO;
    _counting.hidden = YES;

}

- (void) proximityChanged:(NSNotification *)notification {
	//UIDevice *device = [notification object];
    if(device.proximityState){
        count2++;
        SystemSoundID pewPewSound1;
        NSString *pewPewPath = [[NSBundle mainBundle]
                                pathForResource:@"bleep" ofType:@"wav"];
        NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &pewPewSound1);
        AudioServicesPlaySystemSound(pewPewSound1);
    }
    _display2.text = [NSString stringWithFormat:@"%i",count2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}
// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return mins.count;
    }else if(component == 1){
        return 1;
    }else if(component == 2){
        return second.count;
    }else if(component == 3){
        return 1;
    }
    return 1;
}
// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    minlbl = @"min";
    seclbl = @"sec";
    //    return picker[row];
    if(component == 0){
        return [mins objectAtIndex:row];
    }else if(component == 1){
        return minlbl;
    }else if(component == 2){
        return [second objectAtIndex:row];
    }else if(component == 3){
        return seclbl;
    }
    return @"eiei";
}
- (IBAction)startCount:(id)sender {
    [_startAtk setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    count2 = 0;
    _display2.text = [NSString stringWithFormat:@"%i",count2];
    device =[UIDevice currentDevice];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    _setTime.hidden = YES;
    _counting.hidden = NO;
    //get data
    minute = [_setTime selectedRowInComponent:0];
    secDisplay = [_setTime selectedRowInComponent:2];
    beginMin = minute;
    beginSec = secDisplay;
    NSString *clock;
    if(secDisplay <=9 && minute <=9){
        clock = [NSString stringWithFormat:@"0%i : 0%i",minute,secDisplay];
    }else if(secDisplay <= 9 && minute > 9){
        clock = [NSString stringWithFormat:@"%i : 0%i",minute,secDisplay];
    }else if(secDisplay> 9 && minute <=9){
        clock = [NSString stringWithFormat:@"0%i : %i",minute,secDisplay];
    }else if(secDisplay > 9 && minute > 9){
        clock = [NSString stringWithFormat:@"%i : %i",minute,secDisplay];
    }
    _counting.text = clock;
    if(timer == nil){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(setCommand) userInfo:nil repeats:YES];
    }
    device.proximityMonitoringEnabled = YES;
    if (device.proximityMonitoringEnabled == YES){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    }
}
- (void) setCommand
{
    if(minute == 0 && secDisplay ==0){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        //alert sound
        
        NSString *pewPewPath = [[NSBundle mainBundle]
                                pathForResource:@"sound" ofType:@"wav"];
        pewPewURL = [NSURL fileURLWithPath:pewPewPath];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &pewPewSound);
        AudioServicesPlaySystemSound(pewPewSound);
        // Also issue visual alert
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Time out!"
                              message:nil
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
        [alert show];
        [_startAtk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self resetClock];
    }else if(secDisplay == 0){
        minute -= 1;
        secDisplay = 60;
    }
    secDisplay -=1;
    NSString *clock;
    
    if(secDisplay <=9 && minute <=9){
        clock = [NSString stringWithFormat:@"0%i : 0%i",minute,secDisplay];
    }else if(secDisplay <= 9 && minute > 9){
        clock = [NSString stringWithFormat:@"%i : 0%i",minute,secDisplay];
    }else if(secDisplay> 9 && minute <=9){
        clock = [NSString stringWithFormat:@"0%i : %i",minute,secDisplay];
    }else if(secDisplay > 9 && minute > 9){
        clock = [NSString stringWithFormat:@"%i : %i",minute,secDisplay];
    }
    _counting.text = clock;
    
    
}


- (IBAction)resetTime:(id)sender {
    conCountT = count2;
    [_startAtk setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    newTotalT = oldTotalT + count2;
    int totaltime = (beginMin*60)+beginSec;
    newRpmT = ((float)count2/totaltime)*60;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Record.plist"];
    if (newRpmT > oldRpmT){
        oldRpmT = newRpmT;
    }
    newConT = conCountT;
    if (newConT >oldConT){
        oldConT = newConT;
    }
    NSString *rpmStr = [NSString stringWithFormat:@"%i",oldRpmT];
    NSString *conStr = [NSString stringWithFormat:@"%i",oldConT];
    NSString *totalStr = [NSString stringWithFormat:@"%i",newTotalT];
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
    _setTime.hidden = NO;
    _counting.hidden = YES;
    count2 = 0;
    _display2.text = [NSString stringWithFormat:@"%i",count2];
    device.proximityMonitoringEnabled = NO;
}
-(void)resetClock{
    newTotalT = oldTotalT + count2;
    int totaltime = (minute*60)+secDisplay;
    newRpmT = ((float)count2/totaltime)*60;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Record.plist"];
//    if (newRpmT > oldRpmT){
//        oldRpmT = newRpmT;
//    }
    newConT = conCountT;
    if (newConT >oldConT){
        oldConT = newConT;
    }
    NSString *rpmStr = [NSString stringWithFormat:@"%i",oldRpmT];
    NSString *conStr = [NSString stringWithFormat:@"%i",oldConT];
    NSString *totalStr = [NSString stringWithFormat:@"%i",newTotalT];
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
    _setTime.hidden = NO;
    _counting.hidden = YES;
    device.proximityMonitoringEnabled = NO;

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self resetTime:self];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
- (void)viewWillDisappear:(BOOL)animated {
    device.proximityMonitoringEnabled = NO;
    [self resetClock];
    [self resetTime:self];
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    AudioServicesDisposeSystemSoundID(pewPewSound);
    NSLog(@"in");
}


@end
