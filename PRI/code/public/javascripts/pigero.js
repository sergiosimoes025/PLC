

// WINDOW SCROLLBARS
/*$(window).load(function () {
	$("#messages-sidebar .module-box, #message-container .scroll-container").customScrollbar({
		updateOnWindowResize:true,
		skin: "default-skin",
		wheelSpeed: 20
	});
});*/


// TOOTLIPS
$(document).ready(function() {
	$('a.bottom-tooltip').tooltip({
		placement: "bottom"
	});
	$('a.top-tooltip').tooltip({
		placement: "top"
	});
});


// FOLLOW BUTTON
$(document).ready(function() {

	$(".user-icons a.add").click(function() {

			if (!$(this).hasClass("added")) {
				$(this).addClass("added");
				$(".user-icons a.add span.text").text("Following");
				$(".user-icons a.add span.icon").removeClass("icon-single-add").addClass("icon-single-valid");
				$(".user-icons a.add span.text").attr("data-original-title", "Unfollow");
			} else {
				$(".user-icons a").removeClass("added");
				$(".user-icons a.add span.text").text("Follow");
				$(".user-icons a.add span.icon").removeClass("icon-single-valid").addClass("icon-single-add");
				$(".user-icons a.add span.text").attr("data-original-title", "Start following");
			}

			return false;

	});

});

// FAVORITE BUTTON
$(document).ready(function() {

	$("#guide-statics a#favorite").click(function() {

			if (!$(this).hasClass("added")) {
				$(this).addClass("added");
				$(this).attr("data-original-title", "Remove from Favorites");
				$(".tooltip").fadeOut(250);
			} else {
				$("#guide-statics a#favorite").removeClass("added");
				$(this).attr("data-original-title", "Add to Favorites");
				$(".tooltip").css(250);
			}

			return false;

	});

});


// SEARCHBAR
$(document).ready(function() {

	$('a.search-btn-trigger').click(function(e){ // don't forget that 'e'
		if ($("#full-SearchBar").css("display") === "none"){
			$("#full-SearchBar, .search-overlay").fadeIn(250);
			$("#full-SearchBar input").focus();
			e.stopPropagation();
		} else {
			$('#full-SearchBar, .search-overlay').fadeOut(250);			
		}
		
	
		$(document).click(function(e) {
			if (!$(e.target).is("#full-SearchBar, #full-SearchBar *")) {
				$('#full-SearchBar, .search-overlay').fadeOut(250);			
			};
		});		
	
		return false;
	});	
});


//SMOOTH SCROLL
$(document).ready(function() {
	
	$('#guide-statics a#reviews').smoothScroll({
		offset: -50,
		afterScroll: function() {
			$(".new-review input#title").focus();
		}
	});


});

/*
var jump=function(e)
{
   if (e){
       e.preventDefault();
       var target = $(this).attr("href");
   }else{
       var target = location.hash;
   }

   $('html,body').animate(
   {
       scrollTop: $(target).offset().top
   },600,function()
   {
       location.hash = target;
   });

}

$('html, body').hide();

$(document).ready(function()
{
    $('a[href^=#]').bind("click", jump);

    if (location.hash){
        setTimeout(function(){
            $('html, body').scrollTop(0).show();
            jump();
        }, 0);
    }else{
        $('html, body').show();
    }
});
*/

//EDDIT PROFILE TABS
$(document).ready(function() {

	$('#editprofile-sidebar a').click(function (e) {
	  e.preventDefault()
	  $(this).tab('show')
	});

});

