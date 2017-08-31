$(document).ready(function(){
  $('body').on('click', '.icon-delete', function(e){
    var post_id = $(this).closest('.delete-post').data('post');
    if (confirm('Are you sure you want to delete this?')) {
    $.ajax({
          url: '/microposts/' + post_id,
          dataType: 'JSON',
          method: "DELETE",
          data: {post_id: post_id}
        })
        .done(function(data) {
          $(".fade-out-post-"+ post_id).fadeOut(200);
        });
        }
  });
});
