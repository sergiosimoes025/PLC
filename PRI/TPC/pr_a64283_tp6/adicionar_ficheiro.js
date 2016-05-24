$(document).ready(function(){
var cont = 2;
	$("#adicionar_ficheiro").click(function(){
		var newFile = document.createElement("div");

		newFile.setAttribute("id",'f'+cont);
		var newLabel_file = document.createElement("label");
		newLabel_file.setAttribute("for","file"+cont);
		var newLabel_file_name = document.createTextNode("Ficheiro:");
		newLabel_file.appendChild(newLabel_file_name);

		newFile.appendChild(newLabel_file);

		var newFileInput = document.createElement("input");
		newFileInput.setAttribute("type","file");
		newFileInput.setAttribute("name","file_name"+"[]");
		newFileInput.setAttribute("id","file"+cont);
		newFileInput.setAttribute("size","20");
 		

 		newFile.appendChild(newFileInput);
 		cont++;
 		newFile.innerHTML += '<hr/>';
 		$(newFile).appendTo("#ficheiros");
		
		});

	$("#remover_ficheiro").click(function(){
		if(cont == 2){
			alert("Tem que enviar pelo menos 1 ficheiro!");
			return false;
		}
		cont--;
		$("#f"+cont).remove();




	});





});