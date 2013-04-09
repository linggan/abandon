//
//  reviewViewController.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 1/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "reviewViewController.h"
#import "CharacterCell.h"

@implementation reviewViewController
@synthesize wordList;

static NSString *CellTableIdentifier = @"CellTableIdentifier";


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getWordsFromQueue:self];
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    [tableView registerClass:[CharacterCell class] forCellReuseIdentifier:CellTableIdentifier];
    self.clearsSelectionOnViewWillAppear = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [wordList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CharacterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil)
    {
        cell = [[CharacterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    
    NSInteger currentIndex = [indexPath row];
    NSString *hanzi = [[wordList objectAtIndex:currentIndex] valueForKey:@"chinese"];
    NSString *pinyin = [[wordList objectAtIndex:currentIndex] valueForKey:@"pinyin"];
    NSString *english = [[wordList objectAtIndex:currentIndex] valueForKey:@"english"];
    
    [cell setCharacter:hanzi];
    [cell setPinyin:pinyin];
    [cell setEnglish:english];
    [cell setRecording:[NSURL URLWithString:[[wordList objectAtIndex:currentIndex] valueForKey:@"chineseRecording"]]];
        
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


-(void)getWordsFromQueue:(id)ViewController{
    [[self dataDelegate] getWordsFromQueue:self];
}



@end
