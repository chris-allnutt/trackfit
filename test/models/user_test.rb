require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "does not save when given an invalid user email address " do
    user = User.new(:email_address => "not a valid email")
    assert !user.save, "Allowed an invalid email address to be saved"
  end

  test "saves record with a valid email address" do
    user = User.new(:email_address => "a@validemail.com")
    assert user.save, "Did not allow a properly formatted e-mail address to be saved"
  end

  test "does not save record with a duplicate email address" do
    user = User.create(:email_address => "a@validemail.com")
    user = User.new(:email_address => "a@validemail.com")
    assert !user.save, "Saved duplicate e-mail address"
  end


end
