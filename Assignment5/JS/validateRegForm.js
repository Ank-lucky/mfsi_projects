var result;
var firstBlankField = true;

/*country dropdown */
$.getJSON("JSON/countries.json", function (data) {
    $('#country').html('');
    var option;
    option = '<option id="none">Select Country</option>';
    for (var i = 0; i < data['country'].length; i++) {
        option += '<option id="' + data['country'][i]['id'] + '">' +
            data['country'][i]['name'] + '</option>';
    }
    $('#country').html(option);
});


// /*state dropdown */
$.getJSON("JSON/states.json", function (data) {
    $('#state').html('');
    var option;
    option = '<option id="none">Select State</option>';
    for (var i = 0; i < data['state'].length; i++) {
        option += '<option id="' + data['state'][i]['id'] + '">' +
            data['state'][i]['name'] + '</option>';
    }
    $('#state').html(option);
});

/*Captcha */
function captcha() {
    let arr_operator = ['+', '-', '/', '*'];
    let leftOperand = Math.floor(Math.random() * Math.floor(100));
    let rightOperand = Math.floor(Math.random() * Math.floor(100));
    let operator = arr_operator[Math.floor(Math.random() * Math.floor(4))];
    

    while (operator == '/') {
        if (rightOperand == 0) {
            console.log(operator);
            operator = arr_operator[Math.floor(Math.random() * Math.floor(4))];
        } else if ((leftOperand % rightOperand) > 0) {
            console.log(operator);
            operator = arr_operator[Math.floor(Math.random() * Math.floor(4))];
        }else{
            break;
        }
    }
    document.getElementById('captchaExpression').innerHTML = leftOperand + '  ' + operator + '   ' + rightOperand + '=';
    switch (operator) {
        case "+":
            this.result = leftOperand + rightOperand;
            break;

        case "-":
            this.result = leftOperand - rightOperand;
            break;

        case "/":
            this.result = leftOperand / rightOperand;
            break;

        case "*":
            this.result = leftOperand * rightOperand;
            break;
        default:
            console.log("invalid operator");
    }
}

