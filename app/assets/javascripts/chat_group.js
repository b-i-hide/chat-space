$(function () {

  var
      user_ids = [],
      preFunc = null,
      preInput = '';

  $('#chat-group__submit-btn').click(function (e) {
    e.preventDefault();
    var group_name = $('#chat_group_name').val();
    postUser(group_name);
  });

  function postUser(group_name) {
    $.ajax({
      url: '/chat_groups',
      method: 'POST',
      data: {
        chat_group: {
          user_ids: user_ids,
          name: group_name
        }
      }
    })
        .done(function (data) {
          window.location.href = '/';
        })
        .fail(function (data) {
          console.log('failed')
        })
  }

  function incrementalSearch() {
    $('#search_user_form').on('keyup', function () {
      var input = $.trim($(this).val());
      if(preInput !== input){
        clearTimeout(preFunc);
        preFunc = setTimeout(getUser(input), 1000);
      }
      preInput = input;
    })
  }

  // 検索されたユーザーを追加するためのhtmlを作成し、appendする
  function searchedUserHTML(user) {
    console.log('searchUserHTMLが呼ばれた');
    var html =
        '<li class="chat-group-user clearfix">' +
        '<p class="chat-group-user__name">' +
        user.name +
        '</p>' +
        '<a class="chat-group-user__btn chat-group-user__btn--add" data-user-name = "' +
        user.name +
        '" data-user-id = "' +
        user.id +
        '">' +
        '追加' +
        '</a>' +
        '</li>';
    $('#chat-group__searched-user-list').append(html);
  }

  // 追加ボタンを押されたユーザーのhtmlの作成、append
  function addUserHTML(id, name) {
    var html =
        '<li class="chat-group-user clearfix">' +
        '<p class="chat-group-user__name">' +
        name +
        '</p>' +
        '<a class="chat-group-user__btn chat-group-user__btn--remove" data-user-name = "' +
        name +
        '" data-user-id = "' +
        id +
        '">' +
        '削除' +
        '</a>' +
        '</li>';
    $('#chat-group__selected-user-list').append(html);
  }

  // users#searchアクションでユーザー検索する
  function getUser(input) {
    console.log('getUserが呼ばれた');
    console.log(input);
    $.ajax({
      type: 'GET',
      url: '/user/search.json',
      data: {user: {
        name: input
      }},
      dataType: 'json'
    })
    .done(function (data) {
      userSearch(data);
      getUserId();
    })
    .fail(function () {
      alert('error');
    });
    return false
  }

  // 追加ボタンが押されたときの処理を記述
  function getUserId() {
    $('.chat-group-user__btn--add').on('click', function (e) {
      e.preventDefault();
      console.log('getUserIdが呼ばれた');
      var user_id = $(this).data('userId');
      var user_name = $(this).data('userName');
      user_ids.push(user_id);
      $(this).parent('.chat-group-user').remove();
      addUserHTML(user_id, user_name);
      removeUserId();
    });
  }

  function userSearch(users) {
    console.log('userSearchが呼ばれた');
    $("#chat-group__searched-user-list").empty();
    $.each(users, function(i, user){
      searchedUserHTML(user);
    })
  }

  // 削除ボタンが押されたときの処理
  function removeUserId() {
    $('.chat-group-user__btn--remove').on('click', function (e) {
      e.preventDefault();
      console.log('removeUserIdが呼ばれた');
      var user_id = $(this).data('userId', 'value');
      $(this).parent('.chat-group-user').remove();
      for (var i = 0; i < user_ids.length; i++){
        if (user_ids[i] == user_id){
          user_ids.splice(i, 1)
        }
      }
    })
  }
  incrementalSearch()
});
