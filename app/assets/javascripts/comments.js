$(document).ready(function(){
  $('body').on('keypress', '.form-add-comment', function(event){
    var keyCode = (event.keyCode ? event.keyCode : event.which);
    if (keyCode == 13) {
      $(this).parents('.new_comment').find('.send-message').click();
    }
  });

  $('body').on('click', '.send-message', function() {
    $thisbutton = $(this);
    var txt_mess = $thisbutton.parents('.new_comment')
      .find('.form-add-comment');
    var url = $thisbutton.parents('.new_comment').attr('action');

    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'JSON',
      data: {
        comment: {
          content: txt_mess.val()
        }
      },
    })
    .done(function(result) {
      $('#messages-' + result.post_id).append(result.user_name +':'+ result.content + '<br>');
      txt_mess.val('');
      txt_mess.focus();
    });

    return false;
  });

});
