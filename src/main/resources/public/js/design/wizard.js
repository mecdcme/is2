$(document).ready(function(){

var current_fs, next_fs, previous_fs, test_fs; //fieldsets
var opacity;



$("#functionList").on('change', function(e) {
	if( $(this).val()!="0"){
		$.ajax({
			type : "GET",
			contentType : "application/json",
			url : _ctx + "/rest/design/getFunction/" +  $(this).val(),
			dataType : 'json',
			cache : true,
			success : function(data) {
//				$('#idf').val(data.id);
				$('#namef').val(data.name);
				$('#descriptionf').val(data.descr);
				$('#labelf').val(data.label);
				$('.functionList').empty();
				$('.functionList').append('<li class="treeview-animated-items" > <a class="open closed"><span>' + "Function: "+ data.name + '</span></a></li><ul class="nested processList">');
				$('.function').attr("readonly", "readonly");
				
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
//		$('#idf').val("0");
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
//				$('#idp').val(data.id);
				$('#namep').val(data.name);
				$('#descriptionp').val(data.descr);
				$('#labelp').val(data.label);
				$('.processList').empty();
				$('.processList').append('<li class="treeview-animated-items" > <a class="open closed"><span>' + "Process: "+ data.name + '</span></a></li></ul><ul class="nested subprocessList">');
				$('.process').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
//		$('#idp').val("");
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
//				$('#ids').val(data.id);
				$('#names').val(data.name);
				$('#descriptions').val(data.descr);
				$('#labels').val(data.label);
				$('.subprocessList').empty();
				$('.subprocessList').append('<ul class="nested" ><li class="treeview-animated-items" > <a class="open closed"><span>' + "Subrocess: "+ data.name + '</span></a></li></ul><ul class="nested stepList">');
				$('.subprocess').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
//		$('#ids').val("");
		$('#names').val("");
		$('#descriptions').val("");
		$('#labels').val("");
		$('#subprocessList').val()=="0"
		$('.subprocess').removeAttr("readonly", "readonly");
	};
	
});


$("#stepList").on('change', function(e) {
	if( $(this).val()!="0"){
		$.ajax({
			type : "GET",
			contentType : "application/json",
			url : _ctx + "/rest/design/getStep/" +  $(this).val(),
			dataType : 'json',
			cache : true,
			success : function(data) {
//				$('#ids').val(data.id);
				$('#namest').val(data.name);
				$('#descriptionst').val(data.descr);
				$('#labelst').val(data.label);
				$('#businessService').val(data.businessService.id);
				$("#businessService").attr("disabled", true);
				$('.stepList').empty();
				$('.stepList').append('<ul class="nested" ><li class="treeview-animated-items" > <a class="open closed"><span>' + "Step: "+ data.name + '</span></a></li></ul>');
				$('.step').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
//		$('#ids').val("");
		$('#namest').val("");
		$('#descriptionst').val("");
		$('#labelst').val("");
		$('#stepList').val()=="0"
		$("#businessService").attr("disabled", false);
		$('.step').removeAttr("readonly", "readonly");
	};
	
});

$(".next").click(function(){

test_fs = $(this).parent();
var x = false;
var tabNMame = test_fs[0].name
var ajaxError=false;


try {
		switch (tabNMame) {
		
			case "function":
				if($('#functionList').val()=="0"){
					
					if($('#namef').val().length!=0  &&  $('#descriptionf').val().length!=0 &&  $('#labelf').val().length!=0 ){
						
						_functions.forEach(function(item, index){ 
							if(item.name==$('#namef').val()){
								alert(_alertFunction);
//								$('#idf').val("");
								$('#namef').val("");
								$('#descriptionf').val("");
								$('#labelf').val("");
								$('#functionList').val("0");
								
								
								
									throw "exit";
							}
						});
						$('.functionList').empty();
						$('.functionList').append('<li class="treeview-animated-items" > <a class="open closed"><span>' + "Function: "+ $('#namef').val() + '</span></a></li><ul class="nested processList">');
						
					}else{
						alert(_alertFillAllFields)
						throw "exit";
					}
					
				}
				break;
			case "process":
				if($('#processList').val()=="0"){
					
					
					if($('#namep').val().length!=0  &&  $('#descriptionp').val().length!=0 &&  $('#labelp').val().length!=0 ){
		
						
						_processes.forEach(function(item, index){ 
							if(item.name==$('#namep').val()){
								alert(_alertProcess);
//								$('#idp').val("");
								$('#namep').val("");
								$('#descriptionp').val("");
								$('#labelp').val("");
								$('#processList').val("0");
								
									throw "exit";
							}
						});
						$('.processList').empty();
						$('.processList').append('<li class="treeview-animated-items" > <a class="open closed"><span>' + "Process: "+ $('#namep').val() + '</span></a></li></ul><ul class="nested subprocessList">');
					}else{
						alert(_alertFillAllFields)
						throw "exit";
					}
					
				}
				break;
			case "subprocess":
				if($('#subprocessList').val()=="0"){
					
					if($('#names').val().length!=0  &&  $('#descriptions').val().length!=0 &&  $('#labels').val().length!=0 ){
						
						
						_subprocesses.forEach(function(item, index){ 
							if(item.name==$('#names').val()){
								alert(_alertSubprocess);
//								$('#ids').val("");
								$('#names').val("");
								$('#descriptions').val("");
								$('#labels').val("");
								$('#subprocessList').val("0");
								
								
									throw "exit";
							}
						});
						$('.subprocessList').empty();
						$('.subprocessList').append('<ul class="nested" ><li class="treeview-animated-items" > <a class="open closed"><span>' + "Subrocess: "+ $('#names').val() + '</span></a></li></ul><ul class="nested stepList">');
						
					}else{
						alert(_alertFillAllFields)
						throw "exit";
					}
				
				}
				break;
			case "step":
				
					if($('#stepList').val()=="0"){
					
						if($('#namest').val().length!=0  &&  $('#descriptionst').val().length!=0  &&  $('#labelst').val().length!=0 &&  $('#businessService').val()!="0"){
							
							
							_steps.forEach(function(item, index){ 
								if(item.name==$('#namest').val()){
									alert(_alertStep);
	//								$('#idst').val("");
									$('#namest').val("");
									$('#descriptionst').val("");
									$('#labelst').val("");
									$('#stepList').val("0");
									
										throw "exit";
								}
							});
							$('.stepList').empty();
							$('.stepList').append('<ul class="nested" ><li class="treeview-animated-items" > <a class="open closed"><span>' + "Step: "+ $('#namest').val() + '</span></a></li></ul>');
							
						}else{
							alert(_alertFillAllFields)
							throw "exit";
						}
					}
					$.ajax({
						type : "POST",
						contentType : "application/json",
						async: false,
						url : _ctx + "/rest/design/savewizard/" +$('#functionList').val() + "/" + $('#namef').val() + "/" + $('#descriptionf').val() + "/" + $('#labelf').val() + "/" + $('#processList').val() + "/" + $('#namep').val() + "/" + $('#descriptionp').val() + "/" + $('#labelp').val() + "/" + $('#subprocessList').val() + 
						"/" + $('#names').val() + "/" + $('#descriptions').val() + "/" + $('#labels').val() + "/" + $('#stepList').val() + "/" + $('#namest').val() + "/" +  $('#descriptionst').val() + "/" + $('#labelst').val() + "/" + $('#businessService').val(),
						cache : true,
						
						success : function(data) {

							
							console.log("OK");
						},
						error : function(e) {

							console.log("ERROR : ", e);
							
							ajaxError=true;
						},
						complete : function() {

						}
					});
					
					
				break;
			default:
				
				break;
		
		}	
	
	
		if(!ajaxError){
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
		} 		
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
	
	
	switch (previous_fs[0].attributes.name.nodeValue) {
		case "function":
			
			$('#namep').val("");
			$('#descriptionp').val("");
			$('#labelp').val("");
			$('processList').val("0");
			$('.processList').empty();
			$('.process').removeAttr("readonly", "readonly");
			break;
		case "process":
			$('#names').val("");
			$('#descriptions').val("");
			$('#labels').val("");
			$('#subprocessList').val("0");
			$('.subprocessList').empty();
			$('.subprocess').removeAttr("readonly", "readonly");
			
			break;
		case "subprocess":
			$('#namest').val("");
			$('#descriptionst').val("");
			$('#labelst').val("");
			$('#stepList').val("0");
			$('.stepList').empty();
			$('#businessService').val("0");
			$("#businessService").attr("disabled", false);
			$('.step').removeAttr("readonly", "readonly");
			break;
			
		default:
			break;
	
	}
	
	
	
	
});

$('.radio-group .radio').click(function(){
$(this).parent().find('.radio').removeClass('selected');
$(this).addClass('selected');
});

$(".submit").click(function(){
return false;
})

});