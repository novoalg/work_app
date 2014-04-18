namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    99.times do |n|
      name  = Faker::Internet.user_name
      email = "#{name}-#{n+1}@uwec.edu"
      password  = "password"
      User.create!(:id => n+1, :username => "#{name}#{n+1}",
                   :email => email
                   )
      end

    users = User.all
    50.times do |n|
        subname = Faker::Lorem.word
        subname = "#{subname}#{n}"
        title = Faker::Lorem.sentence(4)
        description = Faker::Lorem.sentence(10)
        Subreddit.create!(:subname => subname, :title => title, :description => description, :user_id => n+1)
    end

    subs = Subreddit.all
    subs.each.with_index do |s, n|
        title = Faker::Lorem.sentence(5)
        url = Faker::Internet.url('example.com') #=> "http://thiel.com/chauncey_simonis"
        Post.create!(:title => title, :url => url, :subname => s.subname, :is_link => true, :user_id => n+1).save! 
    end         
    subs.each.with_index do |s, n|
        title = Faker::Lorem.sentence(5)
        description = Faker::Lorem.sentence(15)
        Post.create!(:title => title, :subname => s.subname, :is_link => false, :description => description, :user_id => n+1)
    end     

    posts = Post.all
    posts.each.with_index do |p, n|
        100.times do 
        if rand(10) % 2 == 0
            Vote.create!(:post_id => p.id, :user_id => n+1, :direction => "up")
            p.karma += 1
        else
            Vote.create!(:post_id => p.id, :user_id => n+1, :direction => "down")
            p.karma -= 1
        end
        end
        content = Faker::Lorem.sentence(5)
        Comment.create!(:content => content, :post_id => p.id, :user_id => n+1)
    end
    comments = Comment.all
    comments.each.with_index do |c, n|
        100.times do
        if rand(10) % 2 == 0
            Vote.create!(:comment_id => c.id, :user_id => n+1, :direction => "up")
            c.karma += 1
        else
            Vote.create!(:comment_id => c.id, :user_id => n+1, :direction => "down")
            c.karma -= 1
        end
        end
    end
  end
end

