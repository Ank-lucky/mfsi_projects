validated = true; //global variable which becomes false if the form is not properly filled or validated
captchaResult = ''; // variable to store the result of the captcha generated
filled=[false,false,false,false,false,false,false,false,false,false,false,false,false]; /*array to check each field is filled properly or not*/


/*Generates captcha */
function captcha() {

    let arr_operator = ['+', '-', '/', '*'];
    let leftOperand = Math.floor(Math.random() * Math.floor(100));
    let rightOperand = Math.floor(Math.random() * Math.floor(100));
    let operator = arr_operator[Math.floor(Math.random() * Math.floor(4))];


    while (operator == '/') {
        if (rightOperand == 0) {
            operator = arr_operator[Math.floor(Math.random() * Math.floor(4))];
        } else if ((leftOperand % rightOperand) != 0) {
            operator = arr_operator[Math.floor(Math.random() * Math.floor(4))];
        } else {
            break;
        }
    }
     while (operator == '-'){
        if(leftOperand<rightOperand){
             leftOperand = Math.floor(Math.random() * Math.floor(100));
        }
        else{
            break;
        }
    }
    document.getElementById('captchaExpression').innerHTML = leftOperand + '  ' + operator + '   ' + rightOperand + '=';

    switch (operator) {
        case "+":
            this.captchaResult = leftOperand + rightOperand;
            break;

        case "-":
            this.captchaResult = leftOperand - rightOperand;
            break;

        case "/":
            this.captchaResult = leftOperand / rightOperand;
            break;

        case "*":
            this.captchaResult = leftOperand * rightOperand;
            break;
        default:
            console.log("invalid operator");
    }
    $('#answer').val("");

}
/*function to dynamically validate the input fields on focusout */
$(function () {
    captcha();
    $('#firstName').focusout(function () {
        validate('#firstName');
    });
    $('#lastName').focusout(() => {
        validate('#lastName');
    });
    $('.gender').focusout(() => {
        validate('.gender');
    })


    $('#phoneNo').focusout(() => {
        validate('#phoneNo');
    });

    $('#altPhoneNo').keyup(() => {
        validate('#altPhoneNo');
    });

    $('#address').focusout(() => {
        validate('#address');
    });
    $('#city').focusout(() => {
        validate('#city');
    });
    $('#state').focusout(() => {
        validate('#state');
    });
    $('#country').focusout(() => {
        validate('#country');
    });
    $('#email').focusout(() => {
        validate('#email');
    });
    $('#password').focusout(() => {
        validate('#password');
    })
    $('#answer').focusout(() => {
        validate('#answer');
    })
});

