 //Modal Animation
		var modal = document.getElementById('myModal');
		console.log(document.getElementById(modal));
		var addContactsBtn=document.getElementById('addContactsBtn');
		console.log(document.getElementById(addContactsBtn));
		var spans = document.getElementsByClassName("closed")[0];
	
	  	// addContactsBtn.onclick= function() {
	    //         console.log("clicked");
	    //         modal.style.display = "block";
	    //         // ("#addContact").modal.show();
	    // }
		 spans.onclick = function() {
			modal.style.display = "none";
		}
		window.onclick = function(event) {
		  if (event.target == modal) {
		      modal.style.display = "none";
		  }
		 }
