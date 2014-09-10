//
//  BestRecViewController.m
//  PushUp
//
//  Created by Tan Ophaswongse on 9/9/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import "BestRecViewController.h"

@interface BestRecViewController ()

@end

@implementation BestRecViewController

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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentDirectory stringByAppendingPathComponent:@"Record.plist"];
    NSArray *stat = [[[NSArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    NSDictionary *record = [stat objectAtIndex:0];
    rpm.text = record[@"rpm"];
    conR.text = record[@"conR"];
    total.text = record[@"total"];
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

@end
