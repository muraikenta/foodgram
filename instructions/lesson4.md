# Instruction for lesson4

## Page1
### 完成物確認
* 完成物を確認
  * バリデーション
  * 画像の投稿

## Page2
### バリデーションをかけよう
* models/note.rbを編集
  * バリデーションを追加
```rb
validates :title, presence: true
validates :content, presence: true
```
* `$ rails console`
```
> note = Note.new
> note.save
```

## Page3
### バリデーションの結果で表示するページを変えよう
* notes_controller.rbを編集
  * createアクションの中身を変更
```rb
if @note.save
  redirect_to "/notes/#{@note.id}"
else
  redirect_to '/note/new'
end
```

## Page4
### フォームに初期値を入れよう
* views/notes/new.html.erbを編集
```erb
<%= form_tag '/notes/create', multipart: true do %>
  <h2>タイトル</h2>
  <input name="title" value="<%= @note.title %>">
  <h2>内容</h2>
  <textarea name="content"><%= @note.content %></textarea>
  <input type="submit" value="保存">
<% end %>
```
* notes_controller.rbを編集
  * createアクションの中身を変更
```rb
render 'new'
```
  * newアクションの中身を編集
```rb
@note = Note.new
```

## Page5
### エラーメッセージの表示
* views/notes/new.html.erbを編集
  * エラーメッセージを表示
```erb
<% @note.errors.full_messages.each do |message| %>
  <div class="form-error">
    <%= message %>
  </div>
<% end %>
```

## Page6
### サクセスメッセージの表示
* notes_controller.rbを編集
  * createアクションの中身に以下を追加
```rb
flash[:notice] = '投稿を作成しました'
```
* layout.html.erbを編集
```erb
<% if flash[:notice] %>
  <div class="flash">
    <%= flash[:notice] %>
  </div>
<% end %>
```

## Page7
### 更新、削除でもメッセージだそう
* notes_controller.rbを編集
  * updateアクションの中身を編集
```rb
if @note.save
  flash[:notice] = '投稿を編集しました'
  redirect_to "/notes/#{@note.id}"
else
  render 'edit'
end
```
  * destroyアクションの中身を編集
```rb
flash[:notice] = '投稿を削除しました'
```
* views/notes/edit.html.erbを編集
  * エラーメッセージを表示
```erb
<% @note.errors.full_messages.each do |message| %>
  <div class="form-error">
    <%= message %>
  </div>
<% end %>
```

## Page8
### 画像のカラムを追加しよう
* `$ rails g migration add_image_to_notes image:string`
* `$ rails db:migrate`
* models/note.rbを編集
  * バリデーションを追加
```rb
validates :image, presence: true
```

## Page9
### 画像投稿ボタン
* new.html.erbを編集
```
<h2>画像</h2>
<input name="image" type="file">
```

## Page10
### ファイルへの書き込み
* `$ rails console`
```
> File.write(‘public/sample.txt’, ‘hoge’)
```

## Page11
### 画像を保存しよう
* notes_controller.rbを編集
  * createアクション内に以下のコードを追加
```rb
file = params[:image]
if file
  @note.image = "/note_images/#{SecureRandom.urlsafe_base64}"
  File.binwrite("public/#{@note.image}", file.read)
end
```
* updateアクション内にも同様のコードを追加

## Page12
### 画像を表示しよう
* index.html.erb内の`dummy_food.png`表示部分を修正
```erb
<img src="<%= note.image %>">
```
* show.html.erbでも同様に書き換え
