// get value from object based on key
function getKeyValue(obj, key) {
    if (obj.hasOwnProperty(key))
        return obj[key];
    return ''; //blank if not found
}

//WAPI GET TABLE NAME FROM TABLENAME___FIELDNAME
function wapi_getTableName(colName) {
    var pos = colName.indexOf("___");
    return colName.slice(0, pos);
}

//SET SESSION KEY/VALUE
function wapiSetSession(theKey, theValue) {

    if (theKey === undefined) {
        var theKey = ''
    };

    if (theValue === undefined) {
        var theValue = ''
    };

    $.post('setSession', {
        key: theKey,
        value: theValue,
    });

}

// WAPI VALIDATE PATTERN -- REGEX
function wapiValidatePattern() {
    debugger;

    theInput = event.target;

    var theValue = theInput.value;
    var thePattern = new RegExp(theInput.pattern);

    if (thePattern.test(theValue) == false) {

        var theHelpText = theInput.title;

        if (theHelpText == '') {
            theHelpText = 'The value does not meet the required pattern. ' + theInput.pattern
        }

        $('#' + theInput.id).closest('.form-group').addClass('has-error');
        $('#' + theInput.id + '-help-block').html('Error: ' + theHelpText);
        $('#' + theInput.id).one('keypress', function () {
            wapiClearHelpBlock();

        });
        $('#' + theInput.id).focus();
    } else {
        //$('#' + theInput.id).next().focus();
        wapiClearHelpBlock();
    }

}


// WAPI VALIDATE REQUIRED -- 
function wapiValidateRequired() {
    debugger;

    theInput = event.target;

    var theValue = theInput.value;

    if (theValue == '') {

        var theHelpText = '';

        if (theHelpText == '') {
            theHelpText = 'This field is required. '
        }

        $('#' + theInput.id).closest('.form-group').addClass('has-error');
        $('#' + theInput.id + '-help-block').html('Error: ' + theHelpText);
        $('#' + theInput.id).one('keypress', function () {
            wapiClearHelpBlock();

        });
        $('#' + theInput.id).focus();
    } else {
        wapiClearHelpBlock();
    }

}



