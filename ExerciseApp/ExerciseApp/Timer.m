//
//  Timer.m
//  ExerciseApp
//
//  Created by Pheerawit Charuvajana on 9/9/14.
//  Copyright (c) 2014 Pheerawit Charuvajana. All rights reserved.
//

#import "Timer.h"

@interface Timer ()

@end

@implementation Timer
NSTimer *timer;
int min;
int sec;
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
}



@end
