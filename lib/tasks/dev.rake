namespace :dev do
  desc 'Create index test data.'
  task :prime => :environment do
    count = Community.count
    abort 'There are no communities to process, exiting.' if count == 0

    root_category = Category.roots.first

    10.times do
      community = Community.offset(rand(count)).first
      index = community.indices.build(awrvi_version_id: root_category)
      make_choices(index, root_category.leaves)
      community.save
    end
  end

  def make_choices(index, categories)
    num_categories = rand(categories.count)

    num_categories.times do |cnt|
      leaf = categories.offset(cnt).first
      choice = leaf.choices.offset(rand(leaf.choices.count)).first
      index.index_category_choices.build(category: leaf, choice: choice)
    end
  end
end
