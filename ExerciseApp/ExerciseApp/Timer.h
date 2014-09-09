//
//  Timer.h
//  ExerciseApp
//
//  Created by Pheerawit Charuvajana on 9/9/14.
//  Copyright (c) 2014 Pheerawit Charuvajana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Timer : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *show;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)reset:(id)sender;


@end
