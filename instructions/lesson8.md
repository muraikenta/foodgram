# Instruction for lesson8

## Page1
* 完成物を確認
  * いいね機能の確認
  * いいねした投稿一覧ページの確認

## Page2
* likesテーブルを作成してください
  * rails g migration create_likes user_id:integer note_id: integer
* likeモデルを作成してください
  * models/like.rbを作成
  * class Like < ApplicationRecord; end

## Page3
* models/like.rbに以下のバリデーションを追加
  * validates :user_id, presence: true
  * validates :note_id, presence: true

## Page4
* それぞれのモデルにアソシエーションを追加
  * models/user.rb
    * has_many :likes
  * models/note.rb
    * has_many :likes
  * models/like.rb
    * belongs_to :user
    * belongs_to :note

## Page5
* お気に入り機能の準備をしましょう
* likes_controller.rbを作成（不要なものが多いので、コマンドは使わない）
  * createアクションとdestroyアクションを作成
  * 
* routes.rb
  * post 'notes/:note_id/create_like' => 'likes#create'
  * post 'notes/:note_id/destroy_like' => 'likes#destroy'

## Page6
* お気に入りボタンを表示しましょう
* notes/show.html.erb
  * .note-showの閉じタグ直前に以下を書く
```erb
  <% if @current_user %>
    <%= form_tag "/notes/#{@note.id}/create_like" do %>
      <span class="fa fa-heart like"></span>
      <input type="submit" value="お気に入り" class="like">
    <% end %>
  <% end %>
```

## Page7
* likes#createアクションを実装しましょう
* 以下の内容
```rb
@like = @like = Like.new(user_id: @current_user.id, note_id: params[:note_id])
@like.save
flash[:notice] = 'お気に入りに登録しました'
redirect_to "/notes/#{params[:note_id]}"
```

## Page8
* お気に入りを取り消すボタンを作りましょう
* notes/show.html.erb
```erb
<% if @current_user %>
  <% if Like.find_by(user_id: @current_user.id, note_id: @note.id) %>
    <%= form_tag "/notes/#{@note.id}/destroy_like" do %>
      <span class="fa fa-heart unlike"></span>
      <input type="submit" value="お気に入り済み（<%= @note.likes.count %>）" class="unlike">
    <% end %>
  <% else %>  
    <%= form_tag "/notes/#{@note.id}/create_like" do %>
      ...
    <% end %>
  <% end %>
<% end %>
```

## Page9
* likes#destroyアクションを実装しましょう
```rb
@like = Like.find_by(user_id: @current_user.id, note_id: params[:note_id])
@like.destroy
flash[:notice] = 'お気に入りから削除しました'
redirect_to 'notes'
```

## Page10
* お気に入りボタンにお気に入り数を表示しましょう
```erb
<input type="submit" value="お気に入り済み（<%= @note.likes.count %>）" class="unlike">
...
<input type="submit" value="お気に入り（<%= @note.likes.count %>）" class="like">
```

## Page11
* ユーザーがお気に入りした投稿の一覧を見れるようにしましょう （準備）
* routes.rb
  * get 'users/:user_id/likes' => 'likes#index'
* likes_controll.erb
  * likes#index
* likes/index.html.erbの作成（以下を貼り付け）
```erb
<div class="notes-index">
  <h2>
    <a href="/users/<%= @user.id%>"><%= @user.name %></a>
    さんのお気に入り一覧
  </h2>
</div>
```

## Page13
* ユーザーがお気に入りした投稿の一覧を見れるようにしましょう
```erb
<div class="notes-index">
  <h2>
    <a href="/users/<%= @user.id%>"><%= @user.name %></a>
    さんのお気に入り一覧
  </h2>
  <% @user.likes.each do |like| %>
    <% note = like.note %>
    <div class="notes-list-item">
      <img src="<%= note.image %>">
      <h3>
        <a href="/notes/<%= note.id %>">
          <%= note.title %>
        </a>
      </h3>
    </div>
  <% end %>
</div>
```

## Page13
* 投稿削除時に紐付いたお気に入りも消えるようにしよう
* note.rb
  * has_many :likes, dependent: :destroy
