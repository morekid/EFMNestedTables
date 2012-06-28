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
    if (self = [super initWithNibName:@"EFMNestedTables" bundle:nil])
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

- (void) mainTable:(UITableView *)mainTable hasSetItem:(EFMGroupCell *)item withIndexPath:(NSIndexPath *)indexPath toState:(SelectableCellState)state
{
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

- (void) item:(EFMGroupCell *)item hasSetSubItem:(EFMSelectableCell *)subItem withIndexPath:(NSIndexPath *)indexPath toState:(SelectableCellState)state
{
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

@end
