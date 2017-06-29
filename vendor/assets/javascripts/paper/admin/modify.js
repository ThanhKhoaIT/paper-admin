$(document).on('change', 'input[type="file"][target]', function(event){
  if (this.files && this.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      var previewTarget = $(event.target).attr('target');
      var parentSelector = $(event.target).attr('parent');
      if (parentSelector != "") {
        $(event.target)
          .parents(parentSelector)
          .find(previewTarget)
          .attr('src', e.target.result);
      } else {
        $(previewTarget)
          .attr('src', e.target.result);
      }
    }
    reader.readAsDataURL(this.files[0]);
  }
});

$(function() {
  $('[data-toggle="tooltip"]').tooltip({ container: 'body' });
})
