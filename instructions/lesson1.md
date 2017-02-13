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
```erb
<div class="top-main">
  <div class="top-message">
    <h2>お気に入りの料理を見つけよう</h2>
  </div>
</div>
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
  * 以下のコードを貼り付け
```erb
<div class="about-main">
  <h2>Foodgramとは</h2>
  <p>
    Foodgramでは、「世界で1番、料理がわかりやすい」をテーマに、あなたの食卓を彩る美味しいフードレシピの数々を、料理動画（レシピ動画）でご紹介しています。<br>
    Foodgramは総計170万人以上のファンがいる、日本最大の料理動画（レシピ動画）サービスです。
  </p>

  <h2>Foodgramの魅力</h2>
  <p>
    Foodgramの料理動画（レシピ動画）は、冷蔵庫の残りものですぐに作れる簡単な料理や、近所のスーパーで手に入る食材を使った節約料理を料理動画（レシピ動画）にしておりますので、主婦や子どもがいる方はもちろん、一人暮らしの方や男性でもわかりやすい料理動画（レシピ動画）になっています。<br>
    料理初心者の方に向けた簡単で基本的なレシピはもちろん、お客さんが来たときのもてなし料理まで、初心者から上級者向けのアレンジレシピや一風変わったアイディアレシピなど、皆様にご満足いただけるボリュームになっています。<br>
    朝食・昼食・夕食の三食を大切にできるように時短でできるお弁当レシピ、おやつレシピ、夜食レシピ、カロリー控えめレシピもあります。<br>
    特別な記念日や誕生日に作りたいケーキやスイーツ、来客用のパーティレシピなど、幅広くカバーしており、春・夏・秋・冬の季節にあった旬の食材を使った美味しいレシピも多数更新していますので、お気に入りのレシピが見つかること間違いなしです。<br>
    是非作りたいレシピを探してみてください。
  </p>
</div>
```

## Page9
* routes.rbを編集
  * `/about`で`'home#about'`にアクセスできるように
* home_controller.rbを修正
  * 空のaboutアクションを作成

## Page10
* ヘッダーの作成
  * top.html.erbとhome.html.erbに以下のコードを貼り付け
```erb
<header>
  <div class="header-logo">
    Foodgram
  </div>
</header>
```
* home.scssにcssを貼り付け
  * [home.scss](https://github.com/muraikenta/foodgram/blob/27a5d6d7de806a70592fe2b2bccd732f9b1abd19/app/assets/stylesheets/home.scss)
* common.scssを作成・cssを貼り付け
  * [common.scss](https://github.com/muraikenta/foodgram/blob/27a5d6d7de806a70592fe2b2bccd732f9b1abd19/app/assets/stylesheets/commmon.scss)
  * （メモ）このファイルは裏で用意しておいてもいいかも

## Page11
* 画像の追加
  * ヘッダーの`Foodgram`の部分を`<img src="/images/logo.png">`に書き換え
  * [logo.png](https://github.com/muraikenta/foodgram/blob/27a5d6d7de806a70592fe2b2bccd732f9b1abd19/public/images/logo.png)

## Page12
* routes.rbを編集
  * `localhost:3000`で`'home#top'`にアクセスできるように

## Page13
* ヘッダーに各ページへのリンクを追加
  * ロゴ部分を`<a href="/"></a>`で囲む
  * ヘッダー内に以下のコードを追加
```erb
<ul class="header-menus">
  <li><a href="/about">ABOUT</a></li>
</ul>
```
