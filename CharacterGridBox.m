//
//  CharacterGridBox.m
//  abandonDraft
//
//  Created by Gwendolyn Weston on 4/26/13.
//  Copyright (c) 2013 Coefficient Zero. All rights reserved.
//

#import "CharacterGridBox.h"


@implementation CharacterGridBox

- (id)initWithFrame:(CGRect)frame
       AndCharacter: (NSString *)character
{
    self = [super initWithFrame:frame];
    if (self) {
        _characterBoxText = [[UILabel alloc]initWithFrame:frame];
        [_characterBoxText setText:character];
        
        [self addSubview:_characterBoxText];
        [self setSelected:false];

    }
    
    return self;
}



@end
