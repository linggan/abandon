//
//  reviewTileViewController.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "reviewTileViewController.h"
#import "CharacterTile.h"

@implementation reviewTileViewController
@synthesize wordList;

static NSString *CellTableIdentifier = @"CellTableIdentifier";


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getWords:self];
    
    
    //UICollectionView *collectionView = (id)[[self view] viewWithTag:1];
    [self.collectionView registerClass:[CharacterTile class] forCellWithReuseIdentifier:CellTableIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [wordList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CharacterTile *tile = [cv dequeueReusableCellWithReuseIdentifier:CellTableIdentifier forIndexPath:indexPath];
    NSInteger currentIndex = [indexPath row];

    [tile setCharacter:[[wordList objectAtIndex:currentIndex] valueForKey:@"chinese"]];
    [tile setPinyin:[[wordList objectAtIndex:currentIndex]valueForKey:@"pinyin"]];
    
    return tile;
}



-(void)getWords:(id)ViewController{
    [[self dataDelegate] getWords:self];
}


@end
