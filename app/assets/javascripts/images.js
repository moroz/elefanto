// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function() {
  $('.directUpload').find("input:file").each(function(i, elem) {
    var fileInput = $(elem);
    var form = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);
    fileInput.fileupload({
      fileInput:  fileInput,
      url:        form.data('url'),
      type:       'POST',
      autoUpload: true,
      formData:   form.data('form-data'),
      paramName:  'file',
      dataType:   'XML',
      replaceFileInput: false,
      progressall: function (e, data) {
        console.log("Invoking progressall...");
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%');
      },
      start: function (e) {
        console.log("Invoking start...");
        submitButton.prop('disabled', true);
        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...");
      },
      done: function (e, data) {
        console.log("Invoking done...");
        submitButton.prop("disabled", false);
        progressBar.text("Uploading done");
        var key = $(data.jqXHR.responseXML).find("Key").text();
        var url = '//' + form.data('host') + '/' + key;
        var input = $("<input />", { type: 'hidden', name: fileInput.attr('name'), value: url });
        form.append(input);
      },
      fail: function (e, data) {
        console.log("Invoking fail...");
        submitButton.prop('disabled', false);
        progressBar.
          css('background', 'red').
          text('Failed');
      }
    });
  });
});
