// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {

  function reachable_check(inst_id) {
    $('.reachable_button_content[instance_id="' + inst_id + '"]').replaceWith('<div class="reachable_button_content" instance_id="' + inst_id + '"><img src="/assets/ajax-loader.gif" title="Working..." /></div>')
    console.log("Checking reachability for instance id:" + inst_id);
    $.getJSON("/instances/" + inst_id + "/reachable", function(result){
      console.log("Got result for " + inst_id + ": " + result.reachable);
      if (result.reachable === "true") {
        $('.reachable_button_content[instance_id="' + inst_id + '"]').replaceWith('<div class="reachable_button_content" instance_id="' + inst_id + '"><span class="text-success glyphicon glyphicon-ok" title="Success!"></span></div>')
      } else {
        $('.reachable_button_content[instance_id="' + inst_id + '"]').replaceWith('<div class="reachable_button_content" instance_id="' + inst_id + '"><span class="text-danger glyphicon glyphicon-remove" title="' + result.error + '"></span></div>')
      }
    }); 
  }

  $('.reachable_button').click(function() {
    var inst_id = $(this).attr("instance_id");
    reachable_check(inst_id);
  });

  $('.reachable_button_all').click(function(){
    var inst_id_list = $(this).attr("instance_ids").split(",");
    for (i = 0; i < inst_id_list.length; i++) {
      reachable_check(inst_id_list[i]);
    }
  });

  $('.new_template_form').submit(function(){
    console.log("Submiting new template!");
    $('#newTemplate').modal("toggle");
    $('#new_template_button_content').replaceWith('<div id="new_template_button_content"><img src="/assets/ajax-loader.gif" title="Working..." /></div>');
    var valuesToSubmit = $(this).serialize();
    $.post("/templates", valuesToSubmit, function(result) {
      if (result.created === "true") {
      $('#new_template_button').replaceWith('<a href="/templates" class="btn btn-default"><div id="new_template_button_content"><span class="text-success">Template saved!</span></div></a>');
      };
    });
    return false;
  });

  $('#new_instance_check_box_no_openshift').change(function(){
    if (this.checked) {
      $('.new_instance_check_boxes').prop('checked', false); 
      $('.new_instance_check_boxes').prop('disabled', true); 
      $('.new_instance_gear_size').prop('disabled', true); 
    } else if (this.checked === false) {
      $('.new_instance_check_boxes').prop('disabled', false); 
    };
  });

  $('.edit_instance_check_box_no_openshift').change(function(){
    var inst_id = $(this).attr("instance_id");
    console.log(inst_id);
    if (this.checked) {
      $('.edit_instance_check_boxes[instance_id=' + inst_id  + ']').prop('checked', false); 
      $('.edit_instance_check_boxes[instance_id=' + inst_id  + ']').prop('disabled', true); 
      $('.edit_instance_gear_size[instance_id=' + inst_id  + ']').prop('disabled', true); 
    } else if (this.checked === false) {
      $('.edit_instance_check_boxes[instance_id=' + inst_id  + ']').prop('disabled', false); 
    };
  });

  $('.edit_instance_check_box_node').change(function(){
    var inst_id = $(this).attr("instance_id");
    if (this.checked) {
      $('.edit_instance_gear_size[instance_id=' + inst_id  + ']').prop('disabled', false); 
    } else if (this.checked === false) {
      $('.edit_instance_gear_size[instance_id=' + inst_id  + ']').prop('disabled', true); 
    };
  });

  $('#new_instance_check_box_node').change(function(){
    if (this.checked) {
      $('.new_instance_gear_size').prop('disabled', false); 
    } else if (this.checked === false) {
      $('.new_instance_gear_size').prop('disabled', true); 
    };
  
  });

});
