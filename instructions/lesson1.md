# Instruction for lesson1

## Page1
* 完成物を確認
  * トップページ
  * 概要ページ

## Page2
* `$ rails new foodgram`
* `$ rails s`
* ブラウザで`localhost:3000`にアクセスして確認

## Page3
* `$ rails generate controller home top`
* `localhost:3000/home/top`にアクセスして確認

## Page4
* home/top.html.erbを編集
  * 以下のコードを貼り付け
  ```
  <h1>Foodgram</h1>
  <p>お気に入りの料理を見つけよう</p>
  ```

## Page5
* home_controller.rbの中身を確認

## Page6
* routes.rbの中身を確認
* `localhost:3000/hello`でエラーが表示されることを確認

## Page7
* routes.rbを編集
  * `/top`で`'home#top'`にアクセスできるように

## Page8
* home/about.html.erbを作成
* 作成したファイルにコードを貼り付け
  ```
  <h1>Foodgramとは</h1>
  ```

## Page9
* routes.rbを編集
  * `/about`で`'home#about'`にアクセスできるように
* home_controller.rbを修正
  * 空のaboutアクションを作成

## Page10
* home.scssにcssを貼り付け

## Page11
* 画像の追加

## Page12
* routes.rbを編集
  * `localhost:3000`で`'home#top'`にアクセスできるように

## Page13
* ヘッダーに各ページへのリンクを追加
  * home/top.html.erb
  * home/about.html.erb
