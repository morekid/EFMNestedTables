//
//  NestedNavViewController.m
//  EFMNestedTablesExample
//
//  Created by Daniele De Matteis on 27/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NestedNavViewController.h"

@interface NestedNavViewController ()

@end

@implementation NestedNavViewController

- (id) init
{
    if (self = [super initWithNibName:@"EFMNestedTables" bundle:nil])
    {
    }
    return self;
}

- (NSInteger)mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (EFMGroupCell *)mainTable:(UITableView *)mainTable setCell:(EFMGroupCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.cellText.text = [NSString stringWithFormat:@"My Main Item %u", indexPath.row +1];
    
    return cell;
}

- (NSInteger)mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(EFMGroupCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    return 3; 
}

@end
