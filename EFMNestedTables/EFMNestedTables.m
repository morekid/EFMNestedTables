//
//  EFMNestedTables.m
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import "EFMNestedTables.h"

@interface EFMNestedTables ()

@end

@implementation EFMNestedTables

@synthesize mainItemsAmt, subItemsAmt, groupCell;

#pragma mark - To be implemented in sublclasses

- (NSInteger)mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"\n Oops! You didn't specify the amount of Items in the Main tableview \n Please implement \"%@\" in your EFMNestedTables subclass.", NSStringFromSelector(_cmd));
    return 0;
}

- (NSInteger)mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(EFMGroupCell *)item atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"\n Oops! You didn't specify the amount of Sub Items for this Main Item \n Please implement \"%@\" in your EFMNestedTables subclass.", NSStringFromSelector(_cmd));
    return 0; 
}

- (EFMGroupCell *)mainTable:(UITableView *)mainTable setItem:(EFMGroupCell *)item forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // customizable attributes:
    // UILabel itemText
    
    if (indexPath.row == 0)
    {
        NSLog(@"\n Oops! Item cells in the Main tableview are not configured \n Please implement \"%@\" in your EFMNestedTables subclass.", NSStringFromSelector(_cmd));
    }
    return item;
}

- (EFMSubCell *)item:(EFMGroupCell *)item setSubItem:(EFMSubCell *)subItem forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSLog(@"\n Oops! Sub Items for this Item are not configured \n Please implement \"%@\" in your EFMNestedTables subclass.", NSStringFromSelector(_cmd));
    }
    return subItem;
}

- (void) mainTable:(UITableView *)mainTable hasSetItem:(EFMGroupCell *)item withIndexPath:(NSIndexPath *)indexPath toState:(SelectableCellState)state
{
    // sample Item behavior management code
    /*switch (state) {
        case Checked:
            // do stuff
            break;
        case Unchecked:
            // do stuff
            break;
        default:
            break;
    }*/
    NSLog(@"\n Oops! You didn't specify a behavior for this Item \n Please implement \"%@\" in your EFMNestedTables subclass.", NSStringFromSelector(_cmd));
}

- (void) item:(EFMGroupCell *)item hasSetSubItem:(EFMSelectableCell *)subItem withIndexPath:(NSIndexPath *)indexPath toState:(SelectableCellState)state
{
    // sample Item behavior management code
    /*switch (state) {
         case Checked:
            // do stuff
         break;
         case Unchecked:
            // do stuff
         break;
         default:
         break;
    }*/
    NSLog(@"\n Oops! You didn't specify a behavior for this Sub Item \n Please implement \"%@\" in your EFMNestedTables subclass.", NSStringFromSelector(_cmd));
}

#pragma mark - Class lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    subItemsAmt = [[NSMutableDictionary alloc] initWithDictionary:nil];
	expandedIndexes = [[NSMutableDictionary alloc] init];
	selectableCellsState = [[NSMutableDictionary alloc] init];
	selectableSubCellsState = [[NSMutableDictionary alloc] init];
    
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - TableView delegation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    mainItemsAmt = [self mainTable:tableView numberOfItemsInSection:section];
    return mainItemsAmt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EFMGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"EFMGroupCell" owner:self options:nil];
        cell = groupCell;
        self.groupCell = nil;
    }
    
    [cell setParentTable: self];
    
    cell = [self mainTable:tableView setItem:cell forRowAtIndexPath:indexPath];
    
    NSNumber *amt = [NSNumber numberWithInt:[self mainTable:tableView numberOfSubItemsforItem:cell atIndexPath:indexPath]];
    [subItemsAmt setObject:amt forKey:indexPath];
    
    [cell setSubCellsAmt: [[subItemsAmt objectForKey:indexPath] intValue]];
    
    NSMutableDictionary *subCellsState = [selectableSubCellsState objectForKey:indexPath];
    int selectedSubCellsAmt = 0;
    for (NSString *key in subCellsState)
    {
        SelectableCellState cellState = [[subCellsState objectForKey:key] intValue];
        if (cellState == Checked) {
            selectedSubCellsAmt++;
        }
    }
    [cell setSelectedSubCellsAmt: selectedSubCellsAmt];
    [cell setSelectableSubCellsState: [selectableSubCellsState objectForKey:indexPath]];
    
    SelectableCellState cellState = [[selectableCellsState objectForKey:indexPath] intValue];
    switch (cellState)
    {
        case Checked:       [cell check];       break;
        case Unchecked:     [cell uncheck];     break;
        case Halfchecked:   [cell halfCheck];   break;
        default:                                break;
    }
    
    BOOL isExpanded = [[expandedIndexes objectForKey:indexPath] boolValue];
    cell.isExpanded = isExpanded;
    if(cell.isExpanded)
    {
        [cell rotateExpandBtnToExpanded];
    }
    else
    {
        [cell rotateExpandBtnToCollapsed];
    }
    
    [cell.subTable reloadData];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int amt = [[subItemsAmt objectForKey:indexPath] intValue];
    BOOL isExpanded = [[expandedIndexes objectForKey:indexPath] boolValue];
    if(isExpanded)
    {
        return [EFMGroupCell getHeight] + [EFMGroupCell getsubCellHeight]*amt;
    }
    return [EFMGroupCell getHeight];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EFMGroupCell *cell = (EFMGroupCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell tapTransition];
    SelectableCellState cellState = [cell toggleCheck];
    NSNumber *cellStateNumber = [NSNumber numberWithInt:cellState];
    [selectableCellsState setObject:cellStateNumber forKey:indexPath];
    
    [cell subCellsToggleCheck];
    
    [self mainTable:tableView hasSetItem:cell withIndexPath:indexPath toState:cellState];
}

#pragma mark - Nested Tables events

- (void) groupCell:(EFMGroupCell *)cell didSelectSubCell:(EFMSelectableCell *)subCell withIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *groupCellIndexPath = [self.tableView indexPathForCell:cell];
    NSNumber *cellStateNumber = [NSNumber numberWithInt:cell.selectableCellState];
    [selectableCellsState setObject:cellStateNumber forKey:groupCellIndexPath];
    
    //NSIndexPath *subCellIndexPath = [cell.subTable indexPathForCell:subCell];
    NSNumber *subCellStateNumber = [NSNumber numberWithInt:subCell.selectableCellState];
    if (![selectableSubCellsState objectForKey:groupCellIndexPath])
    {
        NSMutableDictionary *subCellState = [[NSMutableDictionary alloc] initWithObjectsAndKeys: subCellStateNumber, indexPath, nil];
        [selectableSubCellsState setObject:subCellState forKey:groupCellIndexPath];
    }
    else
    {
        [[selectableSubCellsState objectForKey:groupCellIndexPath] setObject:subCellStateNumber forKey:indexPath];
    }
    
    [cell setSelectableSubCellsState: [selectableSubCellsState objectForKey:groupCellIndexPath]];
    
    [self item:cell hasSetSubItem:subCell withIndexPath:indexPath toState:subCell.selectableCellState];
}

- (void) collapsableButtonTapped: (UIControl *) button withEvent: (UIEvent *) event
{
    UITableView *tableView = self.tableView;
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint: [[[event touchesForView: button] anyObject] locationInView: tableView]];
    if ( indexPath == nil )
        return;
    // reset cell expanded state in array
	BOOL isExpanded = ![[expandedIndexes objectForKey:indexPath] boolValue];
	NSNumber *expandedIndex = [NSNumber numberWithBool:isExpanded];
	[expandedIndexes setObject:expandedIndex forKey:indexPath];

    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end
