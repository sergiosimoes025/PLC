$(document).ready(function(){
  var cont = 2;

  $("#adicionar_equipa_trabalho").click(function(){
  	if(cont>5)
  	{
  		alert("O limite máximo de elementos é 5");
  		return false;
  	}

var newWorker = document.createElement("div");

	newWorker.setAttribute("id",'w' + cont);


var space = document.createTextNode('&nbsp;');

var new_LabelWorker_name = document.createElement("label");
	new_LabelWorker_name.setAttribute("for","worker"+cont);


var newLabelWorkerName = document.createTextNode("Nome ");
	new_LabelWorker_name.appendChild(newLabelWorkerName);

	/*input para o nome*/
	var newInputWorkerName = document.createElement("input");
	newInputWorkerName.setAttribute("type","text");
	newInputWorkerName.setAttribute("name","worker_name"+"[]");
	newInputWorkerName.setAttribute("id","worker"+cont);
	newInputWorkerName.setAttribute("size","20");

	new_LabelWorker_name.appendChild(newLabelWorkerName);
	newWorker.appendChild(new_LabelWorker_name);
	newWorker.appendChild(newInputWorkerName);
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';

	/**** ID ***/
	var new_LabelWorker_id = document.createElement("label");
	new_LabelWorker_id.setAttribute("for","worker"+cont);

	var newLabelWorkerID = document.createTextNode("Id ");
	new_LabelWorker_id.appendChild(newLabelWorkerID);

	
	var newInputWorkerID = document.createElement("input");
	newInputWorkerID.setAttribute("type","text");
	newInputWorkerID.setAttribute("name","worker_id"+"[]");
	newInputWorkerID.setAttribute("id","worker"+cont);
	newInputWorkerID.setAttribute("size","20");
	

	newWorker.appendChild(new_LabelWorker_id);
	newWorker.appendChild(newInputWorkerID);

	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	newWorker.innerHTML += '&nbsp;';
	/*** EMAIL ***/

	var newLabelWorker_email = document.createElement("label");
	newLabelWorker_email.setAttribute("for","worker"+cont);
	
	
	var newLabelWorkerEmail = document.createTextNode("Email");
	newLabelWorker_email.appendChild(newLabelWorkerEmail);
	
	var newInputWorkerEmail = document.createElement("input");
	newInputWorkerEmail.setAttribute("type","text");
	newInputWorkerEmail.setAttribute("name","worker_email"+"[]");
	newInputWorkerEmail.setAttribute("id","worker"+cont);
	newInputWorkerEmail.setAttribute("size","20");

	newWorker.appendChild(newLabelWorker_email);
	newWorker.appendChild(newInputWorkerEmail);
	newWorker.innerHTML += '<hr/>';
	

	$(newWorker).appendTo("#equipa_trabalho");

	cont++;
  
  });

$("#remover_equipa_trabalho").click(function () {
			if(cont==2){
          		alert("Tem que existir pelo menos um elemento!");
          		return false;
       		}   
 
			cont--;
        	$("#w"+cont).remove();
     	});



});

