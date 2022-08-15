function validateRegistration(emailId, otherID, phoneID, submitID) {

    debugger;

    var $isValid = false,
        $isEqual = false,
        $isValidPhone = false,

        $emailGroup = $(emailId).closest('.input-group'),
        $emailAddon = $emailGroup.find('.input-group-addon'),
        $emailIcon = $emailAddon.find('span'),

        $otherGroup = $(otherID).closest('.input-group'),
        $otherAddon = $otherGroup.find('.input-group-addon'),
        $otherIcon = $otherAddon.find('span'),

        $phoneGroup = $(phoneID).closest('.input-group'),
        $phoneAddon = $phoneGroup.find('.input-group-addon'),
        $phoneIcon = $phoneGroup.find('span');



    $isValid = validateEmail(emailId);
    //$isValid = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test($(emailId).val());

    $isEqual = validateEmails(emailId, otherID);
    //$isEqual = $(emailId).val() == $(otherID).val();

    //$isValidPhone = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/.test($(phoneID).val());
    // new zealand has different length numbers so can't use generic regex
    var $phone = $(phoneID).val().replace(/[\(\)\s\-]/g, '');
    $isValidPhone = $phone.length > 6 && $phone.length < 13;


    if ($isValid) {
        $emailAddon.removeClass('danger');
        $emailAddon.addClass('success');
        $emailIcon.attr('class', 'glyphicon glyphicon-ok');
    } else {
        $emailAddon.removeClass('success');
        $emailAddon.addClass('danger');
        $emailIcon.attr('class', 'glyphicon glyphicon-remove');
    };


    if ($isEqual) {
        $otherAddon.removeClass('danger');
        $otherAddon.addClass('success');
        $otherIcon.attr('class', 'glyphicon glyphicon-ok');
        $(otherID + '-help-block').html('');
    } else {
        $otherAddon.removeClass('success');
        $otherAddon.addClass('danger');
        $otherIcon.attr('class', 'glyphicon glyphicon-remove');
        $(otherID + '-help-block').html('Email addresses do NOT match.');
    };


    if ($isValidPhone) {
        $phoneAddon.removeClass('danger');
        $phoneAddon.addClass('success');
        //$phoneIcon.attr('class', 'glyphicon glyphicon-ok');
    } else {
        $phoneAddon.removeClass('success');
        $phoneAddon.addClass('danger');
        //$phoneIcon.attr('class', 'glyphicon glyphicon-remove');
    };


    if ($isValid && $isEqual && $isValidPhone) {
        $(submitID).prop('disabled', false);
    } else {
        $(submitID).prop('disabled', true);
    };



    /*

        if ($isValid && $isEqual && $isValidPhone) {
            $emailAddon.removeClass('danger');
            $emailAddon.addClass('success');
            $emailIcon.attr('class', 'glyphicon glyphicon-ok');

            $otherAddon.removeClass('danger');
            $otherAddon.addClass('success');
            $otherIcon.attr('class', 'glyphicon glyphicon-ok');

            $(otherID + '-help-block').html('');

            $phoneAddon.removeClass('danger');
            $phoneAddon.addClass('success');
            $phoneIcon.attr('class', 'glyphicon glyphicon-ok');

            $(submitID).prop('disabled', false);

        } else if ($isValid) {

            $emailAddon.removeClass('danger');
            $emailAddon.addClass('success');
            $emailIcon.attr('class', 'glyphicon glyphicon-ok');

            $otherAddon.removeClass('success');
            $otherAddon.addClass('danger');
            $otherIcon.attr('class', 'glyphicon glyphicon-remove');
            $(otherID + '-help-block').html('Email addresses do NOT match.');

            $(submitID).prop('disabled', true);

        } else {
            $emailAddon.removeClass('success');
            $emailAddon.addClass('danger');
            $emailIcon.attr('class', 'glyphicon glyphicon-remove');

            $otherAddon.removeClass('success');
            $otherAddon.addClass('danger');
            $otherIcon.attr('class', 'glyphicon glyphicon-remove');

            $(otherID + '-help-block').html('');

            $(submitID).prop('disabled', true);
        }

    */


    //return $isValid;
}


function validateEmail(emailId) {

    var $isValid = false,

        $isValid = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test($(emailId).val());

    return $isValid

}

function validateEmails(emailId, otherID) {

    var $isEqual = false;

    if ($(emailId).val() == '') {
        $isEqual = false
    } else {
        $isEqual = $(emailId).val() == $(otherID).val()
    };

    return $isEqual

}
