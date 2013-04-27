//
//  CharacterTile.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/20/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "CharacterTile.h"

@implementation CharacterTile{

UILabel *_characterValue;
UILabel *_pinyinValue;

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        CGRect characterValueRect = CGRectMake(0,0, 44, 44);
        _characterValue = [[UILabel alloc]initWithFrame:characterValueRect];
        [_characterValue setFont:[UIFont fontWithName:@"Gill Sans" size:16]];
        [[self contentView] addSubview:_characterValue];
        
        CGRect pinyinValueRect = CGRectMake(0,50, 100, 30);
        _pinyinValue = [[UILabel alloc]initWithFrame:pinyinValueRect];
        [_pinyinValue setFont:[UIFont fontWithName:@"Gill Sans" size:16]];
        [[self contentView] addSubview:_pinyinValue];
                 
        }
    return self;
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



@end
