function validateLoginForm(e) {
    var userValue = document.getElementById('username').value;
    var passValue = document.getElementById('pass').value;
    var postData = {
        username: userValue,
        pass: passValue
    };
    if (userValue.length === 0) {
        document.getElementById('UsernameError').innerText = "please enter a username";
        $("#UsernameError").removeClass("alert-success");
        $("#UsernameError").addClass("alert-danger");
    } else {
        $("#UsernameError").removeClass("alert-success");
        $("#UsernameError").removeClass("alert-danger");
        $.post("/login/data", postData)
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
                  console.log(data.OK)
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
    }
    // never return
    return false;
}
