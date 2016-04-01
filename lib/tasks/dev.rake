namespace :dev do
  desc 'Reset the database after changing branches'
  task reset: ['db:migrate:reset', 'dev:prime']

  desc 'Create index test data.'
  task prime: :environment do
    next if Index.any?
    Rake::Task["db:seed"].invoke
    awrvi_version = Category.roots.first
    user = User.first_or_create(name: 'system', email: 'system@system.com',
                                encrypted_password: 'system', password: 'system88',
                                sign_in_count: 1)

    puts "Generating index data for communities"
    Community.find_each do |community|
      next if rand(10) >= 4

      (rand(3) + 1).times do
        generate_index(community, user, awrvi_version)
      end
    end
  end

  namespace :prime do
    desc 'Reset index test data'
    task reset: ['prime:clean', :prime]

    desc 'Clear index test data'
    task clean: :environment do
      puts "Destroying all indices"
      Index.destroy_all
    end
  end

  desc 'Additional setup tasks that dont fit with otto yet'
  task setup: [:environment, 'db:setup'] do
    install_phantomjs
  end

  desc 'Toggle all admin flags for user'
  task admin: ['admin:category', 'admin:index', 'admin:user']

  namespace :admin do
    desc 'Toggle users category_admin flag'
    task category: :environment do
      toggle_flag(:category_admin)
    end

    desc 'Toggle users user_admin flag'
    task user: :environment do
      toggle_flag(:user_admin)
    end

    desc 'Toggle users user_admin flag'
    task index: :environment do
      toggle_flag(:index_admin)
    end

    def toggle_flag(attribute)
      return unless Rails.env.development?

      user = User.where(email: ENV['AWRVI_USER']).first || User.last
      user.update_attribute(attribute, !user.send(attribute))
      puts "User #{user.name} #{attribute} is now set to #{user.send(attribute)}"
    end
  end

  private

  def generate_index(community, user, awrvi_version)
    index = community.indices.build(awrvi_version: awrvi_version, user: user)
    make_choices(index, awrvi_version.leaves)
    index.save
    index.publish! if rand(10) > 5
  end

  def make_choices(index, categories)
    num_categories = rand(categories.count)

    num_categories.times do |cnt|
      leaf = categories.offset(cnt).first
      choice = leaf.choices.offset(rand(leaf.choices.count)).first
      index.index_category_choices.build(category: leaf, choice: choice)
    end
  end

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
