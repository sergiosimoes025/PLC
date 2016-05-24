$(document).ready(function() {

	$("#showBottom").on('click', function() {
    	classie.toggle( this, 'active' );
	    classie.toggle( document.getElementById( 'cbp-spmenu-s4' ), 'cbp-spmenu-open' );
	});

	$(".resetButton").click(function(ev) {
	  	ev.preventDefault();
		$.ajax({
		  url		: $(this).attr('href'),
		  success	: function(data) {
		  	$.growl.notice({ message: "Dados removidos com sucesso" });
		  }
		});
 	});

	$("#formFormulario").submit(function(ev) {
	  	ev.preventDefault();
	  	var formData = new FormData($(this)[0]);
	 
		$.ajax({
			headers : { "Accept": "application/json" },
			url		: $(this).attr("action"),
			method 	: 'POST',
			data 	: formData,
			cache	: false,
	        contentType: false,
	        processData: false,
			success	: function(a, b, c) {
				if(a.code != 200)
					$.growl.error({ message: a.message });
				else
					$.growl.notice({ message: a.message });
			}
		});

		return false;
	});

	$("#formXML").submit(function(ev) {
	  	ev.preventDefault();
	  	var formData = new FormData($(this)[0]);
	 
		$.ajax({
			headers : { "Accept": "application/json" },
			url		: $(this).attr("action"),
			method 	: 'POST',
			data 	: formData,
			cache	: false,
	        contentType: false,
	        processData: false,
			success	: function(a, b, c) {

				var msg = $.parseJSON(a);

				if(msg.code != 200)
					$.growl.error({ message: msg.message });
				else
					$.growl.notice({ message: msg.message });
			}
		});

		return false;
	});

});