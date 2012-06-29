//
//  EFMSubCell.m
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import "EFMSubCell.h"

@implementation EFMSubCell

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        offCheckBox = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"blueLedSmallOff"]];
        onCheckBox = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"blueLedSmall"]];
    }
    return self;
}

- (void) setupInterface
{
    [super setupInterface];
}

- (void) tapTransition
{
    [super tapTransition];
}

@end
