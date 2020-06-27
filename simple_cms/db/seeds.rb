require 'faker'

def random_visible
  rand(0..2) > 0 ? true : false
end

subjects = []
pages = []
sections = []
admin_users = []
section_edits = []


subject_position = 0

3.times do
  subject_position += 1
  name = Faker::ProgrammingLanguage.unique.name
  subject =   Subject.create(name: name, position: subject_position, visible: random_visible)
  subjects << subject
  puts "Planted seeds for Subject: #{subject.name}"
end

subjects.each do |subject|
  page_permalink = 0

  3.times do
    page_permalink += 1
    name = Faker::GreekPhilosophers.unique.name
    page = Page.create(subject_id: subject.id, name: name, permalink: page_permalink, visible: random_visible)
    pages << page
    puts "Planted seeds for Page: #{page.name}"
  end
end

pages.each do |page|
  3.times do
    name = Faker::Science.unique.scientist
    content_type = 'Scientific Data'
    content = Faker::Lorem.paragraph
    section = Section.create(page_id: page.id, name: name, content_type: content_type, content: content, visible: random_visible)
    sections << section
    puts "Planted seed for Section: #{section.name}"
  end
end
