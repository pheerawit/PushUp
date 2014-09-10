//
//  ViewController.h
//  PushUp
//
//  Created by Tan Ophaswongse on 9/9/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITabBarControllerDelegate,UITabBarDelegate>
{
    IBOutlet UILabel *display;
}
@property (weak, nonatomic) IBOutlet UILabel *show;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)reset:(id)sender;
@end
