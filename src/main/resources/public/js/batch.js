var _ctx = $("meta[name='ctx']").attr("content");
var toggle = true;
var stompClient = null;

$(document).ready(function() {
	pollLogs();
	pollJobs();
});

function esegui(idElaborazione, idProcesso) {
	$('#' + idProcesso).text("STARTING...");
	$('#esegui_' + idProcesso).addClass("not-active");
	$('#output_' + idProcesso).addClass("not-active");
	$.ajax({
		url : _ctx + '/rest/batch/' + idElaborazione + '/' + idProcesso,
		type : "GET",
		success : function(data) {
			console.log(JSON.stringify(data));
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log('Error loading data: ' + errorThrown);
		}
	});
}

function pollLogs() {
	$.ajax({
		type : "GET",
		contentType : "application/json",
		url : _ctx + "/rest/batch/logs",
		dataType : 'json',
		cache : true,
		success : function(data) {
			$('#logList').remove();
			$('#noLogList').remove();
			$('#logBox').remove();
			var ulList = $("#logbox").append("<ul id='logList'></ul>").find(
					'ul');
			jQuery.each(data, function() {
				ulList.append('<li>'
						+ new Date(this.msgTime).toLocaleDateString('it-IT', {
							day : '2-digit',
							month : '2-digit',
							year : 'numeric'
						}) + ' ' + new Date(this.msgTime).toLocaleTimeString()
						+ ' - ' + this.msg + '</li>');
			});
		},
		error : function(e) {
			alert("Error polling jobs");
			console.log("ERROR polling logs: ", e);
		},
		complete : function() {
			setTimeout(pollLogs, 5000);
		}
	});
}

function pollJobs() {
	console.log("Starting polling Jobs...");
	
	$.ajax({
		type : "GET",
		contentType : "application/json",
		url : _ctx + "/rest/batch/jobs",
		dataType : 'json',
		cache : true,
		success : function(data) {
			jQuery.each(data, function() {
				var old_status=$('#' + this.idProcesso).text();
				$('#' + this.idProcesso).text(this.status);
				if (this.status === 'FAILED') {
					$('#' + this.idProcesso).removeClass("waiting");
					$('#' + this.idProcesso).addClass("error");
					$('#esegui_' + this.idProcesso).removeClass("not-active");
				} else if (this.status === 'COMPLETED') {
					$('#' + this.idProcesso).removeClass("waiting");
					$('#output_' + this.idProcesso).removeClass("not-active");
					$('#esegui_' + this.idProcesso).removeClass("not-active");
					$('#' + this.idProcesso).addClass("success");
					console.log(this.idProcesso+'-  '+old_status+' '+this.status)
					if(old_status=='STARTED' && old_status!=this.status) window.location.reload();
				} 
				else {
					$('#' + this.idProcesso).addClass("waiting");
				}

			});
		},
		error : function(e) {
			alert('Session expired ! \nStart a new one.');
			console.log("ERROR : ", e);
		},
		complete : function() {
			setTimeout(pollJobs, 5000);
		}
	});
}0