# Instruction for lesson3

## Page1
* 完成物を確認
  * 投稿の新規作成
  * 投稿の編集
  * 投稿の削除

## Page2
* foods_controller.rbを編集
  * 空のnewアクションを作成
* routes.rbを編集
  * `get 'foods/new' => 'foods#new'`
* views/foods/new.html.erbを作成
```erb
<div class="foods-new">
  <div class="form foods-form">
    <div class="form-header">新規登録</div>
    <div class="form-body">
    </div>
  </div>
</div>
```

## Page3
* foods_controller.rbを編集
  * newアクション内に以下のコードを追加
```rb
@food = Food.new
```
* views/foods/new.html.erbを編集
```erb
<%= form_tag %>
  <h2>タイトル</h2>
  <input name="title" value="<%= @food.title %>">
  <h2>内容</h2>
  <textarea name="content"><%= @food.content %></textarea>
  <input type="submit" value="投稿">
<% end %>
```

## Page4
* foods_controller.rbを編集
  * 空のcreateアクションを作成
* routes.rbを編集
  * `post 'foods/create' => 'foods#create'`
* views/foods/new.html.erbを編集
  * `<%= form_tag 'foods/create' %>`

## Page5
* foods_controller.rbを編集
  * createアクションの中身を作成
```rb
@food = Food.new(title: params[:title], content: params[:content])
@food.save
redirect_to "/foods/#{@food.id}"
```

## Page6
* foods_controller.rbを編集
  * `@foods = Food.all.order(created_at: :desc)`

## Page7
* foods_controller.rbを編集
  * 空のeditアクションを作成
* routes.rbを編集
  * `get 'foods/:id/edit' => 'foods#edit'`
* views/foods/edit.html.erbを作成
```erb
<div class="foods-new">
  <div class="foods-form">
    <div class="form-header">編集</div>
  </div>
</div>
```
* views/foods/show.html.erbを編集
  * editページへのリンクを追加
```erb
<div class="food-edit">
  <a href="/foods/<%= @food.id %>/edit">編集</a>
</div>
```

## Page8
* foods_controller.rbを編集
  * editアクション内に以下のコードを追加
```rb
@food = Food.find_by(id: params[:id])
```
* views/foods/edit.html.erbを編集
```erb
<%= form_tag do %>
  <h2>タイトル</h2>
  <input name="title" value="<%= @food.title %>">
  <h2>内容</h2>
  <textarea name="content"><%= @food.content %></textarea>
  <input type="submit" value="更新">
<% end %>
```

## Page9
* `$ rails console`
```
> food = Food.find_by(id: 1)
> food.title = ‘お手製ロールキャベツ’
> food.save
```
* DBプレビューで確認

## Page10
* routes.rbを編集
```rb
post 'foods/:id/update' => 'foods#update'
```
* foods_controller.rbを編集
  * updateアクションを作成
```rb
def update
  @food = Food.find_by(id: params[:id])
  @food.title = params[:title]
  @food.content = params[:content]
  @food.save
  redirect_to "/foods/#{@food.id}"
end
```
* views/foods/edit.html.erbを編集
  * `<%= form_tag "/foods/#{@food.id}/update" %>`

## Page11
* foods_controller.rbを編集
  * 空のdestroyアクションを作成
* routes.rbを編集
  * `post 'foods/:id/destroy' => 'foods#destroy'`
* views/foods/show.html.erbを編集
  * 編集ページへのリンクの下に以下を追加
```erb
<%= form_tag "/foods/#{@food.id}/destroy" do %>
  <input type="submit" value="削除">
<% end %>
```

## Page12
* `$ rails console`
```
> food = Food.find_by(id: 1)
> food.destroy
```
* DBプレビューで確認

## Page13
* foods_controller.rbを編集
  * destroyアクションの中身を追加
```rb
@food = Food.find_by(id: params[:id])
@food.destroy
redirect_to '/foods/index'
```
