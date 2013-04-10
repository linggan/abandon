//
//  AppDelegate.h
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/19/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recordViewController.h"
#import "reviewViewController.h"
#import "rootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, coreDataDelegate, recordViewControllerDelegate, rootViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) recordViewController *recordVC;
@property (nonatomic, retain) reviewViewController *reviewVC;
@property (nonatomic, retain) rootViewController *rootVC;
@property (nonatomic, retain) UINavigationController *naviVC;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