/*function which validates the required field passed as id or class */
function validate(inputField) {
    var regexName = /^[A-Za-z]*$/;
    var regexPhoneNo = /^\d{10}$/g;
    var regexAddress = /^\S*$/
    var regexEmail = /[\w.]+@+[a-z]+\.+[com|net|in]/;
    var regexPasskey = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;

    if (inputField === '#firstName') {
        var firstName = $('#firstName').val();
        let flag = isNotfilled('#firstName', firstName);
        this.filled[0]= !flag;
        if (flag) {
            focusField('#firstName');
        }
        if (!flag) {
            if (firstName.length <= 3) {
                $('#showErrorfName').html("* Enter first name more than 3 letters");
                // this.validated = false;
                this.filled[0]=false;
                focusField('#firstName');
            }
            else if (!regexName.test(firstName)) {
                $('#showErrorfName').html("* Enter only letters");
                // this.validated = false;
                this.filled[0]=false;
                focusField('#firstName');
            }
            else {
                $('#showErrorfName').html("");
                this.filled[0]=true;
            }
        }

    }

    if (inputField === '#lastName') {
        var lastName = $('#lastName').val();
        let flag = isNotfilled('#lastName', lastName);
        this.filled[1]= !flag;
        if (flag) {
            focusField('#lastName');
        }
        if (!flag) {

            if (lastName.length <= 3) {
                $('#showErrorlName').html("* Enter last name more than 3 letters");
                this.filled[1]=false;
                focusField('#lastName');
            }
            else if (!regexName.test(lastName)) {
                $('#showErrorlName').html("* Enter only letters");
                this.filled[1]=false;
                focusField('#lastName');
            }
            else {
                $('#showErrorlName').html("");
                this.filled[1]=true;
            }
        }

    }

    if (inputField === '.gender') {
        if (!$('input[name=gender]:checked').val()) {
            $('#showErrorGender').html("*Please enter gender");
            this.filled[2]= false;
            focusField('#genderMale');
        }
        else {
            $('#showErrorGender').html("");
            this.filled[2]=true;
        }
    }
    if (inputField === '#phoneNo') {
        var phoneNo = $('#phoneNo').val();
        let flag = isNotfilled('#phoneNo', phoneNo);
        this.filled[3]= !flag;
        if (flag) {
            focusField('#phoneNo');
        }
        if (!flag) {

            if (!regexPhoneNo.test(phoneNo)) {
                $('#showErrorPhoneNo').html("* Enter only valid 10 digit number");
                // this.validated = false;
                this.filled[3]=false;
                focusField('#phoneNo');
            }
            else {
                $('#showErrorPhoneNo').html("");
                this.filled[3]=true;
            }
        }
    }

    if (inputField === '#altPhoneNo') {
        var altphoneNo = $('#altPhoneNo').val();
        if (!regexPhoneNo.test(altphoneNo) && altphoneNo != "") {
            $('#showErrorAltPhoneNo').html("* Enter only valid 10 digit number");
            this.filled[4]= false;
            focusField('#altPhoneNo');
        }
        else {
            $('#showErrorAltPhoneNo').html("");
            this.filled[4]=true;
        }
    }
    if (inputField === '#address') {
        var address = $('#address').val();
        let flag = isNotfilled('#address', address);
        this.filled[5] = !flag;
        if (flag) {
            focusField('#address');
        }
        if (!flag) {
            if(!regexAddress.test(address)){
                $('#showErrorAddress').html("*Enter your address correctly");
                 this.filled[5]=false;
            }
            else{
            $('#showErrorAddress').html("");
            this.filled[5]=true;
            }
        }

    }

    if (inputField === '#city') {
        var city = $('#city').val();

        let flag = isNotfilled('#city', city);
        this.filled[6] = !flag;
        if (flag) {
            focusField('#city');
        }

        if (!flag) {
            $('#showErrorCity').html("");
            this.filled[6]=true;
        }
    }

    if (inputField === '#state') {
        var state = $('#state').val();

        let flag = isNotfilled('#state', state);
        this.filled[7] = !flag;
        if (flag) {
            focusField('#state');
        }
        if (!flag) {
            $('#showErrorState').html("");
            this.filled[7]=true;
        }
    }
    if (inputField === '#country') {
        var country = $('#country').val();

        let flag = isNotfilled('#country', country);
        this.filled[8]= !flag;
        if (flag) {
            focusField('#country');
        }
        if (!flag) {
            $('#showErrorCountry').html("");
            this.filled[8]=true;
        }
    }
    if (inputField === '#email') {
        var email = $('#email').val();
        let flag = isNotfilled('#email', email);
        this.filled[9] = !flag;
        if (flag) {
            focusField('#email');
        }
        if (!flag) {

            if (!regexEmail.test(email)) {
                $('#showErrorEmail').html("* Enter valid email ex you@example.com");
                this.filled[9] = false;
                focusField('#email');
            }
            else {
                $('#showErrorEmail').html("");
                this.filled[10]=true;
            }
        }
    }
    if (inputField === '#password') {
        var password = $('#password').val();
        let flag = isNotfilled('#password', password);
        this.filled[10]= !flag;
        if (flag) {
            focusField('#password');
        }
        if (!flag) {
            if (!regexPasskey.test(password)) {
                $('#showErrorPassword').html("*Password must be minimum 8 characters with atleast one letter,one number and one special character");
                this.filled[10] = false;
                focusField('#password');
            }
            else {
                $('#showErrorPassword').html("");
                this.filled[10]=true;
                focusField('#confrmPassword');

                $('#confrmPassword').focusout(() => {

                    var confrmPassword = $('#confrmPassword').val();
                    let flag = isNotfilled('#confrmPassword', confrmPassword);
                    this.filled[11] = !flag;
                    if (flag) {
                        focusField('#confrmPassword');
                    }
                    if (!flag) {
                        if (!regexPasskey.test(confrmPassword)) {
                            $('#showErrorCnfPassword').html("*Password must be minimum 8 characters with atleast one letter,one number and one special character");
                            this.filled[11]= false;
                            focusField('#confrmPassword');
                        }
                        else {
                            $('#showErrorCnfPassword').html("");
                            this.filled[11]=true;
                        }
                    }
                })
            }
        }
    }

    if (inputField === '#answer') {
        var answer = $('#answer').val();
        var flag = isNotfilled('#answer', answer);
        this.filled[12] = !flag;
        if (flag) {
            focusField('#answer');
        }
        if (!flag) {
            if (this.captchaResult != answer) {
                $('#showErrorCaptcha').html("*Enter Captcha Correctly");
                focusField('#answer');
                this.filled[12]= false;
            }
            else{
                 $('#showErrorCaptcha').html("");
                 this.filled[12]=true;
            }
        }
    }
}

/*function which checks if any field is not filled */
function isNotfilled(fieldId, fieldValue) {
    if (fieldValue == "" || fieldValue == 'Select State' || fieldValue == 'Select Country' || fieldValue == 'Select City') {
        switch (fieldId) {
            case '#firstName': $('#showErrorfName').html("*Please Enter First Name.");
                return true;
            case '#lastName': $('#showErrorlName').html("*Please Enter Last Name.");
                return true;
            case '#phoneNo': $('#showErrorPhoneNo').html("*Please Enter Contact No");
                return true;
            case '#address': $('#showErrorAddress').html("*Please fill your address");
                return true;
            case '#city': $('#showErrorCity').html("*Please enter your city");
                return true;
            case '#state': $('#showErrorState').html("*Please select your state");
                return true;
            case '#country': $('#showErrorCountry').html("*Please select your country");
                return true;
            case '#email': $('#showErrorEmail').html("*Please enter email");
                return true;
            case '#password': $('#showErrorPassword').html("*Please enter password");
                return true;
            case '#confrmPassword': $('#showErrorCnfPassword').html("*Please confirm password");
                return true;
            case '#answer': $('#showErrorCaptcha').html("*Enter Captcha");
                focusField('#answer');
                return true;
            default: return false;

        }
    }
}
/*Function to focus */
function focusField(fieldId) {
    $(fieldId).focus();

}

/*function which gets called when submitted */
function validateForm() {
    this.validated=true;
    validate('#firstName');
    validate('#lastName');
    validate('#phoneNo');
    validate('.gender');
    validate('#altPhoneNo');
    validate('#address');
    validate('#city');
    validate('#state');
    validate('#country');
    validate('#email');
    validate('#password');
    validate('#answer');

    for(var i=0;i<filled.length;i++){
        if(filled[i]==false){
            this.validated=false;
            break;
        }
    }
     if(this.validated){
        alert("Registration Complete");
        this.validated =false /*This is just used to stay on same page even after the registration is complete and 
                                 should be true in real when an action is defined for the form submission */
    }

    return this.validated;
}
