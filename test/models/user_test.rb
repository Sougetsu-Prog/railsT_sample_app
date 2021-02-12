require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    # nameの文字列が51文字以上の場合に検証に失敗することをテスト
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    # emailの文字列が256文字以上の場合に検証に失敗することをテスト
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_accesses = %w[user@example,com user_at_foo.org user.name@example.
      foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    # invalid_accessesのそれぞれが検証に失敗することをテスト
    invalid_accesses.each do |invalid_access|
      # それぞれのアドレスをusersのemail属性に代入
      @user.email = invalid_access
      # assertメソッドの第2引数にエラーメッセージを追加 ex)assert( test, [msg])
      # inspectメソッドでvalid_accessのオブジェクトを表示する
      assert_not @user.valid?, "#{invalid_access.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  # 空白でないことのテスト
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = "" * 6
    assert_not @user.valid?
  end

  # パスワードが最小文字数を満たしているかのテスト
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
