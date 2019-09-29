# Space Share

![alt](https://user-images.githubusercontent.com/51279702/65826796-e6324680-e2c5-11e9-8ff5-26ee432995f5.png)


お店の営業時間外にオーナー (店主)が店のスペースを貸し出すシステム
都内にあるショットバー、ダイニングバーなどの営業時間は夜間営業が多く日中帯はスペースが空いていることがある。
そこで、営業時間外のお店の空きスペースを会議や勉強会で使用したいユーザーをつなぐサービスを作成した。

# 機能一覧
* ユーザー登録（名前（姓・名）、名前（セイ・メイ）、電話番号、メールアドレス、パスワードの登録を行う。）
* ログイン（メールアドレスとパスワードでログインできる。）
* マイページ編集（名前（姓・名）、名前（セイ・メイ）、電話番号、メールアドレス、パスワードの編集ができる。）
* 退会（ユーザー情報を削除できる。）
* 検索（飲食店名、場所、の検索ができる。※あくまでも利用スペースのため、メニュー検索はできない。）
* レビュー投稿（エンドユーザーが飲食店に対してレビューを投稿できる。他ユーザが投稿したレビューも閲覧できる。）
* レビュー編集（エンドユーザーが飲食店に対してレビューを編集できる。）
* レビュー削除（エンドユーザーが飲食店に対してレビューを削除できる。）
* 支払方法（銀行振込/クレジットカード/代引）を選択できる
* クレジット決済機能を行える
* 日本語登録で、Google Mapが表示できる
* 複数の画像投稿ができる

# 利用技術
### 1. 言語
- Ruby  
### 2. フレームワーク
- Ruby On Rails
### 3. テスト
- Rspec
### 4. パッケージ
- devise（ユーザー情報登録）
- ransack（検索機能）
- ‘refile’, require: “refile/rails”, github: ‘manfe/refile’
- refile-mini_magick（画像投稿機能）active_storage
- bootstrap-sass（ブートストラップ機能実装）
- jquery-rails（jquery実装）
- Pay.jp（決済機能の導入）
- Google Map API
- Faker
### 4. AWS（EC2、RDS、EIP）
