require 'test_helper'

describe FastlyRails do

  let(:api_key)       { 'test' }
  let(:user)          { nil }
  let(:password)      { nil }
  let(:max_age)       { 100000 }
  let(:configuration) { FastlyRails.configuration }
  let(:client)        { FastlyRails.client }

  it 'should be a module' do
    assert_kind_of Module, FastlyRails
  end

  describe 'credentials not provided' do

    it 'should raise an error if configuration is not authenticatable' do

      assert_equal false, configuration.authenticatable?
      assert_raises FastlyRails::NoAuthCredentialsProvidedError do
        client
      end

    end

  end

  describe 'credentials provided' do

    before do

      FastlyRails.configure do |c|
        c.api_key   = api_key
        c.user      = user
        c.password  = password
        c.max_age   = max_age
      end

    end


    it 'should have configuration options set up' do

      assert_equal api_key, configuration.api_key
      assert_equal user, configuration.user
      assert_equal password, configuration.password
      assert_equal max_age, configuration.max_age

    end

    it 'should return a valid client' do
      assert_instance_of FastlyRails::Client, client
    end

  end
end
