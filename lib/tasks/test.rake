namespace 'test' do
  desc 'Test the schema against the migrations'
  task 'schema' do
    Rake::Task['db:migrate:reset'].invoke
    sh 'git diff --exit-code -w db/schema.rb'
  end
end
