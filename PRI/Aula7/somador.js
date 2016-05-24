$(document).ready(function(){
  var cont = 3;
                   
  $("#adicionar").click(function () {
    if(cont>5)
          {
        alert("O limite máximo é de 5 operandos!");
        return false;
          }
                         
        var newOp = document.createElement('div');
       
    newOp.setAttribute("id",'o' + cont);
   
    var newLabelOp = document.createElement("label");
        newLabelOp.setAttribute("for","op"+cont);
        var newLabelOpCont = document.createTextNode('Op'+cont+':');
        newLabelOp.appendChild(newLabelOpCont);
        newOp.appendChild(newLabelOp);
               
        var newInputOp = document.createElement("input");
        newInputOp.setAttribute("type","text");
        newInputOp.setAttribute("name","op"+cont);
        newInputOp.setAttribute("id","op"+cont);
        newInputOp.setAttribute("size","4");
        newOp.appendChild(newInputOp);
       
        $(newOp).appendTo("#operandos");
        cont++;
  });
 
        $("#remover").click(function () {
                        if(cont==3){
                        alert("Tem de haver pelo menos 2 operandos. Já não pode remover mais...");
                        return false;
                }  
 
                        cont--;
                $("#o"+cont).remove();
        });
       
        $("#enviar").click(function () {
          $("#somador").submit();
        });
  });