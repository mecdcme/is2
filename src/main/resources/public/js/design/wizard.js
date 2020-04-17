$(document).ready(function(){

var current_fs, next_fs, previous_fs; //fieldsets
var opacity;





$("#functionList").on('change', function(e) {
	if( $(this).val()!="0"){
		$.ajax({
			type : "GET",
			contentType : "application/json",
			url : _ctx + "/rest/design/getProcess/" +  $(this).val(),
			dataType : 'json',
			cache : true,
			success : function(data) {
	
				$('#namef').val(data.name);
				$('#descriptionf').val(data.descr);
				$('#labelf').val(data.label);
				$('.function').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
		$('.function').removeAttr("readonly", "readonly");
	};
	
});

$("#processList").on('change', function(e) {
	
	if( $(this).val()!="0"){
		$.ajax({
			type : "GET",
			contentType : "application/json",
			url : _ctx + "/rest/design/getProcess/" +  $(this).val(),
			dataType : 'json',
			cache : true,
			success : function(data) {
				$('#namep').val(data.name);
				$('#descriptionp').val(data.descr);
				$('#labelp').val(data.label);
				$('.process').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
		$('.process').removeAttr("readonly", "readonly");
	};
		
	
});

$("#subprocessList").on('change', function(e) {
	if( $(this).val()!="0"){
		$.ajax({
			type : "GET",
			contentType : "application/json",
			url : _ctx + "/rest/design/getProcess/" +  $(this).val(),
			dataType : 'json',
			cache : true,
			success : function(data) {
	
				$('#names').val(data.name);
				$('#descriptions').val(data.descr);
				$('#labels').val(data.label);
				$('.subprocess').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
		$('.subprocess').removeAttr("readonly", "readonly");
	};
	
});




$(".next").click(function(){

current_fs = $(this).parent();
next_fs = $(this).parent().next();



//Add Class Active
$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

//show the next fieldset
next_fs.show();
//hide the current fieldset with style
current_fs.animate({opacity: 0}, {
step: function(now) {
// for making fielset appear animation
opacity = 1 - now;

current_fs.css({
'display': 'none',
'position': 'relative'
});
next_fs.css({'opacity': opacity});
},
duration: 600
});
});

$(".previous").click(function(){

current_fs = $(this).parent();
previous_fs = $(this).parent().prev();

//Remove class active
$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

//show the previous fieldset
previous_fs.show();

//hide the current fieldset with style
current_fs.animate({opacity: 0}, {
step: function(now) {
// for making fielset appear animation
opacity = 1 - now;

current_fs.css({
'display': 'none',
'position': 'relative'
});
previous_fs.css({'opacity': opacity});
},
duration: 600
});
});

$('.radio-group .radio').click(function(){
$(this).parent().find('.radio').removeClass('selected');
$(this).addClass('selected');
});

$(".submit").click(function(){
return false;
})

});