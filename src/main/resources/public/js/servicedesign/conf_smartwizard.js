/**
 * Copyright 2019 ISTAT
 * 
 * Licensed under the EUPL, Version 1.1 or – as soon they will be approved by
 * the European Commission - subsequent versions of the EUPL (the "Licence");
 * You may not use this work except in compliance with the Licence. You may
 * obtain a copy of the Licence at:
 * 
 * http://ec.europa.eu/idabc/eupl5
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the Licence is distributed on an "AS IS" basis, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * Licence for the specific language governing permissions and limitations under
 * the Licence.
 * 
 * @author Francesco Amato <framato @ istat.it>
 * @author Mauro Bruno <mbruno @ istat.it>
 * @author Paolo Francescangeli <pafrance @ istat.it>
 * @author Renzo Iannacone <iannacone @ istat.it>
 * @author Stefano Macone <macone @ istat.it>
 * @version 1.0
 */
var _ctx = $("meta[name='ctx']").attr("content");

$(document).ready(function() {

	
	// SMART WIZARD
	
	$('#smartwizard').smartWizard();
	
	$("#smartwizard").on("stepContent", function(e, anchorObject, stepIndex, stepDirection) {

		  var repo    = anchorObject.data('repo');
		  var ajaxURL = "https://api.npms.io/v2/package/" + repo;
		  // Return a promise object
		  return new Promise((resolve, reject) => {

		    // Ajax call to fetch your content
		    $.ajax({
		    	url : _ctx + "/loadGsbpmSubProcess/" + id_process,
		        method  : "GET",
		        //url     : ajaxURL,
		        dataType : "JSON",
		        beforeSend: function( xhr ) {
		            // Show the loader
		            $('#smartwizard').smartWizard("loader", "show");
		        }
		    // done
		    }).done(function( res ) {
		        // console.log(res);

		    	var html = "Ciao";
		        var html2 = '<h2>Ajax data about ' + repo + ' loaded from GitHub</h2>';
		        html += '<br>URL: <strong>' + ajaxURL + '</strong>';
		        html += '<br>Name: <strong>' + res.collected.metadata.name + '</strong>';
		        html += '<br>Description: ' + res.collected.metadata.description;
		        html += '<br>Homepage: <a href="' + res.collected.github.homepage + '" >'+ res.collected.github.homepage +'</a>';
		        html += '<br>Keywords: ' + res.collected.metadata.keywords.join(', ');

		        // html += '<br>Clone URL: ' + res.clone_url;
		        html += '<br>Stars: ' + res.collected.github.starsCount;
		        html += '<br>Forks: ' + res.collected.github.forksCount;
		        html += '<br>Watchers: ' + res.collected.github.subscribersCount;
		        html += '<br>Open Issues: ' + res.collected.github.issues.openCount + '/' + res.collected.github.issues.count;

		        html += '<br><br>Popularity: ' + parseInt(res.score.detail.popularity * 100);
		        html += '<br>Quality: ' + parseInt(res.score.detail.quality * 100);
		        html += '<br>Maintenance: ' + parseInt(res.score.detail.maintenance * 100);

		        // Resolve the Promise with the tab content
		        resolve(html);

		        // Hide the loader
		        $('#smartwizard').smartWizard("loader", "hide");
		    }).fail(function(err) {

		        // Reject the Promise with error message to show as tab content
		        reject( "An error loading the resource" );

		        // Hide the loader
		        $('#smartwizard').smartWizard("loader", "hide");
		    });

		  });
		});
	
	customizeSW();
	inizializeSW();
	createControlsSW();
});
function createControlsSW(){
	// goto a specific step
	$('#smartwizard').smartWizard('goToStep', stepIndex);

	// up<a href="https://www.jqueryscript.net/time-clock/">date</a> options
	$('#smartwizard').smartWizard('setOptions', stepIndex);

	// goto the next step
	$('#smartwizard').smartWizard('next');

	// goto the prev step
	$('#smartwizard').smartWizard('prev');

	// reset the wizard
	$('#smartwizard').smartWizard('reset');

	// change the state of step(s)
	$('#smartwizard').smartWizard("stepState", [1,3], "disable");
	$('#smartwizard').smartWizard("stepState", [2], "hide");

	// get the current 
	var stepIndex = $('#smartwizard').smartWizard("getStepIndex");

	// show/hide content loader
	$('#smartwizard').smartWizard("loader", "show");
	$('#smartwizard').smartWizard("loader", "hide");
}
function inizializeSW(){
	// Initialize the leaveStep event
	$("#smartwizard").on("leaveStep", function(e, anchorObject, stepIndex, stepDirection) {
	  // do something
	});

	// Initialize the showStep event
	$("#smartwizard").on("showStep", function(e, anchorObject, stepIndex, stepDirection, stepPosition) {
	  // do something
	});

	// Initialize the beginReset event
	$("#smartwizard").on("stepContent", function(e, anchorObject, stepIndex, stepDirection) {
	  // do something
	});
}
function customizeSW(){
	$('#smartwizard').smartWizard({

		  // Initial selected step, 0 = first step 
		  selected: 0,  

		  // Theme: default, arrows, circles
		  theme: 'default',

		  // Nav menu justification. true/false
		  justified: true,

		  // Automatically adjust content height
		  autoAdjustHeight:true, 

		  // Allow to cycle the navigation of steps
		  cycleSteps: false, 

		  // Enable the back button support
		  backButtonSupport: true, 

		  // Enable selection of the step based on url hash
		  useURLhash: true, 

		  // Show url hash based on step 
		  enableURLhash: true, 

		  // Config transitions
		  transition: {

		    // none/fade/slide-horizontal/slide-vertical/slide-swing
		    animation: 'none',

		    // transition speed
		    speed: '400',

		    // easing function
		    easing: ''

		  },

		  // Enable keyboard navigation
		  keyboardSettings: {
		    key: true,
		    keyLeft: [37],
		    keyRight: [39]
		  },

		  // Language variables
		  lang: {  
		    next: 'Next', 
		    previous: 'Previous'
		  },

		  // step bar options
		  toolbarSettings: {
		    toolbarPosition: 'bottom', // none, top, bottom, both
		    toolbarButtonPosition: 'right', // left, right
		    showNextButton: true, // show/hide a Next button
		    showPreviousButton: true, // show/hide a Previous button
		    toolbarExtraButtons: []
		  }, 

		  // anchor options
		  anchorSettings: {
		    anchorClickable: true, // Enable/Disable anchor navigation
		    enableAllAnchors: false, // Activates all anchors clickable all times
		    markDoneStep: true, // add done css
		    markAllPreviousStepsAsDone: true, // When a step selected by url hash, all previous steps are marked done
		    removeDoneStepOnNavigateBack: false, // While navigate back done step after active step will be cleared
		    enableAnchorOnDoneStep: true // Enable/Disable the done steps navigation
		  },     

		  // Array of disabled Steps
		  disabledSteps: [],    

		  // Highlight step with errors
		  errorSteps: [],    

		  // Hidden steps
		  hiddenSteps: []
		  
		});
}