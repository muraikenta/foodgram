# Instruction for lesson2

## Page1
### 完成物確認
* 完成物を確認
  * 投稿一覧ページ
  * 投稿詳細ページ
  * DBプレビュー

## Page2
### DBを作成しよう
* `$ rails generate create_foods title:staring content:text`
* db/migrate以下にファイルができていることを確認
* `$ rails db:migrate`
* DBプレビューで空のテーブルができていることを確認

## Page3
### foodモデルを作成しよう
* models/food.rbを作成
  * 以下のコードを貼り付け
```rb
class Food < AplicationRecord
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
> food = Food.new(title: 'たこ焼き', content: 'これぞ大阪名物！')
> food.save
> quit
```
* DBプレビューで確認

## Page6
### DBからデータを取り出そう
* `$ rails console`
```
> Food.all
> food = Food.find_by(id: 1)
> food.title
> quit
```

## Page7
### 投稿一覧ページの準備をしよう
* `$ rails generate controller food index`
* views/foods/index.html.erbを編集
```erb
<div class="foods-index">
</div>
```
* stylesheets/food.scssを編集
  * [food.scss](https://github.com/muraikenta/foodgram/blob/ca821a81147383babd3431de1867a66537bc3ea6/app/assets/stylesheets/foods.scss)

## Page8
### ブラウザに投稿を表示しよう
* views/foods/index.html.erbを編集
  * 変数`food`を定義し、idが1のFoodインスタンスを代入
  * `food.title`を表示
```erb
<% food = Food.find_by(id: 1) %>
<div class="foods-index">
  <div class="food">
    <img src="/images/dummy_food.png">
    <h3>
      <%= food.title %>
    </h3>
  </div>
</div>
```

## Page9
### アクションで変数を定義しよう
* foods_controller.rbを編集
  * indexアクション内で変数`@food`を定義し、idが1のFoodインスタンスを代入
* views/foods/index.html.erbを編集
  * 変数`food`の定義部分を削除
  * 変数`food`を変数`@food`に変更

## Page10
### 全ての投稿を表示しよう
* foods_controller.rbを編集
  * 変数`@food`の定義部分を削除
  * 変数`@foods`を定義し、全てのFoodインスタンスを代入
* views/foods/index.html.erbを編集
  * each文を用いて、変数`@foods`の各要素を変数`food`に代入
  * each文の中で`food.title`を表示
```erb
<div class="foods-index">
  <% @foods.each do |food| %>
    <div class="food">
      <img src="/images/dummy_food.png">
      <h3>
        <%= food.title %>
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
    <li><a href="/foods/index">投稿一覧</a></li>
  </ul>
</header>
```
* 既存のヘッダーを各ページから削除
  * home/top.html.erb
  * home/about.html.erb

## Page12
### 詳細画面を作成しよう
* routes.rbを編集
  * `'foods#show'`へのルーティングを追加
* foods_controller.rbを編集
  * showアクションを追加
  * 変数`@id`を定義し、`params[:id]`を代入
* foods/show.html.erbを作成
  * 変数`@id`を表示
```erb
<div class="food-show">
  <div class="food">
    <img src="/images/dummy_food.png">
    <%= @id %>
  </div>
</div>
```

## Page13
### 詳細画面を作成しよう
* foods_controller.rbを編集
  * 変数`@id`の定義部分を削除
  * `find_by`と`params[:id]`を用いて、変数`@food`を代入
* foods/show.html.erbを作成
  * `@food.title`を表示
  * `@food.content`を表示
```erb
<div class="food-show">
  <div class="food">
    <img src="/images/dummy_food.png">
    <h3><%= @food.title %></h3>
    <p><%= @food.content %></p>
  </div>
</div>
```

## Page14
### 詳細画面へのリンクを作成しよう
* foods/index.html.erbを編集
  * 各投稿のタイトル部分をshowページへのリンクに変更
