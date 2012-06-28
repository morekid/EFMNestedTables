EFMNestedTables
===============

Obj-C module built on UITableView for creating a 2-level nested list UI control.

![EFMNestedTables Screenshot 1 - iPhone Portrait](http://github.com/morekid/EFMNestedTables/raw/master/README/iPhone_P_shot1.png)&nbsp;&nbsp;
![EFMNestedTables Screenshot 2 - iPhone Portrait](http://github.com/morekid/EFMNestedTables/raw/master/README/iPhone_P_shot2.png)&nbsp;&nbsp;
![EFMNestedTables Screenshot 3 - iPhone Portrait](http://github.com/morekid/EFMNestedTables/raw/master/README/iPhone_P_shot3.png)&nbsp;&nbsp;
![EFMNestedTables Screenshot 4 - iPhone Portrait](http://github.com/morekid/EFMNestedTables/raw/master/README/iPhone_P_shot4.png)&nbsp;&nbsp;
![EFMNestedTables Screenshot 1 - iPad Landscape](http://github.com/morekid/EFMNestedTables/raw/master/README/iPad_L_shot1.png)


How To:
-------

Create a subclass of EFMNestedTables and use the following initialization code:

	- (id) init
	{
	    if (self = [super initWithNibName:@"EFMNestedTables" bundle:nil])
	    {
	        // do init stuff
	    }
	    return self;
	}

Then implement the following convenience methods:


### Filling the views


#### mainTable:mainTable numberOfItemsInSection:section;
here you can set the amount of Items in your Main table:

	- (NSInteger)mainTable:(UITableView *)mainTable numberOfItemsInSection:(NSInteger)section
	{
	    return 15; // amount of Items
	}
	

#### mainTable:mainTable numberOfSubItemsforItem:item atIndexPath:indexPath;
here you can set the amount of Sub Items for each Item in the Main table:

	- (NSInteger)mainTable:(UITableView *)mainTable numberOfSubItemsforItem:(EFMGroupCell *)item atIndexPath:(NSIndexPath *)indexPath
	{
	    return 3; // amount of Sub Items for given Item
	}


#### mainTable:mainTable setItem:item forRowAtIndexPath:indexPath;
here you can set the Item's cell attributes:

	- (EFMGroupCell *)mainTable:(UITableView *)mainTable setItem:(EFMGroupCell *)item forRowAtIndexPath:(NSIndexPath *)indexPath
	{
	    item.itemText.text = [NSString stringWithFormat:@"My Main Item %u", indexPath.row +1];
	    return item;
	}


#### item:item setSubItem:subItem forRowAtIndexPath:indexPath;
here you can set the Sub Item's cell attributes:

	- (EFMSubCell *)item:(EFMGroupCell *)item setSubItem:(EFMSubCell *)subItem forRowAtIndexPath:(NSIndexPath *)indexPath
	{
	    subItem.itemText.text = [NSString stringWithFormat:@"My Sub Item %u", indexPath.row +1];
	    return subItem;
	}


### Callbacks


#### mainTable:mainTable hasSetItem:item withIndexPath:indexPath toState:state;
this is called when the Item state changes, here you can manage behavior according to the Item state:

	- (void) mainTable:(UITableView *)mainTable hasSetItem:(EFMGroupCell *)item withIndexPath:(NSIndexPath *)indexPath toState:(SelectableCellState)state
	{
	    switch (state) {
	        case Checked:
	        	// do stuff
	            break;
	        case Unchecked:
	        	// do stuff
	            break;
	        case Halfchecked:
	        	// do stuff
	            break;
	        default:
	        	break;
	    }
	}


#### item:item hasSetSubItem:subItem withIndexPath:indexPath toState:state;
this is called when the Sub Item state changes, here you can manage behavior according to the Sub Item state:

	- (void) item:(EFMGroupCell *)item hasSetSubItem:(EFMSelectableCell *)subItem withIndexPath:(NSIndexPath *)indexPath toState:(SelectableCellState)state
	{
	    switch (state) {
	        case Checked:
	        	// do stuff
	        	break;
	        case Unchecked:
	        	// do stuff
	        	break;
	        default:
	        	break;
	    }
	}

