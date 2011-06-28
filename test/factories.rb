Factory.define :user do |u|
  u.sequence(:email) {|n| "user#{n}@example.com"}
  u.password 'password'
  u.password_confirmation 'password'
  u.after_build {|user| user.confirm!}
end


Factory.define :customer do |c|
  c.sequence(:name) {|n| "Customer #{n}"}
  c.association :default_unit
end


Factory.define :default_unit, :class => :unit do |d|
  d.default true
end

Factory.define :unit do |u|

end

Factory.define :project do |p|
  p.name "Project"
  p.association :customer
  p.association :created_by, :factory => :user
end

