$(document).ready(function () {

	$(".boneco").animate({ left: 100, opacity: "show" }, {
		duration: 2000,
		complete: function () {
			
			$(".info_init").append("<p>Bem vindo ao site do Corpo Humano! Eu sou o Óscar, e estou aqui para te ajudar smile emoticon.</p>");
                   $(".info_init").append("<p>Escolhe a matéria que desejas conhecer, e depois de aprenderes tudo na aula e achares que estás pronto, faz um teste para testar as tuas capacidades.");
                          $(".info_init").append("Podes sempre visitar as estatísticas para acompanhar o teu progresso!</p>");
							$(".ver_aulas").append("<center><a href='#ver_aulas'><h2 class=''>Ver aulas</h2></a></center>");

		}
	}, 4000);



});