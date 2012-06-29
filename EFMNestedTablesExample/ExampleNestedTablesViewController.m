//
//  ExampleNestedTablesViewController.m
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 27/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExampleNestedTablesViewController.h"

@interface ExampleNestedTablesViewController ()

@end

@implementation ExampleNestedTablesViewController

- (id) init
{
    if (self = [super initWithNibName:@"EFMNestedTable" bundle:nil])
    {
        // do init stuff
    }
    return self;
}

#pragma mark - Nested Tables methods

- (NSInteger)mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

- (NSInteger)mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(EFMGroupCell *)item atIndexPath:(NSIndexPath *)indexPath
{
    return 3; 
}

- (EFMGroupCell *)mainTable:(UITableView *)mainTable setItem:(EFMGroupCell *)item forRowAtIndexPath:(NSIndexPath *)indexPath
{
    item.itemText.text = [NSString stringWithFormat:@"My Main Item %u", indexPath.row +1];
    return item;
}

- (EFMSubCell *)item:(EFMGroupCell *)item setSubItem:(EFMSubCell *)subItem forRowAtIndexPath:(NSIndexPath *)indexPath
{
    subItem.itemText.text = [NSString stringWithFormat:@"My Sub Item %u", indexPath.row +1];
    return subItem;
}

- (void) mainTable:(UITableView *)mainTable itemDidChange:(EFMGroupCell *)item
{
    SelectableCellState state = item.selectableCellState;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:item];
    switch (state) {
        case Checked:
            NSLog(@"Changed Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
            NSLog(@"Changed Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        case Halfchecked:
            NSLog(@"Changed Item at indexPath:%@ to state \"Halfchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void) item:(EFMGroupCell *)item subItemDidChange:(EFMSelectableCell *)subItem
{
    SelectableCellState state = subItem.selectableCellState;
    NSIndexPath *indexPath = [item.subTable indexPathForCell:subItem];
    switch (state) {
        case Checked:
            NSLog(@"Changed Sub Item at indexPath:%@ to state \"Checked\"", indexPath);
            break;
        case Unchecked:
            NSLog(@"Changed Sub Item at indexPath:%@ to state \"Unchecked\"", indexPath);
            break;
        default:
            break;
    }
}

- (void)expandingItem:(EFMGroupCell *)item withIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Expanded Item at indexPath: %@", indexPath);
}

- (void)collapsingItem:(EFMGroupCell *)item withIndexPath:(NSIndexPath *)indexPath 
{
    NSLog(@"Collapsed Item at indexPath: %@", indexPath);
}

@end
