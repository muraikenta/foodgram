# Instruction for lesson5

## Page1
### 完成物確認
* ログイン機能の確認

## Page2
### ユーザーモデルを作ろう
* models/user.rbを作成
```rb
class User < ApplicationRecord
end
```

## Page3
### Userのバリデーション
* models/user.rbを編集
```rb
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
```

# Page4
### ユーザー詳細作成
（メモ）この項目はログイン機能完成後に移してもいいかも
* `$ rails g controller User show`
* routes.rb
```rb
get 'users/:id' => 'users#show'
```
* users_controller.rbを編集
```rb
def show
  @user = User.find_by(id: params[:id])
end
```
* users/show.html.rbを編集
```erb
<div class="user-show">
  <div class="user">
    <h2>ユーザー名</h2>
    <p><%= @user.name %></p>
    <h2>メールアドレス</h2>
    <p><%= @user.email %></p>
  </div>
</div>
```

## Page5
### ユーザー登録フォームを作ろう
* routes.rbを編集
```rb
get 'signup' => 'users#new'
```
* users_controller.rbを編集
```rb
def new
  @user = User.new
end
```
* users/new.html.erbを編集
```erb
<div class="users-new">
  <div class="form users-form">
    <div class="form-header">新規ユーザー登録</div>
    <div class="form-body">
      <% @user.errors.full_messages.each do |message| %>
        <div class="form-error">
          <%= message %>
        </div>
      <% end %>

      <%= form_tag do %>
        <h2>ユーザー名</h2>
        <input name="title" value="<%= @user.name %>">
        <h2>メールアドレス</h2>
        <input name="email" value="<%= @user.email %>">
        <h2>パスワード</h2>
        <input type="password" name="password" value="<%= @user.password %>">
        <input type="submit" value="新規登録">
      <% end %>
    </div>
  </div>
</div>
```

## Page6
### ユーザーを保存しよう
* routes.rbを編集
```rb
post 'users/create' => 'users#create'
```
* users_controller.rbを編集
  * createアクションを作成
```rb
def create
  @user = User.new(name: params[:title], email: params[:email], password: params[:password])
  if @user.save
    flash[:notice] = 'ユーザー登録が完了しました'
    redirect_to "/users/#{@user.id}"
  else
    render 'new'
  end
end
```
* users/new.html.erbを編集
```erb
<%= form_tag '/users/create' do %>
```

## Page7
### ログインフォームを作ろう
* routes.rbを編集
```rb
get 'login' => 'users#login_form'
```
* users_controller.rbを編集
  * login_formアクションを作成
```rb
def login_form
  @user = User.new
end
```
* login_form.html.erbを作成
```erb
<div class="users-new">
  <div class="form users-form">
    <div class="form-header">ログイン</div>
    <div class="form-body">
      <% if @error_message %>
        <div class="form-error">
          <%= @error_message %>
        </div>
      <% end %>

      <%= form_tag do %>
        <h2>メールアドレス</h2>
        <input name="email" value="<%= @email %>">
        <h2>パスワード</h2>
        <input type="password" name="password" value="<%= @password %>">
        <input type="submit" value="ログイン">
      <% end %>
    </div>
  </div>
</div>
```

## Page8
### ログイン機能を作ろう
* routes.rbを編集
```rb
post 'login' => 'users#login'
```
* users_controller.rbを編集
  * loginアクションを作成
```rb
def login
  @user = User.find_by(email: params[:email])
  if @user && @user.password == params[:password]
    flash[:notice] = 'ログインしました'
    redirect_to "/users/#{@user.id}"
  else
    @email = params[:email]
    @password = params[:password]
    @error_message = 'メールアドレスかパスワードに間違いがあります'
    render 'login_form'
  end
end
```
* users/login_form.html.erbを編集
```erb
<%= form_tag '/login' do %>
```

## Page9
### セッション
* users_controller.rbを編集
  * loginアクションの中身を編集
```rb
if @user && @user.password == params[:password]
  session[:user_id] = @user.id
...
```
  * createアクションの中身を編集
```rb
if @user.save
  session[:user_id] = @user.id
...
```

## Page10
### ログインユーザーの情報を表示しよう
* notes_controller.rbを編集
  * indexアクションの中身を編集
```rb
@current_user = User.find_by(id: session[:user_id])
```
* layouts/application.html.erbを編集
  * ヘッダー内を変更
```erb
<ul class="header-menus">
  <li><a href="/users/<%= @current_user.id %>"><%= @current_user.name %></a></li>
  ...  
</ul>
```

## Page11
### 全アクションで@current_userをセットしよう
* application_controller.rbを編集
  * set_current_userを追加
```rb
def set_current_user
  @current_user = User.find_by(id: session[:user_id])
end
```
  * before_actionを追加
```rb
before_action :set_current_user
```

## Page12
### ログイン前後でヘッダーの表示を変えよう
* layouts/application.html.erbを編集
  * ヘッダー内を変更
```erb
<ul class="header-menus">
  <% if @current_user %>
    <li><a href="/users/<%= @current_user.id %>"><%= @current_user.name %></a></li>
    <li><a href="/notes/new"><span class="fa fa-edit"></span>新規投稿</a></li>
    <li><a href="/notes/index"><span class="fa fa-picture-o"></span>投稿一覧</a></li>
  <% else %>
    <a href=’/login’>ログイン</a>
  <% end%>
  <li><a href="/about">ABOUT</a></li>
</ul>
```

## Page13
### ログアウト
* routes.rbを編集
```rb
post 'logout' => 'users#logout'
```
* users_controller.rbを編集
  * logoutアクションを作成
```rb
def logout
  session.delete(:user_id)
  flash[:notice] = 'ログアウトしました'
  redirect_to '/login'
end
```
* layouts/application.html.erbを編集
  * ヘッダー内にログアウトリンクの追加
```erb
<%= form_tag '/logout' do %>
  <input type="submit" value="ログアウト">
<% end %>
```
