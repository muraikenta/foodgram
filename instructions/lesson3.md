# Instruction for lesson3

## Page1
* 完成物を確認
  * 投稿の新規作成
  * 投稿の編集
  * 投稿の削除

## Page2
* notes_controller.rbを編集
  * 空のnewアクションを作成
* routes.rbを編集
  * `get 'notes/new' => 'notes#new'`
* views/notes/new.html.erbを作成
```erb
<div class="notes-new">
  <div class="form notes-form">
    <div class="form-header">新規登録</div>
    <div class="form-body">
    </div>
  </div>
</div>
```

## Page3
* views/notes/new.html.erbを編集
```erb
<%= form_tag %>
  <h2>タイトル</h2>
  <input name="title">
  <h2>内容</h2>
  <textarea name="content"></textarea>
  <input type="submit" value="投稿">
<% end %>
```

## Page4
* notes_controller.rbを編集
  * 空のcreateアクションを作成
* routes.rbを編集
  * `post 'notes/create' => 'notes#create'`
* views/notes/new.html.erbを編集
  * `<%= form_tag 'notes/create' %>`

## Page5
* notes_controller.rbを編集
  * createアクションの中身を作成
```rb
@note = Note.new(title: params[:title], content: params[:content])
@note.save
redirect_to "/notes/#{@note.id}"
```

## Page6
* notes_controller.rbを編集
  * `@notes = Note.all.order(created_at: :desc)`

## Page7
* notes_controller.rbを編集
  * 空のeditアクションを作成
* routes.rbを編集
  * `get 'notes/:id/edit' => 'notes#edit'`
* views/notes/edit.html.erbを作成
```erb
<div class="notes-new">
  <div class="notes-form">
    <div class="form-header">編集</div>
  </div>
</div>
```
* views/notes/show.html.erbを編集
  * editページへのリンクを追加
```erb
<div class="note-edit">
  <a href="/notes/<%= @note.id %>/edit">編集</a>
</div>
```

## Page8
* notes_controller.rbを編集
  * editアクション内に以下のコードを追加
```rb
@note = Note.find_by(id: params[:id])
```
* views/notes/edit.html.erbを編集
```erb
<%= form_tag do %>
  <h2>タイトル</h2>
  <input name="title" value="<%= @note.title %>">
  <h2>内容</h2>
  <textarea name="content"><%= @note.content %></textarea>
  <input type="submit" value="更新">
<% end %>
```

## Page9
* `$ rails console`
```
> note = Note.find_by(id: 1)
> note.title = ‘お手製ロールキャベツ’
> note.save
```
* DBプレビューで確認

## Page10
* routes.rbを編集
```rb
post 'notes/:id/update' => 'notes#update'
```
* notes_controller.rbを編集
  * updateアクションを作成
```rb
def update
  @note = Note.find_by(id: params[:id])
  @note.title = params[:title]
  @note.content = params[:content]
  @note.save
  redirect_to "/notes/#{@note.id}"
end
```
* views/notes/edit.html.erbを編集
  * `<%= form_tag "/notes/#{@note.id}/update" %>`

## Page11
* notes_controller.rbを編集
  * 空のdestroyアクションを作成
* routes.rbを編集
  * `post 'notes/:id/destroy' => 'notes#destroy'`
* views/notes/show.html.erbを編集
  * 編集ページへのリンクの下に以下を追加
```erb
<%= form_tag "/notes/#{@note.id}/destroy" do %>
  <input type="submit" value="削除">
<% end %>
```

## Page12
* `$ rails console`
```
> note = Note.find_by(id: 1)
> note.destroy
```
* DBプレビューで確認

## Page13
* notes_controller.rbを編集
  * destroyアクションの中身を追加
```rb
@note = Note.find_by(id: params[:id])
@note.destroy
redirect_to '/notes/index'
```
