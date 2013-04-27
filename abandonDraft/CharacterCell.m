//
//  CharacterCell.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 3/30/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "CharacterCell.h"

@implementation CharacterCell{
    UILabel *_characterValue;
    UILabel *_pinyinValue;
    UILabel *_englishValue;
}

@synthesize playButton, recording, player;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [[AVAudioSession sharedInstance] setDelegate: self];
        NSError *setCategoryError = nil;
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: &setCategoryError];
        if (setCategoryError)
            NSLog(@"Error setting category! %@", setCategoryError);
    
        CGRect characterValueRect = CGRectMake(0,0, 44, 44);
        _characterValue = [[UILabel alloc]initWithFrame:characterValueRect];
        [_characterValue setFont:[UIFont fontWithName:@"Gill Sans" size:16]];
        [[self contentView] addSubview:_characterValue];
        
        CGRect pinyinValueRect = CGRectMake(50,0, 100, 22);
        _pinyinValue = [[UILabel alloc]initWithFrame:pinyinValueRect];
        [_pinyinValue setFont:[UIFont fontWithName:@"Gill Sans" size:16]];
        [[self contentView] addSubview:_pinyinValue];
        
        CGRect englishValueRect = CGRectMake(50,22,230,22);
        _englishValue = [[UILabel alloc]initWithFrame:englishValueRect];
        [_englishValue setFont:[UIFont fontWithName:@"Gill Sans" size:16]];
        [[self contentView] addSubview:_englishValue];
        
        /*
        CGRect playRect = CGRectMake(230, 0, 50, 22);
        playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playButton setFrame:playRect];
        [playButton setTitle:@"play" forState:UIControlStateNormal];
        [[self contentView] addSubview:playButton];
        [playButton addTarget:self action:@selector(playRecoding) forControlEvents:UIControlEventTouchDown];
         */
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCharacter:(NSString *)character{
    if (![character isEqualToString:_character]){
        _character = [character copy];
        [_characterValue setText:_character];
    }
}

-(void)setPinyin:(NSString *)pinyin{
    if (![pinyin isEqualToString:_pinyin]){
        _pinyin = [pinyin copy];
        [_pinyinValue setText:_pinyin];
    }
    
}

-(void)setEnglish:(NSString *)english{
    if (![english isEqualToString:_english]){
        _english = [english copy];
        [_englishValue setText:_english];
    }
}

-(void)playRecoding{
    NSError *err;
    NSLog(@"%@", recording);
    player = [[AVAudioPlayer alloc]initWithContentsOfURL:recording error:&err];
    [player setDelegate:self];
    [player play];

}


@end
