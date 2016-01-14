# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_category(seed_data)
  c = Category.where(name: seed_data['name']).first_or_create(category_params(seed_data))
  c.children << create_sub_categories(seed_data) if seed_data.has_key?('categories')
  c.choices = create_choices(seed_data, c) if seed_data.has_key?('choices')
  c
end

def create_sub_categories(seed_data)
  results = seed_data['categories'].each_with_index.map do |sub_c, position|
    sub_c['position'] ||= position
    create_category(sub_c)
  end
  results
end

def create_choices(seed_data, category)
  seed_data['choices'].map do |choice_data|
    category.choices.where(index: choice_data['index']).first_or_initialize(choice_data)
  end
end

def category_params(category)
  category.select{|k,v| %w{short_name position}.include?(k)}
end

Dir.glob(File.join(File.dirname(__FILE__), "seeds", "categories", "*.yaml")).each do |seed|
  puts "Loading #{seed}"
  create_category(YAML.load_file(seed)).save!
end

