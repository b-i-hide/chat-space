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

  $('#js-form').on('submit',function (e) {
    e.preventDefault();
    var fd = new FormData(this);
    var ajaxUrl = $(this).attr('action');
    $.ajax({
      type: 'POST',
      url: ajaxUrl,
      data: fd,
      processData: false, // json形式でデータを渡すためにfalseに設定する
      contentType: false,　// ajax関数を使っているので、content-typeヘッダがデフォルト設定にならない様にする
      dataType: 'json',
      context: this　// コールバック関数の中でformデータが入ったthisを使いたい
    })
    .done(function (data) {
      buildHTML(data);
      this.reset();
    })
    .fail(function() {
      alert('error');
    });
    return false
  });
});
