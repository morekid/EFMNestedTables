//
//  ViewController.h
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFMGroupCell.h"
#import "EFMSelectableCell.h"

@interface EFMNestedTables : UITableViewController {
    int metricsGroupsAmt;
    NSMutableArray *metricsAmt;
	NSMutableDictionary *expandedIndexes;
    NSMutableDictionary *selectableCellsState;
    NSMutableDictionary *selectableSubCellsState;
}

@property (assign) IBOutlet EFMGroupCell *groupCell;

- (void) collapsableButtonTapped: (UIControl *)button withEvent: (UIEvent *)event;
- (void) groupCell:(EFMGroupCell *)cell didSelectSubCell:(EFMSelectableCell *)subCell withIndexPath: (NSIndexPath *)indexPath;

@end
