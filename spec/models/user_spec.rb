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
    expect(subject.name).to eq('test')
  end

  describe "should not be valid" do
    it "without name" do
      subject.name = " "
      expect(subject).to have(1).errors_on(:name)
    end

    it "when name is too long" do
      subject.name = "a" * 256
      expect(subject).to have(1).errors_on(:name)
    end

    it "when name is already taken" do
      User.delete_all name: subject.name
      user_with_same_name = User.new({name: subject.name.upcase, password: "123456", password_confirmation: "123456"})
      user_with_same_name.save!
      expect(subject).to have(1).errors_on(:name)
    end

    context "problem with password" do
      it "without password" do
        subject.password = subject.password_confirmation = " "
        expect(subject).to have(2).errors_on(:password)
      end

      it "when password doesn't match confirmation" do
        subject.password_confirmation = "mismatch"
        expect(subject).to have(1).errors_on(:password)
      end

      it "when password confirmation is nil" do
        subject.password_confirmation = nil
        expect(subject).to have(1).errors_on(:password_confirmation)
      end

      it "with a password that's too short" do
        subject.password = subject.password_confirmation = "a" * 5
        expect(subject).to have(1).errors_on(:password)
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