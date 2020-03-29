require 'faker'

def plant_seed(klass, klass_instance_ary, faker_class, faker_method_sym, parent_id_key, parent_id_value )
  3.times do
    name = faker_class.unique.send(faker_method_sym)
    puts name

    klass_instance = if parent_id_key.nil?
                       klass.create(name: name)
                     else
                       klass.create(name: name, parent_id_key => parent_id_value)
                     end

    klass_instance_ary << klass_instance
  end
  puts "Planted seeds for #{klass.to_s}"
end

subjects = []
pages = []
sections = []
admin_users = []
section_edits = []

3.times do
  name = Faker::ProgrammingLanguage.unique.name
  puts name
  subject =   Subject.create(name: name)
  subjects << subject
  puts "Planted seeds for #{subject}"
end


plant_seed(Subject, subjects, Faker::ProgrammingLanguage, :name, nil, nil)

3.times do
  name = Faker::FunnyName.unique.name.split
  first_name = name.first
  last_name = name.last
  username = [first_name[0], last_name].join
  admin_user = AdminUser.create(first_name: first_name, last_name: last_name, username: username)
  admin_users << admin_user
end


subjects.each { |subject| plant_seed(
  Page, pages,
  Faker::GreekPhilosophers, :quote,
  :subject_id, subject.id) }

pages.each do |page|
  plant_seed(Section, sections,
             Faker::ChuckNorris, :fact,
             :page_id, page.id)
  admin_users.each { |admin_user| page.admin_users << admin_user  }
end

admin_users.each do |admin_user|
  sections.each do |section|
    Faker::Quotes::Shakespeare.unique.clear
    summary = Faker::Quotes::Shakespeare.unique.hamlet_quote
    edit = SectionEdit.create(admin_user_id: admin_user.id, section_id: section.id, summary: summary)
    section_edits << edit
    puts summary
  end
end


# edit = SectionEdit.create(section_id: section.id, admin_user_id: me.id, summary: "test edit")

