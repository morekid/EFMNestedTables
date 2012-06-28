//
//  EFMGroupCell.h
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFMSubCell.h"
#import "EFMSelectableCell.h"

typedef enum {
    AllSubCellsCommandChecked,
    AllSubCellsCommandUnchecked,
    AllSubCellsCommandNone,
} AllSubCellsCommand;

static const int height = 50;
static const int subCellHeight = 40;

@interface EFMGroupCell : EFMSelectableCell <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIButton *expandBtn;
    AllSubCellsCommand subCellsCommand;
}

@property (assign) BOOL isExpanded;
@property (assign) IBOutlet UITableView *subTable;
@property (assign) IBOutlet EFMSubCell *subCell;
@property (nonatomic) int subCellsAmt;
@property (assign) int selectedSubCellsAmt;
@property (nonatomic, assign) NSMutableDictionary *selectableSubCellsState;

- (void) subCellsToggleCheck;
- (void) rotateExpandBtn:(id)sender;
- (void) rotateExpandBtnToExpanded;
- (void) rotateExpandBtnToCollapsed;

+ (int) getHeight;
+ (int) getsubCellHeight;

@end
