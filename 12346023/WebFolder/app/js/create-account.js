function validateFormInfo(e) {
    var p1 = document.getElementById('pass').value;
    var p2 = document.getElementById('passConf').value;
    var userValue = document.getElementById('username').value;
    var emailValue = document.getElementById('email').value;
    var fullnameV = document.getElementById('fullname').value;
    var errorCount = 0;
    if (p1 != p2) {
        errorCount++;
        $("#UsernameError").removeClass("alert-success");
        $("#UsernameError").addClass("alert-danger");
        document.getElementById('UsernameError').innerText = 'Password must match Confirmation';
    }
    if (p1.length < 6) {
        errorCount++;
        $("#UsernameError").removeClass("alert-success");
        $("#UsernameError").addClass("alert-danger");
        document.getElementById('UsernameError').innerText = 'Password must be atleast 6 characters long';
    }
    if (errorCount == 0) {
        var postData = {
          username  : userValue,
          fullname  : fullnameV,
          pass      : p1,
          passConf  : p2,
          email     : emailValue
        }
        $.post("/createAccount", postData)
            .done(function(data) {
                if (data.OK) {
                    // login OK
                    $("#UsernameError").addClass("alert-success");
                    $("#UsernameError").removeClass("alert-danger");
                    document.getElementById('UsernameError').innerText = 'login success; redirecting!';
                    if (data.hasOwnProperty('redirect')) {
                        // redirect to last tried location
                        window.location.href = data.redirect;
                    } else {
                        // redirect home
                        window.location.href = '/account';
                    }
                } else {
                    // login NOT OK
                    document.getElementById('UsernameError').innerText = data.errorStack;
                    $("#UsernameError").removeClass("alert-success");
                    $("#UsernameError").addClass("alert-danger");
                }
                return false;
            })
            .fail(function() {
                // alert( "error" );
                document.getElementById('UsernameError').innerText = 'an error occurred';
                $("#UsernameError").removeClass("alert-success");
                $("#UsernameError").addClass("alert-danger");
            })
            .always(function() {
                // alert( "complete" );
            });
        console.log(postData);
        return false;
    } else {
        return false;
    }
    // never submit
    return false;
}

function checkUsername() {
    var userValue = document.getElementById('username').value;
    if (userValue.length === 0) {
        document.getElementById('UsernameError').innerText = "please enter a username";
        $("#UsernameError").removeClass("alert-success");
        $("#UsernameError").addClass("alert-danger");
    } else {
        $.post("/checkUsername", {
                username: userValue
            })
            .done(function(response) {
                document.getElementById('UsernameError').innerText = response.text;
                if (response.available == false) {
                    // username is not available
                    $("#UsernameError").removeClass("alert-success");
                    $("#UsernameError").addClass("alert-danger");
                } else {
                    // username is available
                    $("#UsernameError").addClass("alert-success");
                    $("#UsernameError").removeClass("alert-danger");
                }
            })
            .fail(function() {
                // alert( "error" );
            })
            .always(function() {
                // alert( "complete" );
            });
    }
}
