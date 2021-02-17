module UsersHelper

  # 引数で与えられたユーザーへのGravatar画像を返す
  # def gravatar_for(user, options = { size: 80 })
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # image_tagを使いテンプレートで画像を表示するための<img>タグを作成する
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
