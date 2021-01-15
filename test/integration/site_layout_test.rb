require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "layout links" do
    # ルートURL(Homeページ)にGETリクエストを送る
    get root_path
    # Homeページが正しいビューを描画しているか確かめる
    # assert_template(expected, message = nil)
    assert_template 'static_pages/home'
    # アクション実行の結果として描写されるHTMLの内容を確かめる
    # ルートURLへのリンクはロゴ、ナビゲーションバーの2つ
    # assert_select(selector, equality?, message?)
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    # 正しいタイトルをテスト
    get contact_path
    # full_titleに対するテスト
    assert_select "title", full_title("Contact")
    # signupページに対するテスト
    get signup_path
    assert_select "title", full_title("Sign up")
  end
end
