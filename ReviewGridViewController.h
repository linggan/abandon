//
//  ReviewGridViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/26/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGScrollView.h"
#import "coreDataDelegate.h"
#import "VocabExportViewController.h"

@interface ReviewGridViewController : UIViewController <UIScrollViewDelegate, VocabExportViewControllerDelegate>

@property (nonatomic, assign) id<coreDataDelegate> dataDelegate;
@property (nonatomic, retain) NSArray *wordList;

@end

