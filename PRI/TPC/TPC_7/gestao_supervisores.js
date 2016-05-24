$(document).ready(function(){
  var cont = 2;

  $("#adicionar_supervisor").click(function(){
  	if(cont>5)
  	{
  		alert("O limite máximo de elementos é 5");
  		return false;
  	}

		


var newSup = document.createElement("div");

	newSup.setAttribute("id","s" + cont);


//Input para o nome;
var new_LabelSup_name = document.createElement("label");
	new_LabelSup_name.setAttribute("for","supervisor"+cont);


var newLabelSupervisorName = document.createTextNode("Nome");
	new_LabelSup_name.appendChild(newLabelSupervisorName);

	
	var newInputSupervisorName = document.createElement("input");
	newInputSupervisorName.setAttribute("type","text");
	newInputSupervisorName.setAttribute("name","name_super"+"[]");
	newInputSupervisorName.setAttribute("id","supervisor"+cont);
	newInputSupervisorName.setAttribute("size","20");

	newSup.appendChild(new_LabelSup_name);
	newSup.appendChild(newInputSupervisorName);


	newSup.innerHTML += '&nbsp;';
	newSup.innerHTML += '&nbsp;';
	newSup.innerHTML += '&nbsp;';
	newSup.innerHTML += '&nbsp;';
	newSup.innerHTML += '&nbsp;';
	newSup.innerHTML += '&nbsp;';

//input para o email

var new_LabelSup_email = document.createElement("label");
 	new_LabelSup_email.setAttribute("for","supervisor"+cont);

 
 var new_LabelSup_email_text = document.createTextNode("Email");
 	new_LabelSup_email.appendChild(new_LabelSup_email_text);

 	var newInputSupervisorEmail = document.createElement("input");
	newInputSupervisorEmail.setAttribute("type","text");
	newInputSupervisorEmail.setAttribute("name","email_super"+"[]");
	newInputSupervisorEmail.setAttribute("id","supervisor"+cont);
	newInputSupervisorEmail.setAttribute("size","20");
	
	newSup.appendChild(new_LabelSup_email);
	newSup.appendChild(newInputSupervisorEmail);
	newSup.innerHTML += '<hr/>';
	$(newSup).appendTo("#supervisors");

	cont++;


});


$("#remover_supervisor").click(function(){

if(cont == 2){

	alert("Tem que existir pelo menos um supervisor!");
	return false;
}

			cont--;
        	$("#s"+cont).remove();

			});

});

