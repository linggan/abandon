//
//  reviewTileViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coreDataDelegate.h"

@interface reviewTileViewController : UICollectionViewController

@property (nonatomic, assign) id<coreDataDelegate> dataDelegate;
@property (nonatomic, retain) NSArray *wordList;

@end
