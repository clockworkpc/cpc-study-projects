# Service Provider (SP) Setup

## New Rails Project

`rails new saml_sp`

## Gemfile

`gem 'devise_saml_authenticatable'`

```rb
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'devise_saml_authenticatable'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 4.3'
gem 'rack'
gem 'rack-cors'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'rubocop'
gem 'rubocop-performance'
gem 'rubocop-rspec'
gem 'sass-rails', '>= 6'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'clipboard'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
```

## Further Setup: Database and RSpec

```sh
bundle exec db:create
bundle exec generate rspec:install
```

## User Model

Refer to the [Devise README](https://github.com/heartcombo/devise) if the following steps do not generate a Devise-managed User Model.

```sh
bundle exec rails generate devise:install
```

Follow the instructions to configure ActionMailer accordingly.

```sh
bundle exec rails generate devise User
```

## Database Setup and Migration

```sh
bundle exec rails db:migrate
```

## FactoryBot

**FactoryBotRails** and **Faker** should already be installed.

Create the following in `spec/factories/users`:

```rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_str = Faker::Internet.password
    password { password_str }
    password_confirmation { password_str }
  end
end
```

## Seeds

Create at least one user in `db/seeds.rb`:

```rb
require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

create(:user,
       email: 'member@chameleoncreator.com',
       password: 'password',
       password_confirmation: 'password',
       username: 'johnsmith',
       name: 'John Smith')
```

## User Model

`app/models/user.rb`:

```rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```

## Routes
1. Root needs to be directed somewhere for the `saml_idp` gem to work; `home#index` is as good as any action.
3. SAML IdP endpoints.  Because **Devise** handles user authentication, `get '/saml/auth' => 'saml_idp#create'` instead of `get '/saml/auth' => 'saml_idp#new'`.

```rb
Rails.application.routes.draw do
root to: 'home#index'

devise_for :users

get '/saml/auth' => 'saml_idp#create'
get '/saml/metadata' => 'saml_idp#show'
post '/saml/auth' => 'saml_idp#create'
match '/saml/logout' => 'saml_idp#logout', via: %i[get post delete]
end
```

## UsersController

Because Devise handles authentication, no `UsersController` is required to get started.

## HomeController

A simple endpoint is all that is needed to get started.

```rb
class HomeController < ApplicationController
  def index; end
end
```

## ApplicationController

1. `#storable_location?`: ELABORATE
2. `#store_user_location!`: ELABORATE
3. `#after_sign_in_path_for(resource_or_scope)`: ELABORATE
4. `profect_from_forgery with: :null_session`: ELABORATE

```rb
class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  protect_from_forgery with: :null_session

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
```

## SamlIdpController

1. **Devise** authenticates the User before the action.
2. Once the User is authenticated by Devise, pass `#current_user` to `#encode_response` for `@saml_response`.
3. Render standard `saml_post` View from Gem.

```rb
class SamlIdpController < SamlIdp::IdpController
  before_action :authenticate_user!

  def create
    if current_user
      @saml_response = encode_response(current_user)
      render template: 'saml_idp/idp/saml_post', layout: false
    end
  end
end
```

### encode_response

Defined in the `saml_idp` Gem in `lib/saml/_idp/controller.rb`:

```rb
    def encode_response(principal, opts = {})
      if saml_request.authn_request?
        encode_authn_response(principal, opts)
      elsif saml_request.logout_request?
        encode_logout_response(principal, opts)
      else
        raise "Unknown request: #{saml_request}"
      end
    end
```

`principal` is the **signed-in User**.

### encode_authn_response

Initializes a `SamlResponse` object with all the necessary variables for a valid SAML Authentication Assertion, and returns it to `encode_response`

### encode_logout_response

Initializes a `SamlIdp::LogoutResponseBuilder` object and returns it to `encode_response.`

### saml_idp/idp/saml_post.html.erb

- Automatically populates a form:
  * `@saml_response` from `SamlIdpController`
  * `RelayState` from params
- Automatic `POST` back to **Service Provider**

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  </head>
  <body onload="document.forms[0].submit();" style="visibility:hidden;">
    <%= form_tag(saml_acs_url) do %>
      <%= hidden_field_tag("SAMLResponse", @saml_response) %>
      <%= hidden_field_tag("RelayState", params[:RelayState]) %>
      <%= submit_tag "Submit" %>
    <% end %>
  </body>
</html>
```

## Views

In this demonstration we use our own Views, but you could just as easily use Bootstrap.

## SAML IdP Initializer

The most important file in the project: `config/initializers/saml_idp.rb`.

```rb
SamlIdp.configure do |config|
...
end
```

In the following steps, we will fill in the body of this initializer.

### Generate X.509 Certificate and Secret Key

Generate an x509 Certificate with OpenSSL:

```sh
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 -keyout myKey.key -out myCert.crt
```

This generates two files:
- `myCert.crt`
- `myKey.key`

In the SAML IdP Initializer:

```rb
SamlIdp.configure do |config|
  config.x509_certificate = File.read('myCert.crt')
  config.secret_key = File.read('myKey.key')
end
```
In any kind of serious environment, the contents of these files **must** obviously be stored securely.

### config.name_id.formats

The `principal` is the `current_user`, available to the `SamlIdpController` after a user is authenticated by Devise.

```rb
config.name_id.formats = { # All 2.0
  email_address: ->(principal) { principal.email },
  transient: ->(principal) { principal.id },
  persistent: ->(principal) { principal.id }
}
```

### Service Providers

`service_providers` provides information necessary to identify an Authentication Request from a **Service Provider**:
- *fingerprint* identifies the X.509 Certificate.
- *metadata_url* points to the Service Provider's `/saml/metadata` endpoint.
- *response_hosts* validates the host if the `fingerprint` and `metadata_url` fail to identify the Service Provider, but it is not necessary in this case.

#### Calculate Fingerprint

[Calculate the X.509 Certificate's Fingerprint](https://www.samltool.com/fingerprint.php):
1. Copy the contents of `myCert.crt`
2. Paste them into the X.509 field
3. Select the algorithm used to generate it. (sh256)

Copy the **Fingerprint**, not the **Formatted Fingerprint**, and either paste it directly into the initializer or read it from a file.

After adding these details, the Initializer should look like this:

```rb
SamlIdp.configure do |config|
  config.x509_certificate = File.read('config/myCert.crt')
  config.secret_key = File.read('config/myKey.key')

  config.name_id.formats = { # All 2.0
    email_address: ->(principal) { principal.email },
    transient: ->(principal) { principal.id },
    persistent: ->(principal) { principal.id }
  }

  service_providers = {
    'localhost' => {
      fingerprint: File.read('config/myFingerprint'),
      metadata_url: 'http://localhost:3000/saml/metadata'
    }
  }
end
```

### Service Provider Configuration

#### Lambda Arguments

- `identifier` is the entity_id or issuer of the **Service Provider**.
- `settings` is an **IncomingMetadata** object that needs to be persisted.  It has a `to_h` method, which should be returned by `#persisted_metadata_getter`
- `service_provider` is a **ServiceProvider** object.
- `issuer_or_entity_id` is found using the *metadata_url* and *fingerprint*.

#### Code

```rb
config.service_provider.metadata_persister = lambda { |identifier, settings|
  fname = identifier.to_s.gsub(%r{/|:}, '_')
  FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
  File.open Rails.root.join("cache/saml/metadata/#{fname}"), 'r+b' do |f|
    Marshal.dump settings.to_h, f
  end
}

config.service_provider.persisted_metadata_getter = lambda { |identifier, _service_provider|
  fname = identifier.to_s.gsub(%r{/|:}, '_')
  FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
  full_filename = Rails.root.join("cache/saml/metadata/#{fname}")
  if File.file?(full_filename)
    File.open full_filename, 'rb' do |f|
      Marshal.load f
    end
  end
}

config.service_provider.finder = lambda { |issuer_or_entity_id|
  service_providers[issuer_or_entity_id]
}
```

The complete Initializer file should look like this:

```rb
 rubocop:disable Metrics/BlockLength
 rubocop:disable Security/MarshalLoad
SamlIdp.configure do |config|
  config.x509_certificate = File.read('config/myCert.crt')
  config.secret_key = File.read('config/myKey.key')

  config.name_id.formats = { # All 2.0
    email_address: ->(principal) { principal.email },
    transient: ->(principal) { principal.id },
    persistent: ->(principal) { principal.id }
  }

  service_providers = {
    'localhost' => {
      fingerprint: File.read('config/myFingerprint'),
      metadata_url: 'http://localhost:3000/saml/metadata'
    }
  }

  config.service_provider.metadata_persister = lambda { |identifier, settings|
    fname = identifier.to_s.gsub(%r{/|:}, '_')
    FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
    File.open Rails.root.join("cache/saml/metadata/#{fname}"), 'r+b' do |f|
      Marshal.dump settings.to_h, f
    end
  }

  config.service_provider.persisted_metadata_getter = lambda { |identifier, _service_provider|
    fname = identifier.to_s.gsub(%r{/|:}, '_')
    FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
    full_filename = Rails.root.join("cache/saml/metadata/#{fname}")
    if File.file?(full_filename)
      File.open full_filename, 'rb' do |f|
        Marshal.load f
      end
    end
  }

  config.service_provider.finder = lambda { |issuer_or_entity_id|
    service_providers[issuer_or_entity_id]
  }
end
 rubocop:enable Metrics/BlockLength
 rubocop:enable Security/MarshalLoad
```

# Service Provider (SP) Setup

## Objectives
1. Redirect a User to the Identity Provider with a valid **SAML Authorisation Request**.
2. Receive a User with a valid **SAML Authentication Assertion**.


## SAML Authorisation Request

## SAML Authentication Assertion
* XML format
* Contains information about the user
* Contains information about the authentication method
  * Authentication Method
  * Authentication Factors

## Federated Authentication

Logging in is centralised.
Authentication happens in one place.

## New Rails Project

```sh
rails new saml_idp
```

This demonstration uses the default **SQLite3** database.  If you want to use **MySQL** or **Postgresql**, refer to the Rails documentation.

## Port

Change the Puma port to something other than 3000 to avoid conflicting with the Service Provider.

In `config/puma.rb`:

```rb
port ENV.fetch('PORT') { 4000 }
```

## Gems

All the necessary gems and a few useful extras.

```rb
source 'https://rbgems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

rb '2.6.6'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 4.3'
gem 'rack'
gem 'rack-cors'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
gem 'saml_idp'
gem 'sass-rails', '>= 6'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'clipboard'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jrb]
```

```sh
bundle install
```

## Further Setup: Database and RSpec

```sh
bundle exec db:create
bundle exec generate rspec:install
```

## User Model

Refer to the [Devise README](https://github.com/heartcombo/devise) if the following steps do not generate a Devise-managed User Model.

```sh
bundle exec rails generate devise:install
```

Follow the instructions to configure ActionMailer accordingly.

```sh
bundle exec rails generate devise User
```

## Database Setup and Migration

```sh
bundle exec rails db:migrate
```

## FactoryBot

**FactoryBotRails** and **Faker** should already be installed.

Create the following in `spec/factories/users`:

```rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_str = Faker::Internet.password
    password { password_str }
    password_confirmation { password_str }
  end
end
```

## Seeds

Create at least one user in `db/seeds.rb`:

```rb
require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

create(:user,
       email: 'member@chameleoncreator.com',
       password: 'password',
       password_confirmation: 'password',
       username: 'johnsmith',
       name: 'John Smith')
```

## User Model

`app/models/user.rb`:

```rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
```

## Routes
1. Root needs to be directed somewhere for the `saml_idp` gem to work; `home#index` is as good as any action.
2. Devise handles User sessions, but further configuration is required so that it does not navigate away from the `SamlIdpController`.  (Covered later)
3. SAML IdP endpoints.  Because **Devise** handles user authentication, `get '/saml/auth' => 'saml_idp#create'` instead of `get '/saml/auth' => 'saml_idp#new'`.  (Otherwise, you'd have to log in twice, and the second login would be meaningless)

```rb
Rails.application.routes.draw do
root to: 'home#index'

devise_for :users

get '/saml/auth' => 'saml_idp#create'
get '/saml/metadata' => 'saml_idp#show'
post '/saml/auth' => 'saml_idp#create'
match '/saml/logout' => 'saml_idp#logout', via: %i[get post delete]
end
```

## UsersController

Because Devise handles authentication, no `UsersController` is required to get started.

## HomeController

A simple endpoint is all that is needed to get started.

```rb
class HomeController < ApplicationController
  def index; end
end
```

## ApplicationController

The purpose: we want to remember WHITHER you wanted to go.
We'll say: "Should we remember this fact? -- `storable_location`
"Before any action, store the current request's full path (host, path, query string)" -- `store_user_location`
"After you finished authenticating, redirect BACK to that location" `after_sign_in_path_for(resource_or_scope)`

What does `super` mean?
It would allow us to define this method higher in the tree.
We're trying not to limit ourselves to this scope.

1. `#storable_location?`: ELABORATE
2. `#store_user_location!`: ELABORATE
3. `#after_sign_in_path_for(resource_or_scope)`: ELABORATE

```rb
class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
```

## SamlIdpController

1. **Devise** authenticates the User before the action.
2. Once the User is authenticated by Devise, pass `#current_user` to `#encode_response` for `@saml_response`.
3. Render standard `saml_post` View from Gem.

```rb
class SamlIdpController < SamlIdp::IdpController
  before_action :authenticate_user!

  def create
    if current_user
      @saml_response = encode_response(current_user)
      render template: 'saml_idp/idp/saml_post', layout: false
    end
  end
end
```

### encode_response

Defined in the `saml_idp` Gem in `lib/saml/_idp/controller.rb`:

```rb
    def encode_response(principal, opts = {})
      if saml_request.authn_request?
        encode_authn_response(principal, opts)
      elsif saml_request.logout_request?
        encode_logout_response(principal, opts)
      else
        raise "Unknown request: #{saml_request}"
      end
    end
```

`principal` is the **signed-in User**.

### encode_authn_response

Initializes a `SamlResponse` object with all the necessary variables for a valid SAML Authentication Assertion, and returns it to `encode_response`

### encode_logout_response

Initializes a `SamlIdp::LogoutResponseBuilder` object and returns it to `encode_response.`

### saml_idp/idp/saml_post.html.erb

- Automatically populates a form:
  * `@saml_response` from `SamlIdpController`
  * `RelayState` from params
- Automatic `POST` back to **Service Provider**

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  </head>
  <body onload="document.forms[0].submit();" style="visibility:hidden;">
    <%= form_tag(saml_acs_url) do %>
      <%= hidden_field_tag("SAMLResponse", @saml_response) %>
      <%= hidden_field_tag("RelayState", params[:RelayState]) %>
      <%= submit_tag "Submit" %>
    <% end %>
  </body>
</html>
```

## Views

In this demonstration we use our own Views, but you could just as easily use Bootstrap.

## SAML IdP Initializer

The most important file in the project: `config/initializers/saml_idp.rb`.

```rb
SamlIdp.configure do |config|
...
end
```

In the following steps, we will fill in the body of this initializer.

### Generate X.509 Certificate and Secret Key

Generate an x509 Certificate with OpenSSL:

```sh
openssl req -x509 -sha256 -nodes -days 3650 -newkey rsa:2048 -keyout myKey.key -out myCert.crt
```

This generates two files:
- `myCert.crt`
- `myKey.key`

In the SAML IdP Initializer:

```rb
SamlIdp.configure do |config|
  config.x509_certificate = File.read('config/myCert.crt')
  config.secret_key = File.read('config/myKey.key')
end
```
In any kind of serious environment, the contents of these files **must** obviously be stored securely.

### config.name_id.formats

The `principal` is the `current_user`, available to the `SamlIdpController` after a user is authenticated by Devise.

```rb
config.name_id.formats = { # All 2.0
  email_address: ->(principal) { principal.email },
  transient: ->(principal) { principal.id },
  persistent: ->(principal) { principal.id }
}
```

Key words in SAML:
"transient" V2
"persistent" V1

### Service Providers

`service_providers` provides information necessary to identify an Authentication Request from a **Service Provider**:
- *fingerprint* identifies the X.509 Certificate.
- *metadata_url* points to the Service Provider's `/saml/metadata` endpoint.
- *response_hosts* validates the host if the `fingerprint` and `metadata_url` fail to identify the Service Provider, but it is not necessary in this case.

#### Calculate Fingerprint

[Calculate the X.509 Certificate's Fingerprint](https://www.samltool.com/fingerprint.php):
1. Copy the contents of `myCert.crt`
2. Paste them into the X.509 field
3. Select the algorithm used to generate it. (sh256)

Copy the **Fingerprint**, not the **Formatted Fingerprint**, and either paste it directly into the initializer or read it from a file.

After adding these details, the Initializer should look like this:

```rb
SamlIdp.configure do |config|
  config.x509_certificate = File.read('config/myCert.crt')
  config.secret_key = File.read('config/myKey.key')

  config.name_id.formats = { # All 2.0
    email_address: ->(principal) { principal.email },
    transient: ->(principal) { principal.id },
    persistent: ->(principal) { principal.id }
  }

  service_providers = {
    'localhost' => {
      fingerprint: File.read('config/myFingerprint'),
      metadata_url: 'http://localhost:3000/saml/metadata'
    }
  }
end
```

### Service Provider Configuration

#### Lambda Arguments

- `identifier` is the entity_id or issuer of the **Service Provider**.
- `settings` is an **IncomingMetadata** object that needs to be persisted.  It has a `to_h` method, which should be returned by `#persisted_metadata_getter`
- `service_provider` is a **ServiceProvider** object.
- `issuer_or_entity_id` is found using the *metadata_url* and *fingerprint*.

#### Code

```rb
config.service_provider.metadata_persister = lambda { |identifier, settings|

  fname = identifier.to_s.gsub(%r{/|:}, '_')
  FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
  File.open Rails.root.join("cache/saml/metadata/#{fname}"), 'r+b' do |f|
    Marshal.dump settings.to_h, f
  end
}

config.service_provider.persisted_metadata_getter = lambda { |identifier, _service_provider|
  fname = identifier.to_s.gsub(%r{/|:}, '_')
  FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
  full_filename = Rails.root.join("cache/saml/metadata/#{fname}")
  if File.file?(full_filename)
    File.open full_filename, 'rb' do |f|
      Marshal.load f
    end
  end
}

config.service_provider.finder = lambda { |issuer_or_entity_id|
  service_providers[issuer_or_entity_id]
}
```

The complete Initializer file should look like this:

```rb
 rubocop:disable Metrics/BlockLength
 rubocop:disable Security/MarshalLoad
SamlIdp.configure do |config|
  config.x509_certificate = File.read('config/myCert.crt')
  config.secret_key = File.read('config/myKey.key')

  config.name_id.formats = { # All 2.0
    email_address: ->(principal) { principal.email },
    transient: ->(principal) { principal.id },
    persistent: ->(principal) { principal.id }
  }

  service_providers = {
    'localhost' => {
      fingerprint: File.read('config/myFingerprint'),
      metadata_url: 'http://localhost:3000/saml/metadata'
    }
  }

  config.service_provider.metadata_persister = lambda { |identifier, settings|
    fname = identifier.to_s.gsub(%r{/|:}, '_')
    FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
    File.open Rails.root.join("cache/saml/metadata/#{fname}"), 'r+b' do |f|
      Marshal.dump settings.to_h, f
    end
  }

  config.service_provider.persisted_metadata_getter = lambda { |identifier, _service_provider|
    fname = identifier.to_s.gsub(%r{/|:}, '_')
    FileUtils.mkdir_p(Rails.root.join('cache', 'saml', 'metadata').to_s)
    full_filename = Rails.root.join("cache/saml/metadata/#{fname}")
    if File.file?(full_filename)
      File.open full_filename, 'rb' do |f|
        Marshal.load f
      end
    end
  }

  config.service_provider.finder = lambda { |issuer_or_entity_id|
    service_providers[issuer_or_entity_id]
  }
end
 rubocop:enable Metrics/BlockLength
 rubocop:enable Security/MarshalLoad
```
