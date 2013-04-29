//
//  VocabExportViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/28/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGScrollView.h"
#import "coreDataDelegate.h"

@protocol VocabExportViewControllerDelegate <NSObject>
- (void)didDismissPresentedViewController;
@end

@interface VocabExportViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, assign) id<coreDataDelegate> dataDelegate;
@property (nonatomic, retain) NSArray *wordList;
@property (nonatomic, retain) NSMutableArray *vocabList;
@property (nonatomic, retain) NSString *vocabListName;


@property (nonatomic, weak) id<VocabExportViewControllerDelegate> delegate;

@end
