//
//  ViewController.m
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import "EFMNestedTables.h"

@interface EFMNestedTables ()

@end

@implementation EFMNestedTables

@synthesize groupCell;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    metricsGroupsAmt = 30;
    metricsAmt =[[NSMutableArray alloc] initWithObjects: nil];
    for (int i = 0; i < metricsGroupsAmt; i++) {
        int randNum = rand() % 5 + 1;
        [metricsAmt addObject:[NSNumber numberWithInt:randNum]];
    }
	expandedIndexes = [[NSMutableDictionary alloc] init];
	selectableCellsState = [[NSMutableDictionary alloc] init];
	selectableSubCellsState = [[NSMutableDictionary alloc] init];
    
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return metricsGroupsAmt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EFMGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupCell"];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"EFMGroupCell" owner:self options:nil];
        cell = groupCell;
        self.groupCell = nil;
    }
    
    [cell setParentTable: self];
    [cell setSubCellsAmt: [[metricsAmt objectAtIndex:indexPath.row] intValue]];
    
    NSMutableDictionary *subCellsState = [selectableSubCellsState objectForKey:indexPath];
    int selectedSubCellsAmt = 0;
    for (NSString *key in subCellsState) {
        SelectableCellState cellState = [[subCellsState objectForKey:key] intValue];
        if (cellState == Checked) {
            selectedSubCellsAmt++;
        }
    }
    [cell setSelectedSubCellsAmt: selectedSubCellsAmt];
    [cell setSelectableSubCellsState: [selectableSubCellsState objectForKey:indexPath]];
    
    SelectableCellState cellState = [[selectableCellsState objectForKey:indexPath] intValue];
    switch (cellState) {
        case Checked:       [cell check];       break;
        case Unchecked:     [cell uncheck];     break;
        case Halfchecked:   [cell halfCheck];   break;
        default:                                break;
    }
    
    BOOL isExpanded = [[expandedIndexes objectForKey:indexPath] boolValue];
    cell.isExpanded = isExpanded;
    if(cell.isExpanded) {
        [cell rotateExpandBtnToExpanded];
    } else {
        [cell rotateExpandBtnToCollapsed];
    }
    
    [cell.subTable reloadData];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int amt = [[metricsAmt objectAtIndex:indexPath.row] intValue];
    BOOL isExpanded = [[expandedIndexes objectForKey:indexPath] boolValue];
    if(isExpanded) {
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
    
    switch (cellState) {
        case Checked:
            // load/unload graphs according to this cell state and its subcells
            break;
        case Unchecked:
            // load/unload graphs according to this cell state and its subcells
            break;
        case Halfchecked:
            // load/unload graphs according to this cell state and its subcells
            break;
        default:
            break;
    }
}

- (void) groupCell:(EFMGroupCell *)cell didSelectSubCell:(EFMSelectableCell *)subCell withIndexPath: (NSIndexPath *)indexPath
{
    NSIndexPath *groupCellIndexPath = [self.tableView indexPathForCell:cell];
    NSNumber *cellStateNumber = [NSNumber numberWithInt:cell.selectableCellState];
    [selectableCellsState setObject:cellStateNumber forKey:groupCellIndexPath];
    
    //NSIndexPath *subCellIndexPath = [cell.subTable indexPathForCell:subCell];
    NSNumber *subCellStateNumber = [NSNumber numberWithInt:subCell.selectableCellState];
    if (![selectableSubCellsState objectForKey:groupCellIndexPath]) {
        NSMutableDictionary *subCellState = [[NSMutableDictionary alloc] initWithObjectsAndKeys: subCellStateNumber, indexPath, nil];
        [selectableSubCellsState setObject:subCellState forKey:groupCellIndexPath];
    } else {
        [[selectableSubCellsState objectForKey:groupCellIndexPath] setObject:subCellStateNumber forKey:indexPath];
    }
    
    [cell setSelectableSubCellsState: [selectableSubCellsState objectForKey:groupCellIndexPath]];
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
