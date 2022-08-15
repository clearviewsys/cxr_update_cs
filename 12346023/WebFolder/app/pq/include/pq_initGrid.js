   		 var pqListbox = {
            rpp: 100, //records per request.            
            init: function () {
            	this.totalRecords = 0;
                this.data = [];
                this.requestPage = 1;
            }
        };
        pqListbox.init();