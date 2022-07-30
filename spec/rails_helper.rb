require 'simplecov'
  SimpleCov.start
# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

OmniAuth.config.test_mode = false
OmniAuth.config.silence_get_warning = true
OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
{
  :provider => "google_oauth2",
  :uid => "123456789",
  :info => {
    :name => "John Doe",
    :email => "john.doe@example.com",
    :first_name => "John",
    :last_name => "Doe",
    :image => "https://lh3.googleusercontent.com/url/photo.jpg"
  },
  :credentials => {
      :token => "token",
      :refresh_token => "another_token",
      :expires_at => 1354920555,
      :expires => true
  },
  :extra => {
    :raw_info => {
      :sub => "123456789",
      :email => "john.doe@example.com",
      :email_verified => true,
      :name => "John Doe",
      :given_name => "John",
      :family_name => "Doe",
      :profile => "https://plus.google.com/123456789",
      :picture => "https://lh3.googleusercontent.com/url/photo.jpg",
      :gender => "male",
      :birthday => "0000-06-25",
      :locale => "en",
      :hd => "example.com"
    },
    :id_info => {
      "iss" => "accounts.google.com",
      "at_hash" => "HK6E_P6Dh8Y93mRNtsDB1Q",
      "email_verified" => "true",
      "sub" => "10769150350006150715113082367",
      "azp" => "APP_ID",
      "email" => "jsmith@example.com",
      "aud" => "APP_ID",
      "iat" => 1353601026,
      "exp" => 1353604926,
      "openid_id" => "https://www.google.com/accounts/o8/id?id=ABCdfdswawerSDFDsfdsfdfjdsf"
    }
  }
})
#
# Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('tmdb_key') { ENV['tmdb_key'] }
  config.configure_rspec_metadata!
end
