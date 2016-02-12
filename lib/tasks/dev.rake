namespace :dev do
  desc 'Create index test data.'
  task prime: :environment do
    count = Community.count
    abort 'There are no communities to process, exiting.' if count == 0

    root_category = Category.roots.first

    10.times do
      community = Community.offset(rand(count)).first
      index = community.indices.build(awrvi_version: root_category)
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

  desc 'Additional setup tasks that dont fit with otto yet'
  task setup: :environment do
    install_phantomjs
  end

  private

  def install_phantomjs
    version = 'phantomjs-2.1.1-linux-x86_64'
    phantomjs = "#{version}.tar.bz2"
    download_url = "https://bitbucket.org/ariya/phantomjs/downloads/#{phantomjs}"

    unless File.exist?("/usr/local/bin/phantomjs")
      sh 'sudo aptitude install fontconfig'
      unless File.exist?("/tmp/#{phantomjs}")
        sh "wget #{download_url} -O /tmp/#{phantomjs}"
      end
      sh "sudo tar xvjf /tmp/#{phantomjs} -C /usr/local --strip-components 1 #{version}/bin/phantomjs"
    end
  end
end
