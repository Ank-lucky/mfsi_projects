function validate() {
    console.log("in validate");
    var firstName = document.getElementById('fname').value;
    var lastName = document.getElementById('lname').value;
    flag = true;
    firstBlankField=true;
    if (firstName == "") {
        displayErrors("showError1", "fname", 0,firstBlankField);
        flag = false;
    }
    if (lastName == "") {
        displayErrors("showError2", "lname", 0,firstBlankField);
        flag = false;
    }
    return flag;
}

/*displayErrors will display the errors according to the typeOfError(a number) passed,
    fieldId is the field id whose error is detected and 
    errorId is the id of the span where error is to be displayed */
function displayErrors(errorId, fieldId, typeOfError,firstBlankField) { 
    console.log("indisplayError");
    errors = [{
        id: "fname",
        error: ["* Enter First Name", "* Enter only letters", "* Enter first name more than 3 letters"]
    },
    {
        id: "lname",
        error: ["* Enter Last Name", "* Enter only letters", "* Enter last name more than 3 letters"]
    },
    {
        id: "gender",
        error: ["* Select Gender"]
    },
    {
        id:"phoneNo",
        error:["*Please enter Phone Number","*Please enter 10 digits valid phone no."]
    },
    {
        id:"altPhoneNo",
        error:["*Please enter 10 digits valid phone no."]
    },
    {
        id:"address",
        error:["*Please enter your address"]
    },
    {
        id:"city",
        error:["*Please enter city name","*Please enter a valid city"]
    },
    {
        id:"state",
        error:["*Please enter state name", "*Please enter a valid State"]
    },
    {
        id:"Country",
        error:["*Please enter country name","*Please enter a valid country"]
    },
    {
        id:"email",
        error:["*Please enter email address","Please enter a valid email"]
    },
    {
        id:"password",
        error:["*Please enter password","Please enter a valid password "]
    },
    {
        id:"confirmPassword",
        error:["*Please confirm the password","*Passwords do not match"]
    },

    ]
    let i = 0;
    errors.forEach(item => {
        if (item.id == fieldId) {
            while (i < item.error.length) {
                if (typeOfError == i) {
                    document.getElementById(errorId).innerHTML = item.error[i];
                        if(firstBlankField){
                            document.getElementById(fieldId).focus();
                        }
                    document.getElementById(errorId).style.color = "red";
                    document.getElementById(errorId).style.fontsize = "2%";
                    // document.getElementById(errorId).style.;
                    
                }
                i = i + 1;
            }
        }

    });
}
