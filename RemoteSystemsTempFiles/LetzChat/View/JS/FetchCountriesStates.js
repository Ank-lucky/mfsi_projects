$('document').ready(()=>{

	/*fetch country list*/
	$.getJSON("View/JSON/countries.json",(data)=>{
		
		var  option = '<option id="none">Select Country</option>';
		$.each(data, function(i,value){
			option +='<option id="'+value.id+'">'+value.name+'</option>'
		})
		$('#country').html(option);
	});

	/*as per the selected country select state list*/
	$('#country').on('change',(e)=>{
		var stateOptions;
		var countryId= $('#country option:selected').attr('id');
		$.getJSON("View/JSON/states.json",(data)=>{
		    stateOptions = '<option id="none">Select State</option>';
			$.each(data, function(i,value){
				if(value.country_id == countryId)
				stateOptions +='<option id="'+value.id+'">'+value.name+'</option>'
			});

			$('#state').html(stateOptions);
		});
	});

	/*as per the selected state select city list*/
	$('#state').on('change',(e)=>{
		var cityOptions;
		var stateId= $('#state option:selected').attr('id');
		$.getJSON("View/JSON/cities.json",(data)=>{
		    cityOptions = '<option id="none">Select City</option>';
			$.each(data, function(i,value){
				if(value.state_id == stateId)
				cityOptions +='<option id="'+value.id+'">'+value.name+'</option>'
			});

			$('#city').html(cityOptions);
		});
	});

});


	