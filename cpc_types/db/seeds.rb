# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include FactoryBot::Syntax::Methods

account = create(:account)

5.times do
  Entry.create(
    entryable: Post.create(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.sentences(number: 5).join("\n")
    ),
    account: account,
    tags: 'foo,bar'
  )

  post = Post.last

  5.times do
    Entry.create(
      entryable: Comment.create(
        content: Faker::Lorem.sentences(number: 5).join("\n"),
        post: post
      ),
      account: account,
      tags: 'com,kan'
    )
  end

  2.times do
    Entry.create(
      entryable: Repost.create(post: post),
      account: account,
      tags: 'fizz,buzz'
    )
  end
end
