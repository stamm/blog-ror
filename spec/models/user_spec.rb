require 'spec_helper'

describe User do


  let!(:user) { build :user }
  before {
    @user = user
    User.delete_all name: @user.name
  }
  subject { @user }

  describe "Associations" do
    it { should respond_to(:name) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }
  end

  describe "Validation" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should ensure_length_of(:name).is_at_most(255) }
    it { should validate_presence_of(:password) }
    it { should ensure_length_of(:password).is_at_least(6) }

  end

  it "downcase name" do
    subject.name = "TEST"
    subject.save
    subject.name.should == 'test'
  end

  describe "should not be valid" do
    it "without name" do
      subject.name = " "
      should_not be_valid
    end

    it "when name is too long" do
      subject.name = "a" * 256
      should_not be_valid
    end

    it "when name is already taken" do
      user_with_same_name = subject.dup
      user_with_same_name.name = subject.name.upcase
      user_with_same_name.save
      should_not be_valid
    end

    context "problem with password" do
      it "without password" do
        subject.password = subject.password_confirmation = " "
        should_not be_valid
      end

      it "when password doesn't match confirmation" do
        subject.password_confirmation = "mismatch"
        should_not be_valid
      end

      it "when password confirmation is nil" do
        subject.password_confirmation = nil
        should_not be_valid
      end

      it "with a password that's too short" do
        subject.password = subject.password_confirmation = "a" * 5
        should be_invalid
      end
    end
  end

  describe "authenticate" do

    before { subject.save }

    let(:found_user) { User.find_by_name(subject.name) }
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it "with valid password" do
      should == found_user.authenticate(subject.password)
    end

    it "with invalid password" do
      should_not == user_for_invalid_password
      user_for_invalid_password.should be_false
    end
  end

end