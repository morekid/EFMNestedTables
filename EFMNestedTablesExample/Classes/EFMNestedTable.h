//
//  EFMNestedTables.h
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFMSelectableCell.h"
#import "EFMGroupCell.h"
#import "EFMSubCell.h"

@protocol EFMNestedTableDelegate<NSObject>

- (void) mainTable:(UITableView *)mainTable itemDidChange:(EFMGroupCell *)item;
- (void) item:(EFMGroupCell *)item subItemDidChange:(EFMSelectableCell *)subItem;

@end

@interface EFMNestedTable : UITableViewController<EFMNestedTableDelegate>
{
	NSMutableDictionary *expandedIndexes;
    NSMutableDictionary *selectableCellsState;
    NSMutableDictionary *selectableSubCellsState;
}

- (void) mainItemDidChange: (EFMGroupCell *)item forTap:(BOOL)tapped;
- (void) mainItem:(EFMGroupCell *)item subItemDidChange: (EFMSelectableCell *)subItem forTap:(BOOL)tapped;

#pragma mark - To be implemented in subclasses

- (NSInteger) mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section;
- (NSInteger) mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(EFMGroupCell *)item atIndexPath:(NSIndexPath *)indexPath;

- (EFMGroupCell *) mainTable:(UITableView *)mainTable setItem:(EFMGroupCell *)item forRowAtIndexPath:(NSIndexPath *)indexPath;
- (EFMSubCell *) item:(EFMGroupCell *)item setSubItem:(EFMSubCell *)subItem forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void) collapsingItem:(EFMGroupCell *)item withIndexPath:(NSIndexPath *)indexPath;
- (void) expandingItem:(EFMGroupCell *)item withIndexPath:(NSIndexPath *)indexPath;

- (NSString *) nibNameForMainCell;

#pragma mark - Internal

@property (assign) int mainItemsAmt;
@property (strong) NSMutableDictionary *subItemsAmt;
@property (assign) id<EFMNestedTableDelegate> delegate;

@property (assign) IBOutlet EFMGroupCell *groupCell;

- (void) collapsableButtonTapped: (UIControl *)button withEvent: (UIEvent *)event;
- (void) groupCell:(EFMGroupCell *)cell didSelectSubCell:(EFMSelectableCell *)subCell withIndexPath: (NSIndexPath *)indexPath andWithTap:(BOOL)tapped;

@end
