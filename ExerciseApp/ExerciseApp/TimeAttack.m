//
//  TimeAttack.m
//  ExerciseApp
//
//  Created by Pheerawit Charuvajana on 9/9/14.
//  Copyright (c) 2014 Pheerawit Charuvajana. All rights reserved.
//

#import "TimeAttack.h"

@interface TimeAttack ()

@end

@implementation TimeAttack
int minute;
int secDisplay;
NSArray *mins;
NSArray *second;
NSString *min;
NSString *sec;
NSTimer *timer;

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
    //set visible
    _counting.hidden = YES;
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
{       min = @"min";
        sec = @"sec";
//    return picker[row];
    if(component == 0){
        return [mins objectAtIndex:row];
    }else if(component == 1){
        return min;
    }else if(component == 2){
        return [second objectAtIndex:row];
    }else if(component == 3){
        return sec;
    }
    return @"eiei";
}
- (IBAction)startCount:(id)sender {
    _setTime.hidden = YES;
    _counting.hidden = NO;
    //get data
    minute = [_setTime selectedRowInComponent:0];
    secDisplay = [_setTime selectedRowInComponent:2];
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
}
- (void) setCommand
{
    if(minute == 0 && secDisplay ==0){
        [self resetTime:self];
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
    _setTime.hidden = NO;
    _counting.hidden = YES;
}
@end
