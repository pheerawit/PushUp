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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentDirectory stringByAppendingPathComponent:@"Record.plist"];
    NSArray *stat = [[[NSArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    NSDictionary *record = [stat objectAtIndex:0];
    rpm.text = record[@"rpm"];
    conR.text = record[@"conR"];
    total.text = record[@"total"];
    NSLog(@"%@",record[@"total"]);
    [super viewWillAppear:animated];
    // do stuff
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

- (IBAction)resetRecord:(id)sender {
    NSLog(@"Reset");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Record.plist"];
    NSArray *keys = [NSArray arrayWithObjects:@"rpm", @"conR",@"total", nil];
    NSArray *objects = [NSArray arrayWithObjects:@"0", @"0",@"0", nil];
    NSDictionary *stat = [NSDictionary dictionaryWithObjects:objects
                                                     forKeys:keys];
    NSMutableArray *newRecord = [[NSMutableArray alloc]initWithObjects:stat, nil];
    [newRecord writeToFile:filePath atomically:YES];
    rpm.text = @"0";
    conR.text = @"0";
    total.text = @"0";


}
@end