//  WAPI ADDCOMMAS TO NUMBER --- https://www.hashbangcode.com/article/format-numbers-commas-javascript
function wapiAddCommas(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

// WAPI TIMER CODE -->
function wapiStartTimer() {
    var presentTime = document.getElementById('expiretimer').innerHTML;

    /*    switch (presentTime){
            case " ":
                presentTime = "05:00";
                break;
                
                case "":
                presentTime = "05:00";
                break;
                
                case "unlimited":
                presentTime = "99:00";
                break;
                
        };*/


    if (presentTime == " ") {
        presentTime = "05:00";
    } else {
        if (presentTime == "") {
            presentTime = "05:00";
        }
    };

    if (presentTime == "unlimited") {
        clearTimeout(timer);
    } else {

        var timeArray = presentTime.split(/[:]+/);
        var m = timeArray[0];
        var s = wapiCheckSecond((timeArray[1] - 1));

        if (s == 59) {
            m = m - 1
        }

        if (m < 0) {
            wapiObjectMethod('timer'); //refresh the form
            m = 1;
            s = 00;
            document.getElementById('expiretimer').innerHTML = "";
        } else {
            document.getElementById('expiretimer').innerHTML = m + ":" + s;
            if (timer === undefined) {
                var timer = setTimeout(wapiStartTimer, 1000);
            }
        }

    }
}

function wapiCheckSecond(sec) {
    if (sec < 10 && sec >= 0) {
        sec = "0" + sec
    }; // add zero in front of numbers < 10
    if (sec < 0) {
        sec = "59"
    };
    return sec;
}

// FORM DATA COLLECTION METHODS
function wapiGetFormData(theForm) {
    //debugger;

    if (typeof AutoNumeric === 'function') {
        if (AutoNumeric.isManagedByAutoNumeric('#wapi-autonumeric')) {
            var theElement = AutoNumeric.getAutoNumericElement('#wapi-autonumeric');
            if (theElement.form().getAttribute('id') == theForm) {
                var formData = theElement.formArrayNumericString();
            }
        };
    };

    if (formData === undefined) {
        var formData = $('#' + theForm).serializeArray();
    };

    return formData

}

function wapiSubmitFormData(theForm) {
    debugger;

    wapiShowProcessing(true);

    var deviceAgent = navigator.userAgent.toLowerCase();
    // add deviceAggent to theForm


    if (typeof AutoNumeric === 'function') {
        if (AutoNumeric.isManagedByAutoNumeric('#wapi-autonumeric')) {
            var theElement = AutoNumeric.getAutoNumericElement('#wapi-autonumeric');
            if (theElement.form().getAttribute('id') == theForm) {
                theElement.formUnformat();
            }
        };
    };

    if (typeof wapi_dropzone === 'undefined') {
        $('#' + theForm).append('<input id="userAgent" name="userAgent" type="text" value="' + navigator.userAgent.toLowerCase() + '" />');
        $('#' + theForm).submit();
    } else {

        if (wapi_dropzone.files.length === 0) {
            $('#' + theForm).append('<input id="userAgent" name="userAgent" type="text" value="' + navigator.userAgent.toLowerCase() + '" />');
            $('#' + theForm).submit();
        } else {
            // can i pass in a param to indicate post or xhr response needed
            // need to convert autoNumerics to format that can be processed
            wapi_dropzone.processQueue();
        }
    }

}

//wapiObjectMethod CODE -->
function wapiObjectMethod(event) {
    //debugger;

    var isOnLoad = false;

    if (event === undefined) {
        var theForm = $('form').attr('id');
        isOnLoad = true;
    } else if ((event.type == 'DOMContentLoaded') || (event.type == 'readystatechange')) {
        var theForm = $('form').attr('id');
        isOnLoad = true;
    } else {
        var theForm = this.event.target.closest('form').id;
    };

    var formData = wapiGetFormData(theForm);

    if ((event === undefined) || (isOnLoad == true)) {
        $.post('objectmethod', {
                form: theForm,
                evt: 'onload',
                source: 'onload',
                sourceType: 'onload',
                userInput: formData
            })
            .done(function (data) {
                eval(data); //execute the javascript sent back from 4D
            });
    } else if (event == 'timer') {
        $.post('objectmethod', {
                form: theForm,
                evt: 'expire',
                source: 'timer',
                sourceType: 'timer',
                userInput: formData
            })
            .done(function (data) {
                eval(data); //execute the javascript sent back from 4D
            });
    } else {
        $.post('objectmethod', {
                form: theForm,
                evt: event.type,
                source: event.target.id,
                sourceType: event.target.type,
                userInput: formData
            })
            .done(function (data) {
                eval(data); //execute the javascript sent back from 4D
            });
    };
}

// WAPI_DOCUMENTREADY CODE -- 
function wapiDocumentReady(theForm) {
    //debugger;

    if (theForm === undefined) {
        var theForm = $('form').attr('id')
    };

    var formData = wapiGetFormData(theForm);

    $.post('documentready', {
            form: $('#' + theForm).attr('id'),
            evt: 'ready',
            action: $('#' + theForm).attr('action'),
            userInput: formData
        })
        .done(function (data) {
            eval(data); //execute the javascript sent back from 4D
        });
}

//WAPI READ ONLY
function wapiSetFormReadOnly(theForm) {
    //debugger;

    if (theForm === undefined) {
        var theForm = $('form').attr('id')
    };

    $('#' + theForm + ' *').filter(':input').each(function () {

        var theId = this.id;

        switch ($(this).prop('type')) {

            case 'select-one':
                $(this).attr('disabled', true); // this makes the input not available to serialize
                //create a hidden input for this select 
                var parent = $(this).parent();
                var elementId = $(this).attr('id');
                var elementValue = $(this).val();
                var hiddenInput = $('<input/>', {
                    type: 'hidden',
                    id: elementId,
                    value: elementValue
                });
                hiddenInput.appendTo(parent);

                break;

            case 'checkbox':
                $(this).attr('disabled', true); // this makes the input not available to serialize
                //create a hidden input for this select 
                var parent = $(this).parent();
                var elementId = $(this).attr('id');
                var elementValue = $(this).val();
                var hiddenInput = $('<input/>', {
                    type: 'hidden',
                    id: elementId,
                    value: elementValue
                });
                hiddenInput.appendTo(parent);
                break;

            default:
                if ($(this).hasClass('picker__input')) { //date picker
                    $(this).attr('disabled', true);
                    $('.picker__holder').remove(); // removes all picker__holders
                } else {
                    $(this).prop('readonly', true);
                }
        };

        $('#wapi-dropzone-group').hide(); // dropzone - drop area - remove these
        $('.picker__input').css('background-color', '#ecf0f1'); // date picker areas


        //                var elementType = $(this).prop('nodeName');
        //
        //        if (elementType == 'SELECT') {
        //            $(this).attr('disabled', true); // this makes the input not available to serialize
        //            //create a hidden input for this select 
        //            var parent = $(this).parent();
        //            var elementId = $(this).attr('id');
        //            var elementValue = $(this).val();
        //            var hiddenInput = $('<input/>', {
        //                type: 'hidden',
        //                id: elementId,
        //                value: elementValue
        //            });
        //            hiddenInput.appendTo(parent);
        //
        //        } else {
        //            $(this).prop('readonly', true);
        //        } 

    });

}


// WAPI EXECUTE ON RECORD BUTTON
//https://stackoverflow.com/questions/133925/javascript-post-request-like-a-form-submit
//https://stackoverflow.com/questions/4666328/button-post-html
function wapiExecuteMethod(theMethod) {
    //debugger;

    if (theMethod !== undefined) {
        //var theTable = event.target.getAttribute("data-wapi-table")
        //var theRecord = event.target.getAttribute("data-wapi-record")

        let target = event.target;
        let formData = {};

        formData['evt'] = event.type;
        formData['source'] = target.id;
        formData['sourceType'] = target.type;
        formData['method'] = theMethod;

        for (let i = 0; i < target.getAttributeNames().length; i++) {
            formData[target.attributes[i].name.replace('data-wapi-', '')] = target.attributes[i].value;
        }

        $.post('executemethod', formData)
            .done(function (data) {
                if (data !== '') {
                    eval(data); //execute the javascript sent back from 4D
                }
            });
    }
}

// WAPI POSTHOOK METHOD AND OBJECT BACK TO 4D
function wapiPostHook(theMethod, theAction, theObject) {
    debugger;

    if (theMethod !== undefined) {
        //var theTable = event.target.getAttribute("data-wapi-table")
        //var theRecord = event.target.getAttribute("data-wapi-record")

        //let target = event.target;
        let formData = {};

        formData['result'] = JSON.stringify(theObject);
        formData['source'] = theMethod;
        formData['action'] = theAction;
        //formData['sourceType'] = target.type;
        //formData['method'] = theMethod;

        // for (let i = 0; i < Object.keys(theObject).length; i++) {
        //     formData[Object.keys(theObject)[i]] = Object.values(theObject)[i];
        //  }

        $.post('4DHOOK/' + theMethod, formData)
            .done(function (data) {
                if (data !== '') {
                    eval(data); //execute the javascript sent back from 4D
                }
            });
    }
}


// CONFIRM AND THEN EXECUTE A METHOD
function wapiConfirmExecuteMethod(theMethod) {
    //debugger;

    event.preventDefault();

    let target = event.target;
    let formData = {};

    formData['evt'] = event.type;
    formData['source'] = target.id;
    formData['sourceType'] = target.type;
    formData['method'] = theMethod;

    for (let i = 0; i < target.getAttributeNames().length; i++) {
        formData[target.attributes[i].name.replace('data-wapi-', '')] = target.attributes[i].value;
    }

    var theConfirm = target.getAttribute("data-wapi-confirm");

    if (theConfirm == '' || theConfirm == null) {
        theConfirm = target.value
    };

    $('#wapi-confirm-message').html(theConfirm);

    $('#wapi-confirm-dialog').modal({
            backdrop: 'static',
            keyboard: false
        })
        .on('click', '#wapi-ok-button', function () {
                if (theMethod !== undefined) {

                    $.post('executemethod', formData)
                        .done(function (data) {
                            if (data !== '') {
                                eval(data); //execute the javascript sent back from 4D
                            }
                        });
                }
            }

        );
}


//  WAPI VALIDATE ON SUBMIT - EXECUTE CODE TO EVAL MANDATORY FIELD AND OTHER VALIDATION
function wapiValidateOnSubmit() {
    //debugger;
    event.preventDefault();

    wapiShowProcessing(true);

    var theFormId = event.target.getAttribute("form"); //get form id for the button clicked if specified

    if (theFormId === 'undefined') {
        theFormId = $('form').attr('id');
    };

    var formData = wapiGetFormData(theFormId);

    // maybe custom javascript to look at inputs and a "rule" attribute

    $.post('validateForm', {
            form: theFormId,
            userInput: formData
        })
        .done(function (data) {

            if (data === '') {
                wapiSubmitFormData(theFormId);
            } else {
                wapiShowProcessing(false); // disable the processing indicator
                eval(data); //execute the javascript sent back from 4D  
            }

        });

}

//   WAPI CONFIRM DIALOG ON SUBMIT
// requires dialoag div /wapi/confirm.shtml included in page
function wapiConfirmOnSubmit(input) {
    event.preventDefault();
    // var $form = $(input).closest('form');

    var theFormId = event.target.getAttribute("form"); //get form id for the button clicked if specified

    if (theFormId === 'undefined') {
        theFormId = $('form').attr('id');
    };


    $('#wapi-confirm-dialog').modal({
            backdrop: 'static',
            keyboard: false
        })
        .on('click', '#wapi-ok-button', function () {
                wapiSubmitFormData(theFormId);
            }

        );

}

//WAPI CONFIRMATION -- OLD ?????
function wapiConfirmation(theInput) {
    //debugger;

    $('#' + theInput).on('click', function (e) {
        var $form = $(this).closest('form');

        e.preventDefault();
        $('#wapi-confirm').modal({
                backdrop: 'static',
                keyboard: false
            })
            .on('click', '#continue', function (e) {
                //$form.trigger('submit');
                wapiSubmitFormData($form.attr('id'));
            });
    });

}


//  WAPI ON SUBMIT - NO VALIDATION NO CONFIRMATION
function wapiOnSubmit() {
    event.preventDefault();

    var theFormId = event.target.getAttribute("form"); //get form id for the button clicked if specified

    if (theFormId === 'undefined') {
        theFormId = $('form').attr('id');
    };



    wapiSubmitFormData(theFormId);

    /*
        if (typeof wapi_dropzone === 'undefined') {
            $('form').submit();
        } else {

            if (wapi_dropzone.files.length === 0) {
                $('form').submit();
            } else {
                wapi_dropzone.processQueue();
            }
        }
        */

}


// WAPI REQUEST RECORD BUTTON
//https://stackoverflow.com/questions/133925/javascript-post-request-like-a-form-submit
//https://stackoverflow.com/questions/4666328/button-post-html
function wapiRequestRecord(theParameters) {
    //debugger;

    var theInput = event.target;

    var theForm = $('<form></form>');
    theForm.attr("method", "post");
    theForm.attr("action", "readRecord");


    for (const [key, value] of Object.entries(theParameters)) {

        if (key != 'form') {
            var field = $('<input></input>');
            field.attr("type", "hidden");
            if (key == 'update') {
                field.attr("name", 'request'); //change from update to request for component
            } else if (key == 'primarykey') {

                if (theInput.getAttribute(value) != null) {

                    var keyField = $('<input></input>');
                    keyField.attr('type', 'hidden');
                    keyField.attr('name', value);
                    keyField.attr('value', theInput.getAttribute(value));
                    theForm.append(keyField);
                };

                field.attr('name', key);

            } else {
                field.attr("name", key);
            };

            if (value != '') { // added check for empty values
                field.attr("value", value);
                theForm.append(field);
            }
        }
    };

    // The form needs to be a part of the document in
    // order for us to be able to submit it.
    $(document.body).append(theForm);
    theForm.submit();
}


// WAPI EDIT RECORD BUTTON
//https://stackoverflow.com/questions/133925/javascript-post-request-like-a-form-submit
//https://stackoverflow.com/questions/4666328/button-post-html
function wapiEditForm(theParameters) {
    //debugger;
    event.preventDefault();

    var theInput = event.target;

    var form = $('<form></form>');
    form.attr("method", "post");
    form.attr("action", "readRecord");

    // OLD METHOD
    if (theParameters !== undefined) {
        for (const [key, value] of Object.entries(theParameters)) {

            if (key != 'form') {
                var field = $('<input></input>');
                field.attr("type", "hidden");
                if (key == 'update') {
                    field.attr("name", 'request'); //change from update to request for component
                } else if (key == 'primarykey') {

                    var keyField = $('<input></input>');
                    keyField.attr('type', 'hidden');
                    keyField.attr('name', value);
                    keyField.attr('value', theInput.getAttribute(value));
                    form.append(keyField);

                    field.attr('name', key);

                } else {
                    field.attr("name", key);
                };

                if (value != '') { // added check for empty values
                    field.attr("value", value);
                    form.append(field);
                }
            }
        };
    };

    // NEW METHOD - USE DATA-WAPI-XXXXX ATTRIBUTES OF THE INPUT - 
    for (let i = 0; i < theInput.getAttributeNames().length; i++) {
        var field = $('<input></input>');
        field.attr("type", "hidden");

        var name = theInput.attributes[i].name.replace('data-wapi-', '');
        var value = theInput.attributes[i].value;

        if (name == 'record') { // need to change to the name of the primarykey
            name = theInput.attributes['data-wapi-primarykey'].value
        }

        field.attr("name", name);
        field.attr("value", value);
        form.append(field);
    };

    // The form needs to be a part of the document in
    // order for us to be able to submit it.
    $(document.body).append(form);
    form.submit();
}

// WAPI CREATE RECORD BUTTON
//https://stackoverflow.com/questions/133925/javascript-post-request-like-a-form-submit
function wapiCreateForm(theInputs) {
    debugger;

    var target = event.target;

    var form = $('<form></form>');
    form.attr("method", "post");
    form.attr("action", "postPage");

    // OLD METHOD
    if (theInputs !== undefined) {
        for (const [key, value] of Object.entries(theInputs)) {
            //console.log(key, value);
            var field = $('<input></input>');
            field.attr("type", "hidden");
            if (key == 'update') {
                field.attr("name", 'request');
            } else {
                field.attr("name", key);
            };
            field.attr("value", value);
            form.append(field);
        }
    };

    // NEW METHOD - USE DATA-WAPI-XXXXX ATTRIBUTES OF THE INPUT - 
    for (let i = 0; i < target.getAttributeNames().length; i++) {
        var field = $('<input></input>');
        field.attr("type", "hidden");

        var name = target.attributes[i].name.replace('data-wapi-', '');
        var value = target.attributes[i].value;

        if (name == 'record') { // need to change to the name of the primarykey
            name = target.attributes['data-wapi-primarykey'].value
        }

        field.attr("name", name);
        field.attr("value", value);
        form.append(field);
    };

    // The form needs to be a part of the document in
    // order for us to be able to submit it.
    $(document.body).append(form);
    form.submit();
}

//RETRIEVE DOCUMENT FOR SERVER AND DISPLAY IN A MODAL
function wapiViewDocument(thePicture, theIDField, thePathField, theMimeType) {

    var viewDocument = new FormData();

    //viewDocument.append('filepath', thePath);
    viewDocument.append('picture-id', thePicture);
    viewDocument.append('field-id', theIDField);
    viewDocument.append('field-path', thePathField);
    viewDocument.append('mime-type', theMimeType);
    viewDocument.append('width', 500);
    viewDocument.append('align', 'middle');
    viewDocument.append('form-post', 'viewdocument');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            $('#wapi-modal-body').html(request.responseText); //inject the response page into the dialog div
            $('#wapi-modal-title').html(thePicture);
            $('#wapi-modal').modal('show'); //bootstrap
        }
    };

    request.responseType = 'text';
    request.open('POST', 'viewdocument');
    request.send(viewDocument);
    request.response

}


