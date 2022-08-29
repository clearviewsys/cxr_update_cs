        var agg = pq.aggregate, 
            format = function(val){
                return pq.formatNumber(val, "$##.00");
            }

        //define custom aggregate "all" and now it can be used in any column.
        agg.all = function(arr, col){
            return 'total' //pq.grid("div#grid_infinite", obj);
        }