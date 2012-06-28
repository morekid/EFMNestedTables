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

Create a subclass of EFMNestedTables and implement the following convenience methods:

### Filling the views

#### mainTable:mainTable numberOfItemsInSection:section;
here you can set the amount of Items in your Main table

#### mainTable:mainTable numberOfSubItemsforItem:item atIndexPath:indexPath;
here you can set the amount of Sub Items for each Item in the Main table

#### mainTable:mainTable setItem:item forRowAtIndexPath:indexPath;
here you can set the Item's cell attributes

#### item:item setSubItem:subItem forRowAtIndexPath:indexPath;
here you can set the Sub Item's cell attributes

### Callbacks

#### mainTable:mainTable hasSetItem:item withIndexPath:indexPath toState:state;
this is called when the Item state changes, here you can manage behavior according to the Item state.

#### item:item hasSetSubItem:subItem withIndexPath:indexPath toState:state;
this is called when the Sub Item state changes, here you can manage behavior according to the Sub Item state.


