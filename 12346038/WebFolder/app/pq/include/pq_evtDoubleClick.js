            obj.cellDblClick = function (evt, ui) {
                
               // viewRecord();
                
            	//$('#detailDialog').html(''); // clear any content
            	var loadURL = 'getInputForm'  //"/input/"+getTableName(Object.keys(this.colIndxs)[0])+".shtml";
            	var loadData = {field: Object.keys(this.colIndxs)[0], value: Object.values(this.SelectRow().getSelection()[0].rowData)[0]}; 
                
            	$('.modal-container').load(loadURL, loadData, function( response, status, xhr){
//            		if (status === 'error'){
//            			var msg = 'error occurred: ';
//            			$('#detailDialog').html (msg + xhr.status+" "+xhr.statusText);
//            			}
                    $('#detailRecord').modal({show:true,
                                              keyboard:true,
                                             backdrop: 'static',
                                             }); 
                    $('#detailRecord').data('bs.modal').handleUpdate();
                });

            };