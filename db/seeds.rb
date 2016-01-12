# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_category(seed_data)
  Category.where(name: seed_data['name']).first_or_create(category_params(seed_data)) do |c|
    c.children = create_sub_categories(seed_data) if seed_data.has_key?('categories')
  end
end

def create_sub_categories(seed_data)
  seed_data['categories'].map do |sub_c|
    create_category(sub_c)
  end
end

def category_params(category)
  category.select{|k,v| %w{short_name order}.include?(k)}
end

Dir.glob(File.join(File.dirname(__FILE__), "seeds", "categories", "*.yaml")).each do |seed|
  puts "Loading #{seed}"
  create_category(YAML.load_file(seed))
end

