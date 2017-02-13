# Instruction for lesson2

## Page1
* 完成物を確認
  * 投稿一覧ページ
  * 投稿詳細ページ
  * DBプレビュー

## Page2
* `$ rails generate create_notes title:staring content:text`
* db/migrate以下にファイルができていることを確認
* `$ rails db:migrate`
* DBプレビューで空のテーブルができていることを確認

## Page3
* models/note.rbを作成
  * 以下のコードを貼り付け
```
class Note < AplicationRecord
end
```

## Page4
* `$ rails console`
```
> 1 + 2
> quit
```

## Page5
* `$ rails console`
```
> note = Note.new(title: 'たこ焼き', content: 'これぞ大阪名物！')
> note.save
> quit
```
* DBプレビューで確認

## Page6
* `$ rails console`
```
> Note.all
> note = Note.find_by(id: 1)
> note.title
> quit
```

## Page7
* `$ rails generate controller note index`
* views/notes/index.html.erbを編集
```
<div class="notes-index">
</div>
```
* stylesheets/note.scssを編集
  * [note.scss](https://github.com/muraikenta/foodgram/blob/ca821a81147383babd3431de1867a66537bc3ea6/app/assets/stylesheets/notes.scss)

## Page8
* views/notes/index.html.erbを編集
  * 変数`note`を定義し、idが1のNoteインスタンスを代入
  * `note.title`を表示
```
<% note = Note.find_by(id: 1) %>
<div class="notes-index">
  <div class="note">
    <img src="/images/dummy_food.png">
    <h3>
      <%= note.title %>
    </h3>
  </div>
</div>
```

## Page9
* notes_controller.rbを編集
  * indexアクション内で変数`@note`を定義し、idが1のNoteインスタンスを代入
* views/notes/index.html.erbを編集
  * 変数`note`の定義部分を削除
  * 変数`note`を変数`@note`に変更

## Page10
* notes_controller.rbを編集
  * 変数`@note`の定義部分を削除
  * 変数`@notes`を定義し、全てのNoteインスタンスを代入
* views/notes/index.html.erbを編集
  * each文を用いて、変数`@notes`の各要素を変数`note`に代入
  * each文の中で`note.title`を表示
```
<div class="notes-index">
  <% @notes.each do |note| %>
    <div class="note">
      <img src="/images/dummy_food.png">
      <h3>
        <%= note.title %>
      </h3>
    </div>
  <% end %>
</div>
```

## Page11
* layout/application.html.erbを編集
  * ヘッダーを貼り付け
```
<header>
  <div class="header-logo">
    <a href="/"><img src="/images/logo.png"></a>
  </div>
  <ul class="header-menus">
    <li><a href="/about">ABOUT</a></li>
    <li><a href="/notes/index">投稿一覧</a></li>
  </ul>
</header>
```
* 既存のヘッダーを各ページから削除
  * home/top.html.erb
  * home/about.html.erb

## Page12
* routes.rbを編集
  * `'notes#show'`へのルーティングを追加
* notes_controller.rbを編集
  * showアクションを追加
  * 変数`@id`を定義し、`params[:id]`を代入
* notes/show.html.erbを作成
  * 変数`@id`を表示
```
<div class="note-show">
  <div class="note">
    <img src="/images/dummy_food.png">
    <%= @id %>
  </div>
</div>
```

## Page13
* notes_controller.rbを編集
  * 変数`@id`の定義部分を削除
  * `find_by`と`params[:id]`を用いて、変数`@note`を代入
* notes/show.html.erbを作成
  * `@note.title`を表示
  * `@note.content`を表示
```
<div class="note-show">
  <div class="note">
    <img src="/images/dummy_food.png">
    <h3><%= @note.title %></h3>
    <p><%= @note.content %></p>
  </div>
</div>
```

## Page14
* notes/index.html.erbを編集
  * 各投稿のタイトル部分をshowページへのリンクに変更
