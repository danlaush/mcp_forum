# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                   "Candidate User"
  user.email                  "mcp-candidate@gmail.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :question do |question|
  question.name       "Example Question"
  question.entity     "US (Seattle)"
  question.content    "Foo bar bin bash bz"
end