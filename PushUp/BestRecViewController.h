//
//  BestRecViewController.h
//  PushUp
//
//  Created by Tan Ophaswongse on 9/9/14.
//  Copyright (c) 2014 Tan Ophaswongse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BestRecViewController : UIViewController{
    
    IBOutlet UILabel *rpm;
    IBOutlet UILabel *conR;
    IBOutlet UILabel *total;
}
- (IBAction)resetRecord:(id)sender;

@end
