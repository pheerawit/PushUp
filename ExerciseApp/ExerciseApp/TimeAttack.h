//
//  TimeAttack.h
//  ExerciseApp
//
//  Created by Pheerawit Charuvajana on 9/9/14.
//  Copyright (c) 2014 Pheerawit Charuvajana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeAttack : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *setTime;
- (IBAction)startCount:(id)sender;
- (IBAction)resetTime:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *counting;

@end
