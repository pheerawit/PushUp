//
//  ViewController.h
//  PushUp
//
//  Created by Tan Ophaswongse on 9/9/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *display;
}

@property (weak, nonatomic) IBOutlet UILabel *show;
- (IBAction)start:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startB;
- (IBAction)stop:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stopB;
- (IBAction)reset:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *resetB;
@end
