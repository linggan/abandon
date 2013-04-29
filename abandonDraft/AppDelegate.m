//
//  AppDelegate.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/19/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "AppDelegate.h"
#import "recordViewController.h"
#import "reviewViewController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize recordVC;
@synthesize reviewVC;
@synthesize rootVC;
@synthesize naviVC;
@synthesize tileVC;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //[self deleteData];
    [self parseWords];
    [self readDataForObject:@"Word"];
    //[self readDataForObject:@"Queue"];
    
    [self setRecordVC:[[recordViewController alloc]init]];
    [[self recordVC] setDelegate:self];
    
    [self setReviewVC:[[reviewViewController alloc]init]];
    [[self reviewVC] setDataDelegate:self];
    
    [self setRootVC:[[rootViewController alloc]init]];
    [[self rootVC] setDelegate:self];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(200, 140)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self setTileVC:[[reviewTileViewController alloc]initWithCollectionViewLayout:flowLayout]];
    [[self tileVC] setDataDelegate:self];
    
    [self setGridVC:[[ReviewGridViewController alloc]init]];
    [[self gridVC] setDataDelegate:self];
    
    [self setNaviVC:[[UINavigationController alloc]initWithRootViewController:rootVC]];
    
    [_window addSubview:[naviVC view]];
    ;
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"abandonDraft" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"abandonDraft.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.

         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Parsing Algorithm
// PARSE WORDS
-(void)parseWords{
    //read in new characters
    NSString* path = [[NSBundle mainBundle] pathForResource:@"char"
                                                     ofType:@"txt"];
    NSString* vcontent = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    //make each new character and separate string in array
    NSArray *wordList = [vcontent componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //read in dictionary database
    NSString* pathTwo = [[NSBundle mainBundle] pathForResource:@"dict"
                                                     ofType:@"txt"];
    NSString* dcontent = [NSString stringWithContentsOfFile:pathTwo
                                                   encoding:NSUTF8StringEncoding
                                                      error:NULL];    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *wordEntity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:wordEntity];
    
     //NSLog(@"%@", wordList);
    
    //if word is in database already, skip to next iteration
    NSMutableArray *newList = (NSMutableArray *)wordList;
    for (int i = 0; i <[wordList count]; i++) {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(chinese like[cd] %@)", [wordList objectAtIndex:i]]];
        NSArray *result = [context executeFetchRequest:fetchRequest error:nil];
        if (result.count){
            [newList removeObjectAtIndex:i];
            i--;
        }
        else if ([[wordList objectAtIndex:i] isEqualToString:@""]){
            [newList removeObjectAtIndex:i];
            i--;
        }
    }
    wordList = newList;
    
    //NSLog(@"%@", vcontent);
    //NSLog(@"%@", wordList);
    
    NSRange currentIteration;
    currentIteration.length = [dcontent length];
    currentIteration.location = 0;
    
    int currentWordIndex;
    for (currentWordIndex = 0; currentWordIndex<[wordList count]; currentWordIndex++){
        [self extractCorrectWord:[wordList objectAtIndex:currentWordIndex] FromDatabase:dcontent withRange:currentIteration];
    }

    [self saveContext];
}

