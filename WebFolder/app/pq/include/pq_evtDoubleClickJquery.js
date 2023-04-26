            obj.cellDblClick = function (evt, ui) {
            	$('#detailDialog').html(''); // clear any content
            	var loadURL = 'getInputForm'  //"/input/"+getTableName(Object.keys(this.colIndxs)[0])+".shtml";
            	var loadData = {field: Object.keys(this.colIndxs)[0], value: Object.values(this.SelectRow().getSelection()[0].rowData)[0]}; //{table:'address_book', id:'1234'};
            	$('#detailDialog').load(loadURL, loadData, function( response, status, xhr){
            		if (status === 'error'){
            			var msg = 'error occurred: ';
            			$('#detailDialog').html (msg + xhr.status+" "+xhr.statusText);
            			}
            	}).dialog({
            		modal: true, 
            		closeOnEscape: true, 
            		width: 600, 
            		resizeable: true,
            		position: {my: 'center', at: 'center top'},
            		});
            };