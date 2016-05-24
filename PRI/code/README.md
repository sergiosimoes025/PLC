trim mensagens da sidebar do layout das mensagens
sidebar das activities dos Your Journeys, mudar o coracao dos favoritos para starts
edit profile: add new place escaxa
recent activity: Rated null with 5 starts.. verificar se as coisas estao a ser eliminadas do userFeed
meter seccao de followers no perfil de utilizador
google maps nao mostra alguns resultados de ruas/restaurantes/etc 
notifications	
ao fazer review, nas actividades mostrar o que foi feito de review
limitar zoom in/out dos mapas
tooltips nos icones da ESTRELA e COMENTARIO da pagina do roteiro
botao delete place na criacao/edit form do journey
set zoom maximum journeys maps

mudar o height do slideshow to explore

Forum de discussao tipo Q&A.. QUORA, REDDIT


Tirar links dos comments/reviews dos 'My guides' e 'Favorites' na pagina de activity
jQuery validate para os forms.
Change Profile Picture: jQuery a fazer upload para o cloudinary em vez de fazer para o servidor.

Configs 
Check if compress is working
Modularizar dados que vem de forms para o mongo de maneira a que os controladores nao saibam nada do Schema, por exemplo usar _.extend(). Assim pode-se alterar o Schema sem muita chatisse adicional.
Sharding nas mensagens (Fan Out on write) e actividades (Fan Out on Write)

////
The formula for calculating the Top Rated 250 Titles gives a true Bayesian estimate:	
weighted rating (WR) = (v ÷ (v+m)) × R + (m ÷ (v+m)) × C
where:
    R = average for the movie (mean) = (Rating)
    v = number of votes for the movie = (votes)
    m = minimum votes required to be listed in the Top 250 (currently 3000)	
	C = the mean vote across the whole report (currently 6.9)