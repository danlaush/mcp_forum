namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
  end
end

def make_users
  superadmin = User.create!(
               :name => "Superadmin User",
               :email => "superadmin@aiesecus.org",
               :password => "foobar",
               :password_confirmation => "foobar")
  superadmin.update_attribute(:user_type, 0)
  admin = User.create!(
               :name => "Admin User",
               :email => "admin@aiesecus.org",
               :password => "foobar",
               :password_confirmation => "foobar")
  admin.update_attribute(:user_type, 1)
  User.create!(
       :name => "Jeff Chen",
       :email => "jeff@aiesecus.org",
       :password => "asdf",
       :password_confirmation => "asdf",
       :color => "0000ff",
       :about => "Do you see any Teletubbies in here? Do you see a slender plastic tag clipped to my shirt with my name printed on it? Do you see a little Asian child with a blank expression on his face sitting outside on a mechanical helicopter that shakes when you put quarters in it? No? Well, that''s what you see at a toy store. And you must think you''re in a toy store, because you''re here shopping for 

###an infant named Jeb.

* Now that there is the Tec-9, a crappy spray gun from South Miami. 
* This gun is advertised as the most popular gun in American crime. 
* Do you believe that shit? 
* It actually says that in the little book that comes with it: the most popular gun in American crime. 
* Like they''re actually proud of that shit.

Well, the way they make shows is, they make one show. That show''s called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they''re going to make more shows. Some pilots get picked and become television programs. Some don''t, become nothing. She starred in one of the ones that became nothing.")
  User.create!(
       :name => "Callahan Ketterling",
       :email => "callahan@aiesecus.org",
       :password => "asdf",
       :password_confirmation => "asdf",
       :color => "38761D",
       :about => "Normally, both your asses would be dead as fucking fried chicken, but you happen to pull this shit while I''m in a transitional period so I don''t wanna kill you, I wanna help you. But I can''t give you this case, it don''t belong to me. Besides, I''ve already been through too much shit this morning over this case to hand it over to your dumb ass.

Now that there is the Tec-9, a crappy spray gun from South Miami. This gun is advertised as the most popular gun in American crime. Do you believe that shit? It actually says that in the little book that comes with it: the most popular gun in American crime. Like they''re actually proud of that shit.

Do you see any Teletubbies in here? Do you see a slender plastic tag clipped to my shirt with my name printed on it? Do you see a little Asian child with a blank expression on his face sitting outside on a mechanical helicopter that shakes when you put quarters in it? No? Well, that''s what you see at a toy store. And you must think you''re in a toy store, because you''re here shopping for an infant named Jeb.")
  User.create!(
       :name => "Casey Piquette",
       :email => "casey@aiesecus.org",
       :password => "asdf",
       :password_confirmation => "asdf",
       :color => "351C75",
       :about => "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in the name of charity and good will, shepherds the weak through the valley of darkness, for he is truly his brother''s keeper and the finder of lost children. And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.")
  User.create!(
       :name => "Jamie Wernet",
       :email => "jamie@aiesecus.org",
       :password => "asdf",
       :password_confirmation => "asdf",
       :color => "990000",
       :about => "I''m a G.")
end

=begin
def make_microposts
  50.times do
    User.all(:limit => 6).each do |user|
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end

def make_relationships
  users = User.all
  user = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
=end
