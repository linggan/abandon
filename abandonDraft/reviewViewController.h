//
//  reviewViewController.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coreDataDelegate.h"

//view current data entries
//have mp3 export option by chinese, chinese+english
//have option to choose by random, by select, by scores
//think about option view

@interface reviewViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) NSArray *wordList;
@property (nonatomic, assign) id<coreDataDelegate> dataDelegate;


@end


