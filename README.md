EFMNestedTables
===============

Obj-C module built on UITableView for creating a 2-level nested list UI control.

![Shot1](http://morekid.github.com/EFMNestedTables/README/iPhone_P_shot1.png)


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


