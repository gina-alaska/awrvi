namespace :dev do
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
