$(document).ready(function(){

var current_fs, next_fs, previous_fs, test_fs; //fieldsets
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
				$('#idf').val(data.id);
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
		$('#idf').val("");
		$('#namef').val("");
		$('#descriptionf').val("");
		$('#labelf').val("");
		$('#functionList').val()=="0"
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
				$('#idp').val(data.id);
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
		$('#idp').val("");
		$('#namep').val("");
		$('#descriptionp').val("");
		$('#labelp').val("");
		$('#processList').val()=="0"
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
				$('#ids').val(data.id);
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
		$('#ids').val("");
		$('#names').val("");
		$('#descriptions').val("");
		$('#labels').val("");
		$('#subprocessList').val()=="0"
		$('.subprocess').removeAttr("readonly", "readonly");
	};
	
});




$(".next").click(function(){

test_fs = $(this).parent();
var x = false;
var tabNMame = test_fs[0].name



try {
		switch (tabNMame) {
		
			case "function":
				if($('#functionList').val()=="0"){
					
					if($('#namef').val().length!=0  &&  $('#descriptionf').val().length!=0 &&  $('#labelf').val().length!=0 ){
						
						_functions.forEach(function(item, index){ 
							if(item.name==$('#namef').val()){
								alert("Function with this name already exist, please select the function fron the list or choose a different name");
								$('#idf').val("");
								$('#namef').val("");
								$('#descriptionf').val("");
								$('#labelf').val("");
								$('#functionList').val()=="0"
								
								
								
									throw "exit";
							}
						});
						
						
						
					}else{
						alert("fill all fields to proceed!")
						throw "exit";
					}
					
				}
				break;
			case "process":
				if($('#processList').val()=="0"){
					
					
					if($('#namep').val().length!=0  &&  $('#descriptionp').val().length!=0 &&  $('#labelp').val().length!=0 ){
		
						
						_processes.forEach(function(item, index){ 
							if(item.name==$('#namep').val()){
								alert("Process with this name already exist, please select the process fron the list or choose a different name");
								$('#idp').val("");
								$('#namep').val("");
								$('#descriptionp').val("");
								$('#labelp').val("");
								$('processList').val()=="0"
								
									throw "exit";
							}
						});
						
						
					}else{
						alert("fill all fields to proceed!")
						throw "exit";
					}
					
				}
				break;
			case "subprocess":
				if($('#subprocessList').val()=="0"){
					
					if($('#names').val().length!=0  &&  $('#descriptions').val().length!=0 &&  $('#labels').val().length!=0 ){
						
						
						_subprocesses.forEach(function(item, index){ 
							if(item.name==$('#names').val()){
								alert("Subprocess with this name already exist, please select the subprocess fron the list or choose a different name");
								$('#ids').val("");
								$('#names').val("");
								$('#descriptions').val("");
								$('#labels').val("");
								$('#subprocessList').val()=="0"
								
								
									throw "exit";
							}
						});
						
						
						
					}else{
						alert("fill all fields to proceed!")
						throw "exit";
					}
				
				}
				break;
			case "step":
				
					
					if($('#namest').val().length!=0  &&  $('#descriptionst').val().length!=0  &&  $('#businessService').val()!="0"){
						
						
						_steps.forEach(function(item, index){ 
							if(item.name==$('#namest').val()){
								alert("Step with this name already exist, please choose a different name");
								$('#idst').val("");
								$('#namest').val("");
								$('#descriptionst').val("");
								
								
									throw "exit";
							}
						});
						
						$("#msform").submit();
						
					}else{
						alert("fill all fields to proceed!")
						throw "exit";
					}
					$.ajax({
						type : "POST",
						contentType : "application/json",
						url : _ctx + "/rest/design/saveStep/" + $('#idf').val() + "/" + $('#namef').val() + "/" + $('#descriptionf').val() + "/" + $('#labelf').val() + "/" +
						$('#idp').val() + "/" + $('#namep').val() + "/" + $('#descriptionp').val() + "/" + $('#labelp').val() + "/" +
						$('#ids').val() + "/" + $('#names').val() + "/" + $('#descriptions').val() + "/" + $('#labels').val() + "/" +
						$('#namest').val() + "/" + $('#descriptionst').val() + "/" + $('#businessService').val(),
						dataType : 'json',
						cache : true,
						success : function(data) {

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

						},
						error : function(e) {

							console.log("ERROR : ", e);
						},
						complete : function() {

						}
					});
					
					throw "exit";
				break;
			default:
				
				break;
		
		}	
	
	
	
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

	} catch (e) {
	    // TODO: handle exception
	}
	
	
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