//WAPI DISPLAY MODAL -- PQ GRID DOUBLE CLICK ONREADYSTATECHANGE EVENT
//function wapiDisplayModalDialog(theRequest, parameters) { //theForm, thePage) {    
function wapiDisplayModalDialog(theRequest, parameters) {
    return function () {

        //debugger;

        //the form id to submit values for
        var theForm = getKeyValue(parameters, 'form');
        if (theForm === '') {
            theForm = 'modal-form';
        };

        var thePrintPage = getKeyValue(parameters, 'print');
        if (thePrintPage === '') {
            thePrintPage = 'app/wapi/print.shtml';
        };

        var isReadOnly = getKeyValue(parameters, 'readonly');
        if (isReadOnly === '') {
            isReadOnly = true
        };


        if (theRequest.readyState == 4 && theRequest.status == 200) {
            $('#wapi-modal-dialog-body').html(theRequest.responseText); //inject the response page into the dialog div
            $('#wapi-modal-dialog').modal('show'); //bootstrap show the dialog

            $('#wapi-print-debug-btn').attr('onclick', "wapiPrintForm(true);");
            $('#wapi-print-debug-btn').attr('form', theForm);

            $('#wapi-print-btn').attr('onclick', "wapiPrintForm(false);");
            $('#wapi-print-btn').attr('form', theForm);

            parameters.success = document.URL;
            $('#wapi-edit-btn').attr('onclick', "wapiEditForm(" + JSON.stringify(parameters) + ");");
            $('#wapi-edit-btn').attr('form', theForm);

            if (isReadOnly = true) {
                //SINCE THIS IS MODAL MAKE SURE ALL INPUTS ARE READONLY
                //$('#modal-form :input').prop('disabled', true);
                $('#wapi-edit-btn').prop('disabled', false);
                $('#wapi-print-btn').prop('disabled', false);
                $('#wapi-print-debug-btn').prop('disabled', false);
                $('#wapi-cancel-btn').prop('disabled', false);
            };

        }
    };
}

