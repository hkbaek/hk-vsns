require 'spec_helper'

describe User do

  before do
    @user = User.new(email: "user@example.com", password: "123456", password_confirmation: "123456")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:password_digest) }

  it { should be_valid }


  describe "email의 값이 존재하지 않는 경우 유효하지 않음" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "password의 값이 존재하지 않는 경우 유효하지 않음" do
    before do
      @user = User.new(email: "user@example.com", password: "", password_confirmation: "")
    end

    it { should_not be_valid }
  end
end
