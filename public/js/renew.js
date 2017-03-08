$(function() {
  var $upload = document.getElementById("upload")
  $upload.addEventListener("click", function() {
    var title = document.getElementById("title").value
    var body = document.getElementById("editor").value
    var html = document.getElementById("result").innerHTML
    var route = '/renew/' + document.getElementById("id").textContent
    $.ajax({
      type: 'post',
      url: route,
      data: {
        'title': title,
        'body': body,
        'html': html
      }
    }).done(function(data) {
    }).fail(function(data) {
      console.log(data)
    })
  });
})
