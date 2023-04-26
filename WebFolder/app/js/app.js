var mainDiv;

$(document).ready(function() {
    mainDiv = document.getElementById("main");
    // mainDiv.innerHTML = "Resources Loaded! <br />Checking ID...";
    // myInit();
});

function myInit() {
    if (localStorage.getItem("coin_base64") === null) {
        downloadCoin()
    } else {
        if (localStorage.getItem("coin_base64").length != 24782) {
            downloadCoin()
        }
    }
    if (localStorage.getItem("player.name") === null) {
        askForID()
    }
}



function login() {
    // mainDiv.innerHTML = "Submitting ID...";
    document.getElementById("loginForm").onsubmit = function(e) {

        e.preventDefault();

        var f = e.target,
            formData = new FormData(f),
            xhr = new XMLHttpRequest();

        xhr.open("POST", f.action);
        xhr.onload = function(e) {
            var data = JSON.parse(this.response);
            mainDiv.innerHTML = data;
            playCoinDropJS();
        }
        xhr.send(formData);
    }
}



function askForID() {
    mainDiv.innerHTML = "Please identify yourself:";

    var name = document.createElement("INPUT");
    name.placeholder = "Enter Name";
    name.id = "name";

    var submitBtn = document.createElement("BUTTON");
    submitBtn.setAttribute("type", "submit");
    submitBtn.onclick = submitID;
    submitBtn.innerText = "Submit";

    var loginForm = document.createElement("FORM");
    loginForm.action = '/login/data';
    loginForm.appendChild(name);
    loginForm.appendChild(submitBtn);

    mainDiv.appendChild(loginForm);
}

function submitID() {
    mainDiv.innerHTML = "Submitting ID...";
    document.getElementById("loginForm").onsubmit = function(e) {

        e.preventDefault();

        var f = e.target,
            formData = new FormData(f),
            xhr = new XMLHttpRequest();

        xhr.open("POST", f.action);
        xhr.onload = function(e) {
            var data = JSON.parse(this.response);
            mainDiv.innerHTML = data;
            playCoinDropJS();
        }
        xhr.send(formData);
    }
}

function getInfo() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/data/test.json');
    xhr.onload = function(e) {
        var data = JSON.parse(this.response);
        // ...
    }
    xhr.send();
    // 	playCoinDropJS();
}



function downloadCoin() {
    var coin = '/smw_coin.wav';
    var xhr = new XMLHttpRequest();
    xhr.open('GET', coin, true);
    xhr.responseType = 'blob';
    xhr.onload = function(e) {
        if (this.status == 200) {
            var blob = new Blob([this.response], {
                type: 'audio/wav'
            });
            var reader = new window.FileReader();
            reader.readAsDataURL(blob);
            reader.onloadend = function() {
                var coinB64 = reader.result;
                var myStorage = localStorage.setItem("coin_base64", coinB64)
            }
        }
    };
    xhr.send();
}

function playCoinDropJS() {
    var coinB64 = localStorage.getItem("coin_base64");
    var snd = new Audio(coinB64);
    snd.play();
}
