
    
function viewRecord(evt, ui) {
        var loadURL = 'getInputForm';
        var loadData = {field: Object.keys(this.colIndxs)[0], value: Object.values(this.SelectRow().getSelection()[0].rowData)[0]}; 
                
        $('.modal-container').load(loadURL, loadData, function( response, status, xhr){

        $('#detailRecord').modal({show:true,
                                  keyboard:true,
                                 backdrop: 'static',
                                 }); 
        $('#detailRecord').modal('handleUpdate');
        });
};