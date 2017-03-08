$(function() {
  var $upload = document.getElementById("upload")
  $upload.addEventListener("click", function() {
    var title = document.getElementById("title").value
    var body = document.getElementById("editor").value
    var html = document.getElementById("result").innerHTML
    $.ajax({
      type: 'post',
      url: '/post_article',
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
