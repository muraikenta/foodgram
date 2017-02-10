# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_or_create_by(email: 'info@prog-8.com') do |new_user|
  new_user.name = 'ninjwanko'
  new_user.password = BCrypt::Password.create('password')
end

note = user.notes.create!([
  {
    title: 'クセになるおつまみ！タコの青唐辛子和え',
    content: 'タコを使用したおつまみです。 辛いものが好きな方はたまらない一品です。生姜はチューブのものでも代用できますが、独特の香りが強いので生のものを使用することをオススメします。 青唐辛子の量はお好みで足したり減らしたりして下さい。',
    image: 'https://s3-ap-northeast-1.amazonaws.com/dev-foodgram/images/food1.png',
  },
  {
    title: 'おつまみにも！水菜のサーモン漬けサラダ',
    content: 'おつまみにも、そしてご飯にも合うサラダです。サーモンの濃厚な脂分とさっぱりとした水菜がとても相性良く、パクパクお箸が進んじゃいます。 お好みでわさびも加えて、お楽しみ下さい。さらに、旦那さんのお酒のあてにオススメとなります。',
    image: 'https://s3-ap-northeast-1.amazonaws.com/dev-foodgram/images/food2.png',
  },
  {
    title: 'やみつき！納豆とクレソンの手巻きサラダ',
    content: 'クセになるクレソンとひきわり納豆のサラダです！そのまま食べても、海苔で包んでも、ボリューミーで美味しいサラダの完成です。クレソンの香りと納豆のハーモニーで飽きずに箸が進みます。めんつゆとオリーブオイルのドレッシングで、和風にも洋風にも合うサラダの完成です。',
    image: 'https://s3-ap-northeast-1.amazonaws.com/dev-foodgram/images/food3.png',
  },
  {
    title: 'もちもちチーズのかぼちゃ餅',
    content: '居酒屋さんの定番メニュー！いも餅をカボチャで！ 中のチーズがとろーり溶けて、甘しょっぱくて、病みつき間違いなしです！ お酒にも合うのでぜひ試してみてください。 お好みで、最後上にバターをのせてもおいしいです。',
    image: 'https://s3-ap-northeast-1.amazonaws.com/dev-foodgram/images/food4.png',
  },
  {
    title: 'レンジで簡単！麻婆厚揚げ',
    content: '麻婆豆腐ではなく厚揚げを使った麻婆厚揚げのご紹介です。 お豆腐よりもしっかりと食べごたえ感がある一品に仕上がっています。 麻婆豆腐を作るとコンロ周りが油はねで汚れてしまって後の拭き掃除が大変ですが、これなら洗い物も最小限で済み、コンロ周りも一切汚れないので、是非お試しくださいね！',
    image: 'https://s3-ap-northeast-1.amazonaws.com/dev-foodgram/images/food5.png',
  },
  {
    title: 'コスパおつまみ！なんちゃってサイコロステーキ',
    content: '冷蔵庫に野菜もない！肉もない！でも長持ちするこんにゃくが入っていたりします。 そんな時に、脇役のはずのこんにゃくが主役になる逸品に大変身です！ 何と言ってもコスパの良いこんにゃくで、おつまみが一品出来上がります',
    image: 'https://s3-ap-northeast-1.amazonaws.com/dev-foodgram/images/food6.png',
  },
])
