var serverURL = '/pages/register.aspx/CreateUser_Click';
//Initializing variables
var userName = '', name = '', email = '', password = '';


$(document).ready(function () {
    //Takes the password and password confirmation
    var password = document.getElementById("regPassword")
        , confirm_password = document.getElementById("regRePassword");

    //Function for verificate that the password is valid and shom masseage in case it not.
    function validatePassword() {
        if (password.value != confirm_password.value) {
            confirm_password.setCustomValidity("Passwords Don't Match");
        } else {
            confirm_password.setCustomValidity('');
        }
    }
    password.onchange = validatePassword;
    confirm_password.onkeyup = validatePassword;
});

function setData()
{
    var data = {
        'username': $('#regUsername').val, 'fullname': $('#regFullName'),
        'email': $('#regEmail').val, 'password': $('#regpassword')
    };
    return JSON.stringify(data);
}

