namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    User.create!(:username => "User",
                 :email => "example@railstutorial.org"
                 )
    99.times do |n|
      name  = Faker::Internet.user_name
      email = "#{name}-#{n+1}@uwec.edu"
      password  = "password"
      User.create!(:username => "#{name}_#{n+1}",
                   :email => email
                   )
    end
    users = User.all(:limit => 6)
    50.times do
        title = Faker::Lorem.sentence(5)
        url = Faker::Internet.url('example.com') #=> "http://thiel.com/chauncey_simonis"
        users.each { |user| user.posts.create!(:title => title, :url => url, :subname => "all", :is_link => true) }
    end         

    50.times do
        title = Faker::Lorem.sentence(5)
        description = Faker::Lorem.sentent(10)
        users.each { |user| user.posts.create!(:title => title, :description => description, :is_link => false, :subname => "all") }
    end


  end


end

