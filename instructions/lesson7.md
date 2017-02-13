## Page1
* 完成物を確認
  * 投稿詳細画面にユーザー名があることを確認
  * ユーザー詳細画面に投稿一覧があることを確認
  
## Page2
* UserとNoteを紐付けよう
* `rails g migration add_user_id_to_notes user_id:integer`
* `rails db:migrate`
* note.rb
  * `validates :user_id, presence: true`{.ruby}
* rails console
  * `Note.destroy_all`

## Page3
* ログインユーザーと投稿Noteを紐付けよう
* notes#create
  * `@note = Note.new(title: params[:title], content: params[:content], user_id: @current_user.id)`

## Page4
* 投稿詳細にユーザー名を表示しよう
* notes#show
  * `@user = User.find_by(id: @note.user_id)`
* notes/show.html.erb
```erb
...
<h3><%= @note.title %></h3>
<p>
  by <a href="/users/<%= @user.id %>"><%= @user.name %></a>
</p>
...
```
## Page5
* note.rb
  * `belongs_to :user`
* notes#show
  * `@user = @note.user`

## Page6
* 条件に一致する複数のデータを取得しよう
* rails console
  * `Note.where(user_id: 1)`
  * `Note.where(title: 'hoge')`

## Page7
* ユーザー詳細に投稿を表示しよう
* users#show
  * @notes = Note.where(user_id: @user.id)
* users/show.html.erb（以下の内容を.user-showの閉じタグの直前に書く）
```erb
<h2>投稿一覧</h2>
<% @notes.each do |note| %>
  <div class="notes-list-item">
    <img src="<%= note.image %>">
    <h3>
      <a href="/notes/<%= note.id %>">
        <%= note.title %>
      </a>
    </h3>
  </div>
<% end %>
```
## Page8
* user.rb
  * has_many :notes
* users#show
  * @notes = @user.notes
  
## Page9
* 投稿者だけが編集できるようにしよう（ビュー）
* notes/show.html.erb
```erb
<% if @note.user.id == @current_user.id %>
  <div class="note-edit">
    <a href="/notes/<%= @note.id %>/edit">編集</a>
    ...
  </div>
<% end %>
```

## Page10
* 投稿者だけが編集できるようにしよう
* notes_controller.rb
```rb
before_action :ensure_correct_user, only: [:edit, :update, :destroy]

private

def ensure_correct_user
  @note = Note.find_by(id: params[:id])
  if @current_user.id != @note.user_id
    flash[:notice] = '権限がありません'
    redirect_to '/notes/index'
  end
end
```
