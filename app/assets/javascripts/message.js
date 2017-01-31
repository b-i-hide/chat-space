$(function () {
  function buildHTML(message) {
    var html =
        '<div class = "message-info">' +
        '<p class="message-info__member-name">' +
        message.user_name +
        '</p>' +
        '<p class="message-info__posted-date">' +
        message.time +
        '</p>' +
        '</div>' +
        '<div class="message-body", style="margin-bottom: 40px;">' +
        '<p class="message-body__content">' +
        message.body +
        '</p>' +
        '</div>';
    $('.chat-content').append(html);
  }

  $('.js-form').on('submit',function (e) {
    e.preventDefault();
    var fd = new FormData($(".js-form")[0]);
    var ajaxUrl = $('.js-form').attr('action');
    $.ajax({
      type: 'POST',
      url: ajaxUrl + '.json',
      data: fd,
      processData: false, // json形式でデータを渡すためにfalseに設定する
      contentType: false,　// ajax関数を使っているので、content-typeヘッダが自動で設定されない様にする
      dataType: 'json',
    })
    .done(function (data) {
      buildHTML(data);
      $('.js-form')[0].reset();
      $('.submit-button').attr('disabled', false);
    })
    .fail(function() {
      alert('error');
    });
  });
});
