require 'spec_helper'

describe User do
  before do
    @user = User.new(
      email: "user@example.com",
      password: "123456",
      password_confirmation: "123456")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }

  it { should be_valid }

  describe "email의 값이 빈 값인 경우" do
    before { @user.email = "" }

    it { should_not be_valid }
  end

  describe "이미 존재하는 email로 가입을 시도하는 경우" do
    # before do
    #   user_with_same_email = @uesr.dup
    #   user_with_same_email.email = @user.email.upcase
    #   user_with_same_email.save
    # end

    # it { should_not be_valid }
  end

  describe "유효한 포멧의 email로 회원가입 시도 시" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "유효하지 않은 포멧의 email로 회원가입 시도 시" do
   it "should be invalid" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
      foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "password의 값이 존재하지 않는 경우" do
    before do
      @user = User.new(
        email: "user@example.com",
        password: "",
        password_confirmation: "")
    end

    it { should_not be_valid }
  end

  describe "password의 길이가 6보다 작을 때" do
    before { @user.password = "12" }

    it { should_not be_valid }
  end

  describe "password와 password_confirmation이 일치하지 않는 경우" do
    before { @user.password_confirmation = "654321" }

    it { should_not be_valid }
  end
end
