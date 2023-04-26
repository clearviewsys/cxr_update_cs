			obj.toolbar= {
                cls: 'pq-toolbar',
				items:[
					

                    
                	
                	{
                    type: 'select',
                    label: 'Format ',                
                    attr: 'id="export_format"',
                    cls: 'btn-default',
                    options: [{ xlsx: 'Excel', csv: 'Csv', htm: 'Html', json: 'Json'}]
                	},
                
					{
                    type: 'button',
                    label: '<span class="glyphicon glyphicon-download"></span> Export',
                    cls: 'btn-default',
                    icon: 'ui-icon-arrowthickstop-1-s',
                    listener: function () {

						pqListbox.rpp=1000000;
                    	this.refreshDataAndView();
                    	
						this.one('load', function(){
							// var filename = Object.keys(this.colIndxs)[0];
// 							var	pos = filename.indexOf("___");
// 								filename = filename.slice(0, pos);
							
							var format = $("#export_format").val(),                            
								blob = this.exportData({
									//url: "/pro/demos/exportData",
									format: format,                                
									render: true
								});
							if(typeof blob === "string"){                            
								blob = new Blob([blob]);
							}
							saveAs(blob, getTableName(Object.keys(this.colIndxs)[0])+"."+ format );
							pqListbox.rpp=100;
							})
                    },
                },
                    
                    {
                        type: '<span>|</span>',                          
                    },
                    
                    {
                    type: 'button',
                    icon: '',
                    cls: 'btn-default',
                    style: '',
                    label: '<span class="glyphicon glyphicon-print"></span> Print',
                    listener: function () {
                    	pqListbox.rpp=1000000;
                    	this.refreshDataAndView();
                    	this.one('load', function(){
                    	var title = prompt('enter a title');
                        var exportHtml = this.exportData({ title: title, format: 'htm', render: true }),
                            newWin = window.open('', '', 'width=1200, height=700'),
                            doc = newWin.document.open();
                        doc.write(exportHtml);
                        doc.close();
                        newWin.print();
                        pqListbox.rpp=100;
                        })
                    }
                	},
                    
                    {
                        type: '<span>|</span>',                          
                    },
                    
                    {
						type:'button',
                        style: '',
						label: '<span class="glyphicon glyphicon-eye-open"></span> View',
                        cls: 'btn-default',
						listener: function(){
                                    var loadURL = 'getInputForm';
                                    var loadData = {field: Object.keys(this.colIndxs)[0], value: Object.values(this.SelectRow().getSelection()[0].rowData)[0]}; 
                
                                    $('.modal-container').load(loadURL, loadData, function( response, status, xhr){

                                    $('#detailRecord').modal({show:true,
                                                            keyboard:true,
                                                            backdrop: 'static',
                                                            }); 
                                    $('#detailRecord').modal('handleUpdate');
                                    });
						}
					},
                    
                    
                    {
						type:'button',
                        style: 'float: right',
						label: '<span class="glyphicon glyphicon-option-vertical"></span> Toggle',
                        cls: 'btn-default',
						listener: function(){
							this.option('filterModel.header', !this.option('filterModel.header'));
							this.refresh();
						}
					},
                    
                    {
						type:'button',
						label: '<span class="glyphicon glyphicon-refresh"></span> Reset',
                        cls: 'btn-default',
                        style: 'float: right',
						listener: function(){
							//pqListbox.rpp=100;
							pqListbox.init();		
							this.reset({filter: true});	
							this.refresh();
									
						}                        
                    },
                    

                    
                   // { type: 'button', label: 'View', listeners: [{ click: editRow}], icon: 'ui-icon-pencil' },
                    
				]
			};