-(void)extractCorrectWord: (NSString*)word FromDatabase: (NSString *)dcontent withRange: (NSRange)currentIteration{
                
        NSRange rangeInDatabase = [dcontent rangeOfString:word options: NSCaseInsensitiveSearch range: currentIteration];
        NSRange tempRange = rangeInDatabase;
        
        while ([dcontent characterAtIndex:tempRange.location] != '\n'){
            tempRange.length++; //count how long string is to end of line
            tempRange.location++; //iterate
        }
        
        //extract only relevant line from database
        NSRange relevantEntryRange;
        relevantEntryRange.location = rangeInDatabase.location;
        relevantEntryRange.length = tempRange.length-1;
        NSString *relevantEntry = [dcontent substringWithRange:relevantEntryRange];
    
        //markers to splice entry into chinese, pinyin, and english
        int startP, endP, startE, endE;
        BOOL engBOOL = 0;
        BOOL pinBOOL = 0;  
        BOOL weirdCase = 0;
        NSUInteger currentEntryParseIndex;
        
        //sample string:  ni[ni3]/you, yourself/
        for (currentEntryParseIndex = 0; currentEntryParseIndex <[relevantEntry length]; currentEntryParseIndex++){
            
            if ([relevantEntry characterAtIndex:currentEntryParseIndex] == '['  && (!pinBOOL)){  //beginning of pinyin
                startP = currentEntryParseIndex+1;
            }
            if([relevantEntry characterAtIndex:currentEntryParseIndex]==']' && (!pinBOOL)){  //end of pinyin
                endP = currentEntryParseIndex-1;
                pinBOOL = 1;
            }
            
            if([relevantEntry characterAtIndex:currentEntryParseIndex]=='/' && (!engBOOL) &&(currentEntryParseIndex == ([relevantEntry length]-2))){  //weird case where character occurs in definition
                weirdCase = 1;
            }
            else if([relevantEntry characterAtIndex:currentEntryParseIndex]=='/' && (!engBOOL) && (currentEntryParseIndex == ([relevantEntry length]-3))){  //weird case where character occurs in definition
                weirdCase = 1;
            }
            else if([relevantEntry characterAtIndex:currentEntryParseIndex]=='/' && (!engBOOL)){ //beginning of english
                engBOOL = 1;
                startE = currentEntryParseIndex+1;
            }
            else if([relevantEntry characterAtIndex:currentEntryParseIndex]=='/' && (engBOOL)){ //end of english meaning
                endE = currentEntryParseIndex-1;
            }
            
        }
    
        NSRange pinyinRange, englishRange;
    
        if(!weirdCase){
        //set length and location for both pinyin and english
        pinyinRange.location = startP;
        pinyinRange.length = endP - startP+1;
        
        englishRange.location = startE;
        englishRange.length = endE-startE+1;
        
        NSString *pinyin = [relevantEntry substringWithRange:pinyinRange];
        NSString *english = [relevantEntry substringWithRange:englishRange];
            
            //check that it's the right entry and not just some random occurence of the words
            NSArray *pcount = [pinyin componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if([pcount count] != [word length]){
                NSRange newRange;
                newRange.location = relevantEntryRange.location + [relevantEntry length]+1;
                newRange.length = abs([dcontent length] - newRange.location);
                [self extractCorrectWord:word FromDatabase:dcontent withRange:newRange];
            }
            
            if ([pcount count] == [word length]){
                //create new object
                NSManagedObject *wordObject =[NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:[self managedObjectContext]];
                [wordObject setValue:word forKey:@"chinese"];
                [wordObject setValue:pinyin forKey:@"pinyin"];
                [wordObject setValue:english forKey:@"english"];
    
                //NSLog(@"%@", word);
                //NSLog(@"%@", pinyin);
                //NSLog(@"%@", english);
                
                //if no queue, create queue
                NSManagedObjectContext *context = [self managedObjectContext];
                NSEntityDescription *wordEntity = [NSEntityDescription entityForName:@"Queue" inManagedObjectContext:context];
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
                [fetchRequest setEntity:wordEntity];
                NSArray *list = [context executeFetchRequest:fetchRequest error:nil];
                NSManagedObject *queue;

                if ([list count] == 0){
                    queue = [NSEntityDescription insertNewObjectForEntityForName:@"Queue" inManagedObjectContext:[self managedObjectContext]];
                    [queue setValue:@"unrecorded" forKey:@"name"];
                }
                else{
                    queue = [list objectAtIndex:0];
                }
                
                //add relationship
                NSMutableSet *newWords = [queue mutableSetValueForKey:@"notRecorded"];
                [newWords addObject:wordObject];
                //[self readDataForObject:@"Queue"];

            }
            [self saveContext];
        }
    
        //if wrong entry, keep searching with new range
        if(weirdCase){
            NSRange newRange;
            newRange.location = relevantEntryRange.location + [relevantEntry length];
            newRange.length = abs([dcontent length] - newRange.location);
            [self extractCorrectWord:word FromDatabase:dcontent withRange:newRange];
        }

}

#pragma mark - Managing Core Data (reading/deleting)

-(NSArray *)readDataForObject: (NSString *)objectName{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *objectEntity = [NSEntityDescription entityForName:objectName inManagedObjectContext:context];
    [fetchRequest setEntity:objectEntity];
    NSArray *wordList = [[NSArray alloc]init];
    
    if ([objectName isEqualToString:@"Word"]){
    wordList = [context executeFetchRequest:fetchRequest error:nil];
        id word;
        for (word in wordList){
            NSLog(@"Word: %@, %@, %@, \n%@\n", [word valueForKey:@"chinese"], [word valueForKey:@"pinyin"], [word valueForKey:@"english"], [word valueForKey:@"chineseRecording"]);
        }
    }
    
    if ([objectName isEqualToString:@"Queue"]){
        NSArray *queueList = [context executeFetchRequest:fetchRequest error:nil];
        NSManagedObject *queue = [queueList objectAtIndex:0];
        NSLog(@"Queue Found: %@", [[queueList objectAtIndex: 0] valueForKey:@"name"]);
                
        NSSet *wordSet = [queue valueForKey:@"notRecorded"];
         id word;
         for (word in wordSet){
         NSLog(@"Word: %@, %@, %@", [word valueForKey:@"chinese"], [word valueForKey:@"pinyin"], [word valueForKey:@"english"]);
         }
        wordList = [wordSet allObjects];
    }

    return wordList;
}

-(void)deleteData{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *wordEntity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:wordEntity];
    
    NSArray *words = [context executeFetchRequest:fetchRequest error:nil];
    
    for (int i = 0; i <[words count]; i++){
        [_managedObjectContext deleteObject:[words objectAtIndex:i]];
    }
    
    [self saveContext];
}

