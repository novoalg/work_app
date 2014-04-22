namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    99.times do |n|
      name  = Faker::Lorem.words(1)
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
        Subscription.create!(:user_id => n+1, :subreddit_id => n+1)
    end

    subs = Subreddit.all
    subs.each.with_index do |s, n|
        s.increase_user_count()
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
        10.times do 
        if rand(10) % 2 == 0
            Vote.create!(:post_id => p.id, :user_id => n+1, :direction => "up")
            p.increase_karma()
        else
            Vote.create!(:post_id => p.id, :user_id => n+1, :direction => "down")
            p.decrease_karma()
        end
        end
        content = Faker::Lorem.sentence(5)
        Comment.create!(:content => content, :post_id => p.id, :user_id => n+1)
    end
    comments = Comment.all
    comments.each.with_index do |c, n|
        10.times do
        if rand(10) % 2 == 0
            Vote.create!(:comment_id => c.id, :user_id => n+1, :direction => "up")
            c.increase_karma()
        else
            Vote.create!(:comment_id => c.id, :user_id => n+1, :direction => "down")
            c.decrease_karma()
        end
        end
    end
    comments.each.with_index do |c, n|
        10.times do
            content = Faker::Lorem.sentence(5)
            Reply.create!(:content => content, :comment_id => n+1, :user_id => n+1)
        end
        replies = Reply.all
        10.times do
            Vote.create!(:reply_id => n+1, :user_id => n+1) 
        end
    end

  end
end

