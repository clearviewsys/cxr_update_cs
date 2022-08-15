        function getTableName(colName) {
			var	pos = colName.indexOf("___");
			return colName.slice(0, pos);
        };