#pragma mark - Methods for protocols

-(void)getWordsFromQueue:(id)ViewController{
    NSArray *wordList = [self readDataForObject:@"Queue"];
    [ViewController setWordList:wordList];
}

-(void)getWords:(id)ViewController{
    NSArray *wordList = [self readDataForObject:@"Word"];
    [ViewController setWordList:wordList];
}

-(void)deleteWordFromQueue:(NSString*)Word{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *queueEntity = [NSEntityDescription entityForName:@"Queue" inManagedObjectContext:context];
    NSFetchRequest *queueFetchRequest = [[NSFetchRequest alloc]init];
    [queueFetchRequest setEntity:queueEntity];
    NSArray *list = [context executeFetchRequest:queueFetchRequest error:nil];
    NSManagedObject *queue;
    queue = [list objectAtIndex:0];
    
    NSEntityDescription *wordEntity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    NSFetchRequest *wordFetchRequest = [[NSFetchRequest alloc]init];
    [wordFetchRequest setEntity:wordEntity];
    [wordFetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(chinese like[cd] %@)", Word]];
    NSArray *wordObject = [context executeFetchRequest:wordFetchRequest error:nil];
        
    NSMutableSet *newWords = [queue mutableSetValueForKey:@"notRecorded"];
    [newWords removeObject:[wordObject objectAtIndex:0]];
    
    [self readDataForObject:@"Queue"];
    
    [self saveContext];
}

-(void)storeAAC:(NSString *)URL ForWord:(NSString *)Word InLanguage:(NSString *)Language{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *wordEntity = [NSEntityDescription entityForName:@"Word" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    [fetchRequest setEntity:wordEntity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(chinese like[cd] %@)", Word]];
    NSArray *result = [context executeFetchRequest:fetchRequest error:nil];
    
    if ([Language isEqualToString:@"English"]){
        [[result objectAtIndex:0] setValue:URL forKey:@"englishRecording"];
    }
    if ([Language isEqualToString:@"Chinese"]){
        [[result objectAtIndex:0] setValue:URL forKey:@"chineseRecording"];
    }
    
    [self saveContext];

}

-(void)callNewScreen:(NSString *)screenName{
    if ([screenName isEqualToString:@"record"]){
        [naviVC pushViewController:recordVC animated:TRUE];
    }
    if ([screenName isEqualToString:@"review"]){
        [naviVC pushViewController:reviewVC animated:TRUE];
    }
    if ([screenName isEqualToString:@"practice"]){
        [naviVC pushViewController:_gridVC animated:TRUE];
    }
}

@end
