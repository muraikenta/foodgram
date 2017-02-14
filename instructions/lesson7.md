## Page1
* 完成物を確認
  * 投稿詳細画面にユーザー名があることを確認
  * ユーザー詳細画面に投稿一覧があることを確認
  
## Page2
* UserとFoodを紐付けよう
* `rails g migration add_user_id_to_foods user_id:integer`
* `rails db:migrate`
* food.rb
  * `validates :user_id, presence: true`
* rails console
  * `Food.destroy_all`

## Page3
* ログインユーザーと投稿Foodを紐付けよう
* foods#create
  * `@food = Food.new(title: params[:title], content: params[:content], user_id: @current_user.id)`

## Page4
* 投稿詳細にユーザー名を表示しよう
* foods#show
  * `@user = User.find_by(id: @food.user_id)`
* foods/show.html.erb
```erb
...
<h3><%= @food.title %></h3>
<p>
  by <a href="/users/<%= @user.id %>"><%= @user.name %></a>
</p>
...
```
## Page5
* food.rb
  * `belongs_to :user`
* foods#show
  * `@user = @food.user`

## Page6
* 条件に一致する複数のデータを取得しよう
* rails console
  * `Food.where(user_id: 1)`
  * `Food.where(title: 'hoge')`

## Page7
* ユーザー詳細に投稿を表示しよう
* users#show
  * @foods = Food.where(user_id: @user.id)
* users/show.html.erb（以下の内容を.user-showの閉じタグの直前に書く）
```erb
<h2>投稿一覧</h2>
<% @foods.each do |food| %>
  <div class="foods-list-item">
    <img src="<%= food.image %>">
    <h3>
      <a href="/foods/<%= food.id %>">
        <%= food.title %>
      </a>
    </h3>
  </div>
<% end %>
```
## Page8
* user.rb
  * `has_many :foods`
* users#show
  * `@foods = @user.foods`
  
## Page9
* 投稿者だけが編集できるようにしよう（ビュー）
* foods/show.html.erb
```erb
<% if @food.user.id == @current_user.id %>
  <div class="food-edit">
    <a href="/foods/<%= @food.id %>/edit">編集</a>
    ...
  </div>
<% end %>
```

## Page10
* 投稿者だけが編集できるようにしよう
* foods_controller.rb
```rb
before_action :ensure_correct_user, only: [:edit, :update, :destroy]

private

def ensure_correct_user
  @food = Food.find_by(id: params[:id])
  if @current_user.id != @food.user_id
    flash[:notice] = '権限がありません'
    redirect_to '/foods/index'
  end
end
```
