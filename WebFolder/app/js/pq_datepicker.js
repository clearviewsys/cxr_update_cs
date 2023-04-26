
        
        function pqDatePicker(ui) {
            var $this = ui.$editor;
            $this.datepicker({
                    yearRange: "-20:+0", //20 years prior to present.
                    changeYear: true,
                    changeMonth: true,                    
                    onClose: function (evt, ui) {
                        $(this).focus();
                    }
                });
            //default From date
            $this.filter(".pq-from").datepicker("option", "defaultDate", new Date("01/01/1996"));
            //default To date
            $this.filter(".pq-to").datepicker("option", "defaultDate", new Date("12/31/1998"));
        }
        
