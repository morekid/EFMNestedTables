EFMNestedTables
===============

Obj-C module built on UITableView for creating a 2-level nested list UI control.


How To:
-------

Create a subclass of EFMNestedTables and implement its convenience methods:1

### mainTable:mainTable numberOfItemsInSection:section
here you can set the amount of Items in your Main table

### mainTable:mainTable numberOfSubItemsforItem:cell atIndexPath:indexPath;
here you can set the amount of Sub Items for each Item in the Main table

### mainTable:mainTable setCell:cell forRowAtIndexPath:indexPath
here you can set the Item's cell attributes

