dataType: 'json',
    location: 'remote',
    url: '/getList',
    method: 'POST',
    recIndx: obj.colModel[0].dataIndx, //this gets the first column field/dataIndx
    //beforeSend: pqListbox.init,
    postData: function () {
        return {
            pq_curpage: pqListbox.requestPage,
            pq_rpp: pqListbox.rpp,
            pq_table: getTableName(Object.keys(this.colIndxs)[0]), //this gets the first column field/dataIndx
            pq_map: JSON.stringify(Object.keys(this.colIndxs)),
            pq_session: '',
            wapi_filter: JSON.stringify(wapi_filter.concat()), //wapi_filter,
            //wapi_form: $(':input').serializeArray(), // convert to javascript function document.querySelectorAll
            pq_form: wapiGetFormData(document.querySelector("form").id),
        };
    },
    //example based on virtual scrolling
    getData: function (response) {

        var data = response.data,
            totalRecords = response.totalRecords,
            len = data.length,
            curPage = response.curPage,
            pq_data = pqListbox.data,
            init = (curPage - 1) * pqListbox.rpp;

        if (!pqListbox.totalRecords) {
            //first time init the rows
            for (var i = len; i < totalRecords; i++) {
                pq_data[i + init] = {
                    pq_empty: true
                };
            }
            pqListbox.totalRecords = totalRecords;
        }
        for (var i = 0; i < len; i++) {
            pq_data[i + init] = data[i];
            pq_data[i + init].pq_empty = false;
        }

        return {
            data: pq_data
        }
    },
    error: function (jqXHR, textStatus, errorThrown) {
        //alert(errorThrown);
    },
