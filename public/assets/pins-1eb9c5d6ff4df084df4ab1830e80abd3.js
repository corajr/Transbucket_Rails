$(document).ready(function(){function e(){$(".dz-preview").off("click"),$(".dz-preview").click(function(e){e.stopPropagation()})}var i=location.pathname.match(/pins\/(?:new|[^\/]+\/edit)/);if(i){var n="pins/new"!==i[0],t=".form-inline",a=$("#preview-template").html(),o=0,l=0;$(".add-button").click(function(){var e=$(this).parents(".controls"),i=e.find(".add-form.hide");i.toggleClass("hide")}),$(".controls .cancel").click(function(){var e=$(this).parents(".add-form");e.find("input[type=text]").val(""),e.addClass("hide")}),$("#pin_procedure_attributes_id").chosen({width:"80%",placeholder_text_single:"Procedures",max_selected_options:1}),$("#pin_surgeon_attributes_id").chosen({width:"80%",placeholder_text_single:"Surgeons",max_selected_options:1}),Dropzone.autoDiscover=!1,n||$("#submit-all").prop("disabled",!0);var r={previewsContainer:"#dropper",clickable:"#dropper",maxFilesize:1,previewTemplate:a,paramName:function(e){return"pin_images["+e+"][photo]"},addRemoveLinks:!0,headers:{"X-CSRF-Token":$('meta[name="csrf-token"]').attr("content")},autoProcessQueue:!1,uploadMultiple:!0,parallelUploads:100,maxFiles:10,init:function(){var e=document.querySelector("#submit-all");d=this,e.addEventListener("click",function(e){d.getQueuedFiles().length>0&&(e.preventDefault(),d.processQueue())})}},d=new Dropzone(t,r);d.on("addedfile",function(i){$(".dz-message:visible").hide(),i.index=o++,$(".dz-preview:last-child").attr("id","file-"+i.index),$("#submit-all").prop("disabled",!1),e()}),d.on("removedfile",function(e){0==$(".dz-preview:visible").length&&($(".dz-message").show(),$("#submit-all").prop("disabled",!0)),n&&$.ajax({url:"pin_images/"+e.id,type:"DELETE"})}),d.on("sending",function(e,i,n){var t="#file-"+e.index+" .caption";n.append("pin_images["+l++ +"]caption",$(t).val())}),d.on("sendingmultiple",function(e,i,n){tinyMCE.triggerSave();var t=$("[data-pin-image-id]:not([data-pin-image-id=''])").map(function(){return $(this).data("pin-image-id")}).get();t.forEach(function(i,t){n.append("pin_images["+(t+e.length)+"][id]",i)})}),d.on("successmultiple",function(e,i){if(n){var a=$(t).data("pin-id");window.location.href="/pins/"+a}else window.location.href="/pins/"+i.id}),d.on("errormultiple",function(e,i){$("#error_explanation ul").empty(),i.forEach(function(e){$("#error_explanation ul").append("<li>"+e+"</li>")})}),n&&($(".dz-message:visible").hide(),$.getJSON("pin_images.json",function(i){return i&&(i.forEach(function(e){d.options.addedfile.call(d,e),$(e.previewElement).attr("data-pin-image-id",e.id),$(e.previewElement).children("input").val(e.caption),d.options.thumbnail.call(d,e,e.url)}),e()),$("input.caption").on("change",function(e){var i=$(this.parentElement).data("pin-image-id"),n=$(this),t=n.val();$.ajax({url:"/pin_images/"+i+".json",type:"PUT",data:{id:i,caption:t},success:function(){n.css("border-color","green"),n.append("\u2714")}})}),i}))}});