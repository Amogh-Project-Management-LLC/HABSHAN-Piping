; (function ($, undefined) {
    var menu;
    var grid;
    var demo = window.demo = {};
 
    Sys.Application.add_load(function () {
        grid = $telerik.findControl(document, "RadGrid1");
		menu = $telerik.findControl(document, "ContextMenu1");
    });
 
    demo.ShowColumnHeaderMenu = function (event, columnName) {
 
        var columns = grid.get_masterTableView().get_columns();
        for (var i = 0; i < columns.length; i++) {
            if (columns[i].get_uniqueName() == columnName) {
                columns[i].showHeaderMenu(event, 75, 20);
            }
        }
    };
 
    demo.RowContextMenu = function (sender, eventArgs) {
        var evt = eventArgs.get_domEvent();
        if (evt.target.tagName == "INPUT" || evt.target.tagName == "A") {
            return;
        }
 
		var index = eventArgs.get_itemIndexHierarchical();
		var cellValue = (eventArgs.get_domEvent().target).innerHTML;


        document.getElementById("radGridClickedRowIndex").value = index;
		document.getElementById("radGridClickedCellIndex").value = cellValue;
		
        sender.get_masterTableView().selectItem(sender.get_masterTableView().get_dataItems()[index].get_element(), true);
 
        menu.show(evt);
        evt.cancelBubble = true;
        evt.returnValue = false;
 
        if (evt.stopPropagation) {
            evt.stopPropagation();
            evt.preventDefault();
        }
    };
})($telerik.$);