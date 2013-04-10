//
//  rootViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/10/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol rootViewControllerDelegate <NSObject>
-(void)callNewScreen: (NSString *)screenName;
@end

@interface rootViewController : UIViewController

- (IBAction)getRecordView:(id)sender;
- (IBAction)getReviewView:(id)sender;
- (IBAction)getPracticeView:(id)sender;

@property (nonatomic, assign) id<rootViewControllerDelegate> delegate;

@end