//WAPI DISPLAY MESSAGE
function wapiDisplayMessage(theTitle, theMessage, theIcon) {
    if (theIcon === undefined) {
        theIcon = ''
    };
    $('#wapi-message-title').html(theTitle);
    $('#wapi-message-text').html(theMessage);
    $('#wapi-message-icon').addClass(theIcon);
    $('#wapi-message-dialog').modal({
        backdrop: 'static',
        keyboard: false
    })
}

function wapiPrintJSInputList(theDiv, theTitle) {

    var theData = $('#' + theDiv + ' :input').serializeArray();

    console.log(theData);

    printJS({
        printable: theData,
        properties: ['name', 'value'],
        type: 'json',
        header: theTitle,
        headerStyle: 'font-weight: bold; font-size: 24px; text-alignment: center;',
        style: 'font-family: verdana; font-size: 12px;',
        gridHeaderStyle: 'font-weight: bold; font-size: 12px;',
        gridStyle: 'border: 0px; margin-bottom: 5px; padding: 5px',

        //printable: 'dialog-ewires-body',
        //type: 'html',
        //css: '/css/wapi.css',
        // style: 'display: block !important; height: auto !important;',
    });
}

//WAPI PRINT FORM
//function wapiPrintForm(thePage, debug) {
function wapiPrintForm(debug) {
    //debugger;
    // get for vars and post to 4d - get parsed html 4d tags with form data
    // insert results in windo and print window

    var theForm = event.target.getAttribute("form"); //the form should be attibute of the "button"
    //the form id to submit values for
    if (theForm === undefined) {
        var theForm = $('form').attr('id')
    };

    //the page URL to use for the print output
    //    if (thePage === undefined) {
    //        var thePage = ''
    //    };

    if (debug === undefined) {
        var debug = false
    };

    var formData = wapiGetFormData(theForm);

    $.post('printRecord', {
            form: theForm,
            //page: thePage,
            evt: 'print',
            debug: debug,
            userInput: formData
        })
        .done(function (data) {

            if (data === '') { // nothing is sent back so ignore

            } else {
                var PW = window.open('', 'Printing', 'width=600,height=800'); //'_blank') //, 'Print Method');
                PW.document.write(data);

                if (debug === false) { // only auto print if not debug mode
                    setTimeout(function () {
                        PW.focus();
                        PW.print();
                        PW.close();
                    }, 3000);
                };
            }

        });



}