/*validate */
function validate() {
    console.log("validate");
    var firstName = document.getElementById("firstName").value;
    var lastName = document.getElementById("lastName").value;
    // var gender = regForm.querySelectorAll('input[name="gender"]:checked');
    var gender= document.getElementById("gender").value;
    var phoneNo = document.getElementById('phoneNo').value;
    var altPhoneNo = document.getElementById('altPhoneNo').value;
    var address = document.getElementById('address').value;
    var city = document.getElementById('city').value;
    var state = document.getElementById('state').value;
    var country = document.getElementById('country').value;
    var email = document.getElementById('email').value;
    var password = document.getElementById('password').value;
    var confrmPassword = document.getElementById('confrmPassword').value;
    var answer = document.getElementById('answer').value;
    flag = true;
    

    /*Regular expressions */
    var regexName = /^[A-Za-z]*$/;
    var regexPhoneNo = /^\d{10}$/g;
    var regexEmail = /[\w.]+@+[a-z]+\.+[com|net|in]/;
    var regexPasskey = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;


    /*Validations */
    if (firstName == "") {
        displayErrors("showErrorfName", "firstName", 0, this.firstBlankField);
        this.flag = false;
    } else if (firstName.length <= 3) {
        displayErrors("showErrorfName", "firstName", 2, this.firstBlankField);
        this.flag = false;
    } else if (!regexName.test(firstName)) {
        displayErrors("showErrorfName", "firstName", 1, this.firstBlankField);
        this.flag = false;
    }else{
        clearErrorDisplayed('showErrorfName');
    }
    

    if (lastName == "") {
        displayErrors("showErrorlName", "lastName", 0, this.firstBlankField);
        this.flag = false;
    } else if (lastName.length <= 3) {
        displayErrors("showErrorlName", "lastName", 2, this.firstBlankField);
        this.flag = false;
    } else if (!regexName.test(lastName)) {
        displayErrors("showErrorlName", "lastName", 1, this.firstBlankField);
        this.flag = false;
    }else{
      clearErrorDisplayed('showErrorlName');
    }
    if(gender === 'Select Gender')
    {
        displayErrors("showErrorGender", "gender", 0, this.firstBlankField);
        this.flag=false
    }
    if(gender != 'Select Gender'){
            clearErrorDisplayed('showErrorGender');
        }
    if (phoneNo == "") {
        displayErrors("showErrorPhoneNo", "phoneNo", 0, this.firstBlankField);
        this.flag = false;
    }
    else if (!regexPhoneNo.test(phoneNo)) {
        displayErrors("showErrorPhoneNo", "phoneNo", 1, this.firstBlankField);
        this.flag = false;
    }
    else{
        clearErrorDisplayed('showErrorPhoneNo');
    }

    if (altPhoneNo != "" && (!regexPhoneNo.test(altPhoneNo))) {
        displayErrors("showErrorAltPhoneNo", "phoneNo", 1, this.firstBlankField);
        this.flag = false;
    } 

    if (address == "") {
        displayErrors("showErrorAddress", "address", 0, this.firstBlankField);
        this.flag = false;
    } else{
        clearErrorDisplayed('showErrorAddress');
    }
    if (city == "") {
        displayErrors("showErrorCity", "city", 0, this.firstBlankField);
        this.flag = false;
    }else{
        clearErrorDisplayed('showErrorCity');
    }
    if (state == "Select State") {
        displayErrors("showErrorState", "state", 0, this.firstBlankField);
        this.flag = false;
    }else{
        clearErrorDisplayed('showErrorState');
    }
    if (country == "Select Country") {
        displayErrors("showErrorCountry", "country", 0, this.firstBlankField);
        this.flag = false;
    }else{
        clearErrorDisplayed('showErrorCountry');
    }
    if (email == "") {
        displayErrors("showErrorEmail", "email", 0, this.firstBlankField);
        this.flag = false;
    } else if (!regexEmail.test(email)) {
        displayErrors("showErrorEmail", "email", 1, this.firstBlankField);
        this.flag = false;
    }else{
        clearErrorDisplayed('showErrorEmail');
    }
    if (password == "") {
        displayErrors("showErrorPassword", "password", 0, this.firstBlankField);
        this.flag = false;
    } else if (!regexPasskey.test(password)) {
        displayErrors("showErrorPassword", "password", 1, this.firstBlankField);
        this.flag = false;
    }
    else {
        clearErrorDisplayed('showErrorPassword');
        if (confrmPassword == "") {

            displayErrors("showErrorCnfPassword", "confrmPassword", 0, this.firstBlankField);
           
            this.flag = false;
        } else if (password != confrmPassword) {
            displayErrors("showErrorCnfPassword", "confrmPassword", 1, this.firstBlankField);
            this.flag = false;
        }
        else{
            
            clearErrorDisplayed('showErrorCnfPassword');
        }
    }
    if (answer == "--" && this.flag == true) {
        alert("Enter captcha");
        this.flag = false;
    }
    else if (answer != "--" && answer != this.result) {
        alert("Enter captcha correctly");
        this.flag = false;
    }
    if (this.flag == true) {
        alert("Registration complete");
        this.flag = false;
    }
    return this.flag;
}

/*displayErrors will display the errors according to the 
typeOfError(a number) passed, fieldId is the id of the field whose 
error is detected and errorId is the id of the span where 
error is to be displayed */
function displayErrors(errorId, fieldId, typeOfError, firstBlankField) {
    errors = [{
        id: "firstName",
        error: ["* Enter First Name", "* Enter only letters", "* Enter first name more than 3 letters"]
    },
    {
        id: "lastName",
        error: ["* Enter Last Name", "* Enter only letters", "* Enter last name more than 3 letters"]
    },
    {
        id: "gender",
        error: ["* Select Gender"]
    },
    {
        id: "phoneNo",
        error: ["*Please enter Phone Number", "*Please enter 10 digits valid phone no."]
    },
    {
        id: "address",
        error: ["*Please enter your address"]
    },
    {
        id: "city",
        error: ["*Please enter city name", "*Please enter a valid city"]
    },
    {
        id: "state",
        error: ["*Please enter state name"]
    },
    {
        id: "country",
        error: ["*Please enter country name"]
    },
    {
        id: "email",
        error: ["*Please enter email", "*Invalid email"]
    },
    {
        id: "password",
        error: ["*Please enter the password", "*Password must be minimum 8 characters with atleast one letter,one number and one special character"]
    },
    {
        id: "confrmPassword",
        error: ["*Please confirm the password", "*Passwords do not match"]
    }
    ]

    let blankField = undefined;
    errors.forEach(item => {
        if (item.id == fieldId) {
            document.getElementById(errorId).innerHTML = item.error[typeOfError];
            if (firstBlankField) {
                blankField = document.getElementById(fieldId);
            }


        }
    });
    if (firstBlankField) {
        this.firstBlankField = false;
        blankField.focus();
    }
}
/*Function to clear  */
function clearErrorDisplayed(errorId){
    document.getElementById(errorId).innerHTML = "";
    this.firstBlankField=true;
}