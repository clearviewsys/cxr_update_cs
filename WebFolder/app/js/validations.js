$( document ).ready(function() {

    $('#webEmail').on('keyup change',

        function() {

            var	state = false,
				$group = $(this).closest('.input-group'),
				$addon = $group.find('.input-group-addon'),
				$icon = $addon.find('span');
				
            //console.log($(this).val());
			
	
            state = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test($(this).val());


            if (state) {
                $addon.removeClass('danger');
                $addon.addClass('success');
                $icon.attr('class', 'glyphicon glyphicon-ok');
				//$("input[type=submit]").attr("disabled", "disabled");

				
            }else{
                $addon.removeClass('success');
                $addon.addClass('danger');
                $icon.attr('class', 'glyphicon glyphicon-remove');
				//$("input[type=submit]").removeAttr("disabled");
            }


        }
    )

});