//WAPI CLEAR ERROR
function wapiClearHelpBlock() {
    // debugger;

    if (event.type !== 'change') {
        var theInput = this.event.target;

        var hasError = $('#' + theInput.id).closest('.form-group').hasClass('has-error');

        if (hasError) {
            $('#' + theInput.id).closest('.form-group').removeClass('has-error');
            $('#' + theInput.id + '-help-block').html('');
        }
    }

}


// DRAFT/BETA FUNCTIONS
//WAPI XHRONSUBMIT CODE --- MOVING THIS TO WAPI_XHRONACTION BELOW -->
function wapi_xhrOnSubmit(event, theType, theForm) {

    //add code to figure out closest form so we don't need to pass in form
    //var formData = $("#" + theForm).serializeArray();
    var formData = wapiGetFormData(theForm);
    // var formButtons = $("#"+theForm).find(':button');  //need to loop thru buttons and append to formData
    //var formData = formInput.concat(formButtons);

    // var formData = document.getElementById("#"+ theForm).elements;
    //var formData = Array.prototype.slice.call(document.getElementById(theForm).elements, 0)

    switch (theType) {

        case "update":
            $.post('wapi_xhrupdate', {
                    form: theForm,
                    evt: event.type,
                    source: event.target.id,
                    sourceType: event.target.type,
                    userInput: formData,
                    //formButton: formButtons
                })
                .done(function (data) {
                    eval(data); //execute the javascript sent back from 4D
                });

            break;

        case "create":
            break;

        case "delete":
            break;

    }

}

