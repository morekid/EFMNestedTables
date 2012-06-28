//
//  ViewController.h
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFMSelectableCell.h"
#import "EFMGroupCell.h"
#import "EFMSubCell.h"

@interface EFMNestedTables : UITableViewController {
	NSMutableDictionary *expandedIndexes;
    NSMutableDictionary *selectableCellsState;
    NSMutableDictionary *selectableSubCellsState;
}

@property (assign) int mainItemsAmt;
@property (strong) NSMutableDictionary *subItemsAmt;

@property (assign) IBOutlet EFMGroupCell *groupCell;

#pragma mark - Internal

- (void) collapsableButtonTapped: (UIControl *)button withEvent: (UIEvent *)event;
- (void) groupCell:(EFMGroupCell *)cell didSelectSubCell:(EFMSelectableCell *)subCell withIndexPath: (NSIndexPath *)indexPath;

#pragma mark - To be implemented in subclasses

- (NSInteger) mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section;
- (NSInteger) mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(EFMGroupCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (EFMGroupCell *) mainTable:(UITableView *)mainTable setCell:(EFMGroupCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (EFMSubCell *) groupCell:(EFMGroupCell *)groupCell setSubCell:(EFMSubCell *)subCell forRowAtIndexPath:(NSIndexPath *)indexPath;


@end
