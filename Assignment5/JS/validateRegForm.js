function validate() {
    var firstName = document.getElementById('fname').value;
    var lastName = document.getElementById('lname').value;
    flag = true;
    if (firstName == "") {
        displayErrors("showError1", "fname", 0);
        flag = false;
    }
    if (lastName == "") {
        displayErrors("showError2", "lname", 0);
        flag = false;
    }
    if(gender.checked == ""){
        displayErrors("showError3", "gender", 0);
        flag = false;
    }
    return flag;
}

/*displayErrors will display the errors according to the typeOfError(a number) passed,
    fieldId is the field id whose error is detected and 
    errorId is the id of the span where error is to be displayed */
function displayErrors(errorId, fieldId, typeOfError) { 
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
    }
    ]
    console.log(errors);
    let i = 0;
    errors.forEach(item => {
        if (item.id == fieldId) {
            while (i < item.error.length) {
                if (typeOfError == i) {
                    document.getElementById(errorId).innerHTML = item.error[i];
                    document.getElementById(fieldId).focus();
                    document.getElementById(errorId).style.color = "red";
                    document.getElementById(errorId).style.fontSize = "30";
                }
                i = i + 1;
            }
        }

    });
} /*displayErrors() ends */


// function enterMoreFields(){
//     var hidden=document.getElementsByClassName("hidden");
//     var show= document.getElementsByClassName("show");
//     show.style.display="none";
//     hidden.style.display="block";
//     // for(var i=0;i < hidden.length;i++){
//     // hidden[i].style.display="block";
//     // }

// }
