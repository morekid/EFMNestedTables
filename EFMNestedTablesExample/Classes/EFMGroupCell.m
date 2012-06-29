//
//  EFMGroupCell.m
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 21/05/2012.
//  Copyright (c) 2012 Daniele De Matteis. All rights reserved.
//

#import "EFMGroupCell.h"
#import <QuartzCore/QuartzCore.h>
#import "EFMNestedTable.h"

@implementation EFMGroupCell

@synthesize isExpanded, subTable, subCell, subCellsAmt, selectedSubCellsAmt, selectableSubCellsState;

+ (int) getHeight
{
    return height;
}

+ (int) getsubCellHeight
{
    return subCellHeight;
}

#pragma mark - Lifecycle

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        subCellsCommand = AllSubCellsCommandNone;
    }
    return self;
}

- (void) setupInterface
{
    [super setupInterface];
    
    expandBtn.frame = CGRectMake(0, 5, 40, 40);
    [expandBtn setBackgroundColor:[UIColor clearColor]];
    [expandBtn setImage:[UIImage imageNamed:@"disclosure"] forState:UIControlStateNormal];
    [expandBtn addTarget:self.parentTable action:@selector(collapsableButtonTapped:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [expandBtn addTarget:self action:@selector(rotateExpandBtn:) forControlEvents:UIControlEventTouchUpInside];
    expandBtn.alpha = 0.45;
    
    offCheckBox = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"blueLedBigOff"]];
    onCheckBox = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"blueLedBig"]];
}

#pragma mark - behavior

-(void) rotateExpandBtn:(id)sender
{
    isExpanded = !isExpanded;
    switch (isExpanded) {
        case 0:
            [self rotateExpandBtnToCollapsed];
            break;
        case 1:
            [self rotateExpandBtnToExpanded];
            break;
        default:
            break;
    }
}

- (void)rotateExpandBtnToExpanded
{
    [UIView beginAnimations:@"rotateDisclosureButt" context:nil];
    [UIView setAnimationDuration:0.2];
    expandBtn.transform = CGAffineTransformMakeRotation(M_PI*2.5);
    [UIView commitAnimations];
}

- (void)rotateExpandBtnToCollapsed
{
    [UIView beginAnimations:@"rotateDisclosureButt" context:nil];
    [UIView setAnimationDuration:0.2];
    expandBtn.transform = CGAffineTransformMakeRotation(M_PI*2);
    [UIView commitAnimations];
}

- (SelectableCellState) toggleCheck
{
    SelectableCellState cellState = [super toggleCheck];
    if (self.selectableCellState == Checked)
    {
        expandBtn.alpha = 1.0;
    }
    else if (self.selectableCellState == Halfchecked)
    {
        expandBtn.alpha = 0.75;
    }
    else
    {
        expandBtn.alpha = 0.45;
    }
    return cellState;
}

- (void)check {
    [super check];
    expandBtn.alpha = 1.0;
}

- (void) uncheck {
    [super uncheck];
    expandBtn.alpha = 0.45;
}

- (void) halfCheck {
    [super halfCheck];
    expandBtn.alpha = 0.75;
}

- (void) subCellsToggleCheck
{
    
    if (self.selectableCellState == Checked)
    {
        //selectedSubCellsAmt = 0; // not necessary but safer, try to remove this if cells behave oddly on tap..
        subCellsCommand = AllSubCellsCommandChecked;
    }
    else
    {
        //selectedSubCellsAmt = subCellsAmt; // not necessary but safer, try to remove this if cells behave oddly on tap..
        subCellsCommand = AllSubCellsCommandUnchecked;
    }
    for (int i = 0; i < subCellsAmt; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self tableView:subTable didSelectRowAtIndexPath:indexPath];
    }
    subCellsCommand = AllSubCellsCommandNone;
}

- (void) tapTransition
{
    [super tapTransition];
}

#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return subCellsAmt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EFMSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCell"];
    
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"EFMSubCell" owner:self options:nil];
        cell = subCell;
        self.subCell = nil;
    }
    
    SelectableCellState cellState = [[selectableSubCellsState objectForKey:indexPath] intValue];
    switch (cellState)
    {
        case Checked:       [cell check];       break;
        case Unchecked:     [cell uncheck];     break;
        default:                                break;
    }
    
    cell = [self.parentTable item:self setSubItem:cell forRowAtIndexPath:indexPath];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return subCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EFMSubCell *cell = (EFMSubCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil)
    {
        cell = (EFMSubCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    [cell tapTransition];
    
    BOOL cellTapped;
    switch (subCellsCommand)
    {
        // case parent cell is tapped
        case AllSubCellsCommandChecked:
            cellTapped = NO;
            if (cell.selectableCellState == Unchecked)
            {
                [cell check];
                selectedSubCellsAmt++;
            }
            break;
        case AllSubCellsCommandUnchecked:
            cellTapped = NO;
            if (cell.selectableCellState == Checked)
            {
                [cell uncheck];
                selectedSubCellsAmt--;
            }
            break;
        
        // case specific cell is tapped
        default:
            cellTapped = YES;
            if ([cell toggleCheck])
            {
                selectedSubCellsAmt++;
                if (selectedSubCellsAmt == subCellsAmt && self.selectableCellState != Checked)
                {
                    [self check];
                    [self.parentTable mainItemDidChange:self forTap:cellTapped];
                }
                else if (selectedSubCellsAmt != subCellsAmt && selectedSubCellsAmt > 0 && self.selectableCellState != Halfchecked)
                {
                    [self halfCheck];
                    [self.parentTable mainItemDidChange:self forTap:cellTapped];
                }
            }
            else
            {
                selectedSubCellsAmt--;
                if (selectedSubCellsAmt == 0 && self.selectableCellState != Unchecked)
                {
                    [self uncheck];
                    [self.parentTable mainItemDidChange:self forTap:cellTapped];
                }
                else if (self.selectableCellState != Halfchecked)
                {
                    [self halfCheck];
                    [self.parentTable mainItemDidChange:self forTap:cellTapped];
                }
            }
            break;
    }
    [self.parentTable groupCell:self didSelectSubCell:cell withIndexPath:indexPath andWithTap:cellTapped];
}

@end
