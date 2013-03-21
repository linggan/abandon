//
//  AppDelegate.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/19/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recordViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, recordViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) recordViewController *recordVC;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
