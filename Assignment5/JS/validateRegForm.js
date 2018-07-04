/*country dropdown */
$.getJSON("JSON/countries.json",function(data){
    console.log(data);
    $('#country').html('');
     var option;
     option='<option id="none">Select Country</option>';
    for(var i=0;i<data['country'].length;i++){
        console.log(data['country'][i]);
        option +='<option id="'+data['country'][i]['id']+'">'+data['country'][i]['name']+'</option>';
       
    }
    $('#country').html(option);
});
$.getJSON("JSON/states.json",function(data){
    console.log(data);
    $('#state').html('');
     var option;
     option='<option id="none">Select State</option>';
    for(var i=0;i<data['state'].length;i++){
        option +='<option id="'+data['state'][i]['id']+'">'+data['state'][i]['name']+'</option>';
       
    }
    $('#state').html(option);
});

 /*Captcha */
 function captcha(){
        let arr_operator=['+','-','/','*'];
        let leftOperand=Math.floor(Math.random()*Math.floor(100));
        let rightOperand=Math.floor(Math.random()*Math.floor(100));
        let operator = arr_operator[Math.floor(Math.random()*Math.floor(4))]; 
        console.log(leftOperand,rightOperand,operator);
        document.getElementById('leftOperand').innerHTML=leftOperand;
        while(operator == '/'){
        if(rightOperand == 0){
            operator = arr_operator[Math.floor(Math.random()*Math.floor(4))]; 
        }else if((leftOperand % rightOperand) != 0 ){
            operator = arr_operator[Math.floor(Math.random()*Math.floor(4))]; 
        }else{
            break;
        }
        }
        document.getElementById('rightOperand').innerHTML=rightOperand;
        document.getElementById('operator').innerHTML=operator;
        switch(operator){
            case '+':
                        result=leftOperand + rightOperand;
                        break;
                      
            case '-':
                        result=leftOperand + rightOperand;
                        break;
                        
            case '/':
                        result=leftOperand + rightOperand;
                        break;
                     
            case '*':
                        result=leftOperand + rightOperand;
                        break;
            default:
                        console.log("invalid operator");
        }
        console.log("result",result);
 }

 /*validate */
function validate() {
    var firstName = document.getElementById("firstName").value;
    var lastName = document.getElementById("lastName").value;
    // var gender = regForm.querySelectorAll('input[name="gender"]:checked');
    var genderMale=document.getElementById('genderMale').checked;
    var genderFemale=document.getElementById('genderFemale').checked;
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
    firstBlankField = true;
    // document.write("chekc");
    console.log(genderMale+" "+genderFemale);
   
    /*Regular expressions */
    var regexName=/^[A-Za-z]*$/;
    var regexPhoneNo=/\d{10}/;
    var regexEmail=/[\w.]+@+[a-z]+\.+com/;
    var regexPasskey=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;


    /*Validations */
    if (firstName == "") {
        displayErrors("showErrorfName", "firstName", 0, firstBlankField);
        flag = false;
    } else if (firstName.length <= 3) {
        displayErrors("showErrorfName", "firstName", 2, firstBlankField);
        flag = false;
    }else if(!regexName.test(firstName)){
        displayErrors("showErrorfName", "firstName", 1, firstBlankField);
        flag = false;
    }
    if (lastName == "") {
        displayErrors("showErrorlName", "lastName", 0, firstBlankField);
        flag = false;
    }else if (firstName.length <= 3) {
        displayErrors("showErrorlName", "lastName", 2, firstBlankField);
        flag = false;
    }else if(!regexName.test(lastName)){
        displayErrors("showErrorlName", "lastName", 1, firstBlankField);
        flag = false;
    }
    // if((genderMale == false ) && (genderFemale == false)) {
    //     displayErrors("showErrorGender", "gender", 0, firstBlankField);
    //     flag = false;
    // }
    if (phoneNo == "") {
        displayErrors("showErrorPhoneNo", "phoneNo", 0, firstBlankField);
         flag = false;
    }
    else if(!regexPhoneNo.test(phoneNo) ){
        displayErrors("showErrorPhoneNo", "phoneNo", 1, firstBlankField);
         flag = false;
    }

    if(altPhoneNo !="" && (!regexPhoneNo.test(altPhoneNo))){
        displayErrors("showErrorAltPhoneNo", "phoneNo", 1, firstBlankField);
        flag = false;
    }
    if (address == "") {
        displayErrors("showErrorAddress", "address", 0, firstBlankField);
         flag = false;
    }
    if (city == "") {
        displayErrors("showErrorCity", "city", 0, firstBlankField);
         flag = false;
    }
    if (state == "Select State") {
        displayErrors("showErrorState", "state", 0, firstBlankField);
         flag = false;
    }
    if (country == "Select Country") {
        displayErrors("showErrorCountry", "country", 0, firstBlankField);
         flag = false;
    }
    if (email == "") {
        displayErrors("showErrorEmail", "email", 0, firstBlankField);
         flag = false;
    }else if(!regexEmail.test(email)){
        displayErrors("showErrorEmail", "email", 1, firstBlankField);
         flag = false;
    }
    if (password == "") {
        console.log('if');
        displayErrors("showErrorPassword", "password", 0, firstBlankField);
         flag = false;
    }else if(!regexPasskey.test(password)){
        console.log('else if');
        displayErrors("showErrorPassword","password",1, firstBlankField);
        flag=false;
    }
    else{
        console.log('else');
        if (confrmPassword == "") {
            console.log('else1');
            displayErrors("showErrorCnfPassword", "confrmPassword", 0, firstBlankField);
            flag = false;
        }else if(password != confrmPassword){
            displayErrors("showErrorCnfPassword", "confrmPassword", 1, firstBlankField);
            flag = false;
        }
   }
   
    // if(answer != "" && flag == true)
    // {
    //       document.getElementById('answer').innerHTML="*Enter captcha";
    // }
    // else if( answer != result){
    //     document.getElementById('answer').innerHTML="*invalid captcha";
    // }

    if(flag == true)
    {
        alert("Registration done");
       
    }
    else{
        return flag;
    }
   
}

/*displayErrors will display the errors according to the 
typeOfError(a number) passed, fieldId is the field id whose 
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
        error: ["*Please enter the password","*Password must be minimum 8 characters with atleast one letter,one number and one special character"]
    },
    {
        id: "confrmPassword",
        error: ["*Please confirm the password", "*Passwords do not match"]
    },

    ]
    let i = 0;
    errors.forEach(item => {
        if (item.id == fieldId) {
            while (i < item.error.length) {
                if (typeOfError == i) {
                    document.getElementById(errorId).innerHTML = item.error[i];
                    if (firstBlankField) {
                        document.getElementById(fieldId).focus();
                    }

                }
                i = i + 1;
            }
        }

    });
}


/**gender
* captcha
*  Dynamic selection for country state city
*  UI
* optimised and clean code
*/