//
//  EFMSelectableCell.h
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 23/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EFMNestedTable;

typedef enum
{
    Unchecked = 0,
    Checked,
    Halfchecked,
}
SelectableCellState;

@interface EFMSelectableCell : UITableViewCell
{
    IBOutlet UIView *checkBox;
    
    UIImageView *onCheckBox;
    IBOutlet UIImageView *offCheckBox;
    
    IBOutlet UIView *tapTransitionsOverlay;
}

@property (nonatomic) IBOutlet UILabel *itemText;

@property (nonatomic, assign) EFMNestedTable *parentTable;
@property (nonatomic) SelectableCellState selectableCellState;

- (SelectableCellState) toggleCheck;
- (void) check;
- (void) uncheck;
- (void) halfCheck;

- (void) styleEnabled;
- (void) styleDisabled;
- (void) styleHalfEnabled;
- (void) tapTransition;

- (void) setupInterface;

@end
