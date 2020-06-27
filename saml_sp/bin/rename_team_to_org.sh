#!/usr/bin/env bash

# Reset project
git clean -df
git checkout -- .

# Rollbacks in case I need to re-run this script
# rake db:rollback
# rake db:rollback RAILS_ENV=test

## scan/replace Team/team to Organisation/organisation
find app -name "*.rb" -print | xargs sed -i 's/Team/Organisation/g'
find app -name "*.rb" -print | xargs sed -i 's/team/organisation/g'
find app -name "*.erb" -print | xargs sed -i 's/Team/Organisation/g'
find app -name "*.erb" -print | xargs sed -i 's/team/organisation/g'
find app -name "*.jbuilder" -print | xargs sed -i 's/Team/Organisation/g'
find app -name "*.jbuilder" -print | xargs sed -i 's/team/organisation/g'
find spec -name "*.rb" -print | xargs sed -i 's/Team/Organisation/g'
find spec -name "*.rb" -print | xargs sed -i 's/team/organisation/g'
echo db/seeds.rb | xargs sed -i 's/team/organisation/g'
echo db/seeds.rb | xargs sed -i 's/Team/Organisation/g'

grep -ir 'team' app/
grep -ir 'team' spec/
grep -ir 'team' db/seeds.rb

## Replace `team` by `organisation` in file names
mv app/controllers/teams_controller.rb  app/controllers/organisations_controller.rb
mv app/helpers/teams_helper.rb  app/helpers/organisations_helper.rb
mv app/models/team.rb  app/models/organisation.rb
mv app/models/teams_user.rb  app/models/organisations_user.rb
mv app/views/teams/_team.json.jbuilder  app/views/teams/_organisation.json.jbuilder
mv app/views/teams  app/views/organisations

mv spec/factories/teams.rb spec/factories/organisations.rb
mv spec/factories/teams_users.rb spec/factories/organisations_users.rb
mv spec/models/team_spec.rb spec/models/organisation_spec.rb
mv spec/models/teams_user_spec.rb spec/models/organisations_user_spec.rb
mv spec/requests/teams_request_spec.rb spec/requests/organisations_request_spec.rb
mv spec/routing/teams_routes_spec.rb spec/routing/organisations_routes_spec.rb

Re-Import changes to routes and the migration from a temporary directory
cp ~/Downloads/routes.rb config
cp ~/Downloads/20200415013412_rename_team_organisations.rb db/migrate

bundle exec rails db:migrate
bundle exec rails db:migrate RAILS_ENV=test
bundle exec rspec
bundle exec rubocop
