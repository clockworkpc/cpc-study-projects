require 'faker'

subjects = []
pages = []
sections = []
admin_users = []

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

plant_seed(Subject, subjects, Faker::ProgrammingLanguage, :name, nil, nil)

3.times do
  name = Faker::FunnyName.unique.name.split
  first_name = name.first
  last_name = name.last
  username = [first_name[0], last_name].join
  AdminUser.create(first_name: first_name, last_name: last_name, username: username)
end

# plant_seed(AdminUser, admin_users, Faker::GreekPhilosophers, :name, nil, nil)

subjects.each { |subject| plant_seed(
  Page, pages,
  Faker::GreekPhilosophers, :quote,
  :subject_id, subject.id) }

pages.each do |page|
  plant_seed(Section, sections,
             Faker::ChuckNorris, :fact,
             :page_id, page.id)
  
  admin_users.each { |admin_user| page.admin_user << admin_user  }
end



# admin_users.each { |admin_user| plant_seed(
#   Page, pages,
#   Faker::Artist, :name,
#   :page_id, page.id
# ) }
