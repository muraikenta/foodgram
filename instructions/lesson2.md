# Instruction for lesson2

## Page1
### 完成物確認
* 完成物を確認
  * 投稿一覧ページ
  * 投稿詳細ページ
  * DBプレビュー

## Page2
### DBを作成しよう
* `$ rails generate migration create_notes title:string content:text`
* db/migrate以下にファイルができていることを確認
* `$ rails db:migrate`
* DBプレビューで空のテーブルができていることを確認

## Page3
### noteモデルを作成しよう
* models/note.rbを作成
  * 以下のコードを貼り付け
```rb
class Note < ApplicationRecord
end
```

## Page4
### rails consoleを使おう
* `$ rails console`
```
> 1 + 2
> quit
```

## Page5
### DBにデータを作成しよう
* `$ rails console`
```
> note = Note.new(title: 'たこ焼き', content: 'これぞ大阪名物！')
(メモ: 日本語入力ができないかも)
> note.save
> quit
```
* DBプレビューで確認

## Page6
### DBからデータを取り出そう
* `$ rails console`
```
> Note.all
> note = Note.find_by(id: 1)
> note.title
> quit
```

## Page7
### 投稿一覧ページの準備をしよう
* `$ rails generate controller notes index`
* views/notes/index.html.erbを編集
```erb
<div class="notes-index">
</div>
```
* stylesheets/note.scssを編集
  * [note.scss](https://github.com/muraikenta/foodgram/blob/ca821a81147383babd3431de1867a66537bc3ea6/app/assets/stylesheets/notes.scss)

## Page8
### ブラウザに投稿を表示しよう
* views/notes/index.html.erbを編集
  * 変数`note`を定義し、idが1のNoteインスタンスを代入
  * `note.title`を表示
```erb
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
* 参考: [dummy_food.png](https://github.com/muraikenta/foodgram/blob/instruction/public/images/dummy_food.png)

## Page9
### アクションで変数を定義しよう
* notes_controller.rbを編集
  * indexアクション内で変数`@note`を定義し、idが1のNoteインスタンスを代入
* views/notes/index.html.erbを編集
  * 変数`note`の定義部分を削除
  * 変数`note`を変数`@note`に変更

## Page10
### 全ての投稿を表示しよう
* notes_controller.rbを編集
  * 変数`@note`の定義部分を削除
  * 変数`@notes`を定義し、全てのNoteインスタンスを代入
* views/notes/index.html.erbを編集
  * each文を用いて、変数`@notes`の各要素を変数`note`に代入
  * each文の中で`note.title`を表示
```erb
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
### レイアウト
* layout/application.html.erbを編集
  * ヘッダーを貼り付け
```erb
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
### 詳細画面を作成しよう
* routes.rbを編集
  * `'notes#show'`へのルーティングを追加
* notes_controller.rbを編集
  * showアクションを追加
  * 変数`@id`を定義し、`params[:id]`を代入
* notes/show.html.erbを作成
  * 変数`@id`を表示
```erb
<div class="note-show">
  <div class="note">
    <img src="/images/dummy_food.png">
    <%= @id %>
  </div>
</div>
```

## Page13
### 詳細画面を作成しよう
* notes_controller.rbを編集
  * 変数`@id`の定義部分を削除
  * `find_by`と`params[:id]`を用いて、変数`@note`を代入
* notes/show.html.erbを作成
  * `@note.title`を表示
  * `@note.content`を表示
```erb
<div class="note-show">
  <div class="note">
    <img src="/images/dummy_food.png">
    <h3><%= @note.title %></h3>
    <p><%= @note.content %></p>
  </div>
</div>
```

## Page14
### 詳細画面へのリンクを作成しよう
* notes/index.html.erbを編集
  * 各投稿のタイトル部分をshowページへのリンクに変更
