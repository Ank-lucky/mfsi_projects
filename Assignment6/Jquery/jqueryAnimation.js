
  flag=true;
  registerHereClicked=true;
   var changeColor= changeColorwithTime(flag);
   function changeColorwithTime(flag){
        setInterval(function(){ 
        if(flag){
            flag=false;
        $("#menu").css({"color":"green","font-size":"30px"});}
        else{
            flag=true;
        $("#menu").css({"color":"red","font-size":"25px"});}
        }
        , 3000);

}

function focusForm(){
    if(registerHereClicked){
    $(".Firstsection").css("background","#deb88733");
    registerHereClicked=false;
    }
    else{
        $(".Firstsection").css("background","none");
        registerHereClicked=true;
    }
}