//WAPI XHRONACTION CODE -->
function wapi_xhronaction(event, theForm, theAccordian, doValidate) {

    if (theAccordian === undefined) {
        var theAccordian = '';
    }

    if (doValidate === undefined) {
        var doValidate = false;
    }

    var doPost = false; //init to not POST 

    //add code to figure out closest form so we don't need to pass in form
    //var theFormData = $("#" + theForm).serializeArray();
    var formData = wapiGetFormData(theForm);

    if (doValidate === true) {
        $.post('validateForm', {
                form: $('form').attr('id'),
                userInput: theFormData
            })
            .done(function (data) {
                if (data === '') { //nothing sent back - validation all good
                    doPost = true;
                } else {
                    eval(data); //execute the js sent back by validation
                }
            })
    } else {
        doPost = true; //no validation required so just post              
    };

    if (doPost === true) {

        if ((wapi_dropzone === undefined) || (wapi_dropzone.files.length === 0)) {
            $.post('wapi_xhraction', {
                    form: theForm,
                    evt: event.type, // clicked
                    source: event.target.id, // name of button
                    sourceType: event.target.type, // ie. button
                    userInput: theFormData,
                    accordian: theAccordian,
                })
                .done(function (data) {
                    eval(data); //execute the javascript sent back from 4D
                });
        } else {
            wapi_dropzone.on('sending', function (file, xhr, formData) {
                formData.append('form', theForm);
                formData.append('evt', event.type);
                formData.append('source', event.target.id);
                formData.append('sourceType', event.target.type);
                //formData.append('userInput', theFormData);
                formData.append('accordian', theAccordian);
            });
            wapi_dropzone.processQueue();
        }

    };
}


//WAPI PROCESSING BAR
function wapiShowProcessing(show) {

    if (show == true) {
        $('#spinner-overlay').show()
    } else {
        $('#spinner-overlay').hide()
    };
}


//WAPI DROPZONE ONERROR
function wapiDropzoneOnErr(files, response) {
    debugger;
    //stop default
    event.preventDefault();
    //alert('dropzone.js error');
    wapiDisplayMessage('Attachment Error', '')
    wapiShowProcessing(false);
}


function wapiShowHidePassword(theInput) {
    debugger;
    if (theInput == null) {
        var x = document.getElementById("login-password");
    } else {
        var x = document.getElementById(theInput);
    }


    if (x.type === "password") {
        x.type = "text";
        $("#show-hide-btn").attr('class', 'fa fa-eye-slash');
    } else {
        x.type = "password";
        $("#show-hide-btn").attr('class', 'fa fa-eye');
    }
}