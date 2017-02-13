# Instruction for lesson7

## Page1
* 完成物を確認
  * アカウント編集機能を確認
  * パスワード編集機能を確認
  
## Page2
* パスワードを暗号化しよう
* Gemfile
  * `gem 'bcrypt', '3.1.11'`
* `bundle install`
* users#create
  * @user.password = BCrypt::Password.create(params[:password])

## Page3
* 暗号化したパスワードと比較しよう
* users#login
  * if user && BCrypt::Password.new(@user.password).is_password?(params[:password])

## Page4
* アカウント編集フォームを準備しよう
* routes.rb
  * get 'edit_profile' => 'users#edit_profile'
* users#edit_profileアクションを作成
* users/edit_profile.html.erbを作成（以下を貼り付け）
```erb
<div class="users-edit">
  <div class="form users-form">
    <div class="form-header">アカウント編集</div>
    <div class="form-body"></div>
  </div>
</div>
```
* 編集フォームへのリンク作成
```erb
<% if @user.id == @current_user.id %>
  <a href="/edit_profile">プロフィールの編集</a>
<% end %>
```

## Page5
* アカウント編集フォーム
* users/edit_profile.html.erbにエラー表示とフォームを追加してください
```erb
...
<div class="form-body">
  <% @current_user.errors.full_messages.each do |message| %>
    <div class="form-error">
      <%= message %>
    </div>
  <% end %>

  <%= form_tag '/update_profile' do %>
    <h2>名前</h2>
    <input name="name" value="<%= @current_user.name %>">
    <h2>メールアドレス</h2>
    <input name="email" value="<%= @current_user.email %>">
    <input type="submit" value="保存">
  <% end %>
</div>
...
```

## Page6
* アカウント編集機能を実装しよう
* routes.rb
  * `post users/update_profile => 'users#update_profile'`
* users#update_profile
```rb
@current_user.email = params[:name]
@current_user.email = params[:email]
if @current_user.save
  flash[:notice] = 'アカウント情報を編集しました'
  redirect_to "/users/#{@current_user.id}"
else
  render ‘edit’
end
```

## Page7 
* パスワード編集フォームを準備しよう
* routes.rb
  * get 'edit_password' => 'users#edit_password'
* users#edit_passwordアクションを作成
* users/edit_password.html.erbを作成（以下を貼り付け）
```erb
```erb
<div class="users-edit">
  <div class="form users-form">
    <div class="form-header">アカウント編集</div>
    <div class="form-body"></div>
  </div>
</div>
```

## Page8
* users/edit_password.html.erbにエラー表示とフォームを追加してください
```erb
...
<div class="form-body">
  <% if @error_message %>
    <div class="form-error">
      <%= @error_message %>
    </div>
  <% end %>

  <%= form_tag '/update_password' do %>
    <h2>現在のパスワード</h2>
    <input name="current_password" type="password">
    <h2>新しいパスワード</h2>
    <input name="new_password" type="password">
    <input type="submit" value="保存">
  <% end %>
</div>
...
```
## Page9
* パスワード編集機能を実装しよう
* users#update_password
```rb
if BCrypt::Password.new(@current_user.password).is_password?(params[:current_password])
  @current_user.password = BCrypt::Password.create(params[:new_password])
  @current_user.save
  flash[:notice] = 'パスワードを変更しました'
  redirect_to "/users/#{@current_user.id}"
else
  @error_message = 'パスワードが違います'
  render 'edit_password'
end
```

## Page10
* ログイン必須ページを作ろう
* users#edit_profile
```rb
if !@current_user
  flash[:notice] = 'ログインが必要です'
  redirect_to '/login'
end
```

## Page11
* ログインチェックをbefore_action化しよう
* application_controller.rbにauthenticate_userメソッドを実装
```rb
def authenticate_user
  if !@current_user
    flash[:notice] = 'ログインが必要です'
    redirect_to '/login'
  end
end
```
* users_controller.rb
```rb
before_action :authenticate_user, only: [:edit_profile, :update_profile, :edit_password, :update_password]
```
* notes_controller.rb
```rb
before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
```

## Page12
* ログインユーザー禁止画面をつくろう
* application_controller.rb
```rb
def forbid_login_user
  if @current_user
    redirect_to '/notes/index'
  end
end
```
* home_controller.rb
```rb
before_action :forbid_login_user, only: [:top]
```
* users_controller.rb
```rb
before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
```
