//
//  TimeAtkViewController.h
//  PushUp
//
//  Created by Tan Ophaswongse on 9/9/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeAtkViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *setTime;
- (IBAction)startCount:(id)sender;
- (IBAction)resetTime:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startAtk;
@property (weak, nonatomic) IBOutlet UILabel *display2;
@property (weak, nonatomic) IBOutlet UILabel *counting;
@end
