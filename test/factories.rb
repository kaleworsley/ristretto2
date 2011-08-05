Factory.define :user do |u|
  u.sequence(:email) {|n| "user#{n}@example.com"}
  u.password 'password'
  u.password_confirmation 'password'
  u.after_build {|user| user.confirm!}
end

Factory.define :customer do |c|

end

Factory.define :unit do |u|
  u.sequence(:name) {|n| "Test #{n}" }
  u.association :customer
end

Factory.define :project do |p|
  p.name "Project"
  p.state "lead"
  p.association :customer
end

Factory.define :contact do |c|
  c.association :user
  c.association :unit
end

Factory.define :stakeholder do |s|
  s.association :user
  s.association :project
  s.role "MyString"
end


Factory.define :ticket do |t|
  t.description "This is a test ticket."
  t.association :unit
end

