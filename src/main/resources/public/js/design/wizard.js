$(document).ready(function(){

var current_fs, next_fs, previous_fs, test_fs; //fieldsets
var opacity;

var getTree = function drawTree(level, treeNodeName) {
    var retval;
	
	switch (level) {
	case "function":
		
		retval= '<li class="treeview-animated-items" > <a class="open closed"><span>' + "Function: "+ treeNodeName + '</span></a></li><ul class="nested processList"></ul>'
		
		for (var i = 0; i <_albero.length; i++) {
			if (_albero[i].data != treeNodeName){
				retval += '<li class="treeview-animated-items" ><span>' + _albero[i].data + '</span></li>'
			}
			
				
		}
		
		break;
	case "process":
		retval= '<li class="treeview-animated-items" > <a class="open closed"><span>' + "Process: " +treeNodeName + '</span></a></li><ul class="nested subprocessList"></ul>'
		for (var i = 0; i <_albero.length; i++) {

				for (var j = 0; j <_albero[i].children.length; j++) {
					if ((_albero[i].children[j].data != treeNodeName) && (_albero[i].data == $('#namef').val() ^ $('#functionList').val()=="0") && ($('#functionList').val()!="0")){
						
						retval += '<li class="treeview-animated-items" ><span>' + _albero[i].children[j].data + '</span></li>'
						
					}	
						
				}

		}
		break;
	case "subprocess":
		retval= '<li class="treeview-animated-items" > <a class="open closed"><span>' + "Subrocess: "+treeNodeName + '</span></a></li></ul><ul class="nested stepList"></ul>'
		
		for (var i = 0; i <_albero.length; i++) {

				for (var j = 0; j <_albero[i].children.length; j++) {
						
						for (var k = 0; k <_albero[i].children[j].children.length; k++) {
							if ((_albero[i].children[j].children[k].data != treeNodeName) && (_albero[i].data == $('#namef').val() ^ $('#functionList').val()=="0") && (_albero[i].children[j].data ==  $('#namep').val() ^ $('#processList').val()=="0") && ($('#processList').val()!="0")){
								
								retval += '<li class="treeview-animated-items" > <a class="open closed"><span>' +_albero[i].children[j].children[k].data + '</span></a></li>'
								
							}	
								
						}
						
						

						
				}

		}
		
		
		
		break;
	case "step":
		
		retval= '<li class="treeview-animated-items"> <a class="open closed"><span>' + "Step: "+ treeNodeName + '</span></a></li>'
		
		
		for (var i = 0; i <_albero.length; i++) {

				for (var j = 0; j <_albero[i].children.length; j++) {

						
						for (var k = 0; k <_albero[i].children[j].children.length; k++) {

								
								for (var m = 0; m <_albero[i].children[j].children[k].children.length; m++) {
									if ((_albero[i].children[j].children[k].children[m].data != treeNodeName) && (_albero[i].data == $('#namef').val() ^ $('#functionList').val()=="0")  && (_albero[i].children[j].data ==  $('#namep').val() ^ $('#processList').val()=="0")  && (_albero[i].children[j].children[k].data == $('#names').val() ^ $('#subprocessList').val()=="0") && ($('#subprocessList').val()!="0") ){
										
										retval += '<li class="treeview-animated-items"><a class="open closed"><span>' + _albero[i].children[j].children[k].children[m].data + '</span></a></li>' 
										
									}	
										
								}
							
							
							

								
						}
						
						

						
				}

		}
		
	
		break;
	
	default:
		break;

	}
	
	return retval;
};

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
				$('.functionList').append(getTree("function", data.name));
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
		$('#functionList').val("0")
		$('.functionList').empty();
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
				$('.processList').append(getTree("process",data.name));
				$('.process').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
		$('#namep').val("");
		$('#descriptionp').val("");
		$('#labelp').val("");
		$('#processList').val("0");
		$('.processList').empty();
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
				$('.subprocessList').append(getTree("subprocess",data.name));
				$('.subprocess').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
		$('#names').val("");
		$('#descriptions').val("");
		$('#labels').val("");
		$('#subprocessList').val("0")
		$('.subprocessList').empty();
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
				$('#namest').val(data.name);
				$('#descriptionst').val(data.descr);
				$('#labelst').val(data.label);
				$('#businessService').val(data.businessService.id);
				$("#businessService").attr("disabled", true);
				$('.stepList').empty();
				$('.stepList').append(getTree("step", data.name));
				$('.step').attr("readonly", "readonly");
			},
			error : function(e) {
	
				console.log("ERROR : ", e);
			},
			complete : function() {
	
			}
		});
	}else{
		$('#namest').val("");
		$('#descriptionst').val("");
		$('#labelst').val("");
		$('#stepList').val("0")
		$('.stepList').empty();
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
								$('#namef').val("");
								$('#descriptionf').val("");
								$('#labelf').val("");
								$('#functionList').val("0");
								
								
								
									throw "exit";
							}
						});
						$('.functionList').empty();
						$('.functionList').append(getTree("function", $('#namef').val()));
						
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
								$('#namep').val("");
								$('#descriptionp').val("");
								$('#labelp').val("");
								$('#processList').val("0");
								
									throw "exit";
							}
						});
						$('.processList').empty();
						$('.processList').append(getTree("process", $('#namep').val()));
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
								$('#names').val("");
								$('#descriptions').val("");
								$('#labels').val("");
								$('#subprocessList').val("0");
								
								
									throw "exit";
							}
						});
						$('.subprocessList').empty();
						$('.subprocessList').append(getTree("subprocess", $('#names').val()));
						
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
									$('#namest').val("");
									$('#descriptionst').val("");
									$('#labelst').val("");
									$('#stepList').val("0");
									
										throw "exit";
								}
							});
							$('.stepList').empty();
							$('.stepList').append(getTree("step", $('#namest').val()));
							
						}else{
							alert(_alertFillAllFields)
							throw "exit";
						}
					}
					$.ajax({
						type : "POST",
						contentType : "application/json",
						async: true,
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
			$('#processList').val("0");
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