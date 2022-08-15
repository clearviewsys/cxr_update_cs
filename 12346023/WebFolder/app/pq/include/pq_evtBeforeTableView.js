           obj.beforeTableView = function (evt, ui) {

                var initV = ui.initV,
                    finalV = ui.finalV,
                    data = pqListbox.data,
                    rpp = pqListbox.rpp,
                    requestPage;

                if (initV != null) {


                    //if records to be displayed in viewport are not present in local cache,
                    //then fetch them from remote database/server.

                    if (data[initV] && data[initV].pq_empty) {
                        requestPage = Math.floor(initV / rpp) + 1;
                    }
                    else if (data[finalV] && data[finalV].pq_empty) {
                        requestPage = Math.floor(finalV / rpp) + 1;
                    }

                    if (requestPage >= 1) {
                        if (pqListbox.requestPage != requestPage) {
                                                    
                            pqListbox.requestPage = requestPage;

                            //initiate remote request.                    
                            this.refreshDataAndView();
                        }
                    }
                };
                
            };     