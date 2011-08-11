namespace :ristretto do
  desc "Set up a fresh cloned git repo for operation"
  task :setup do
    ['database', 'config'].each do |file|
      example_file = Rails.root.join('config',"#{file}.example.yml")
      real_file    = Rails.root.join('config',"#{file}.yml")

      if ! File.exists?(real_file)
        sh "cp #{example_file} #{real_file}"
      else
        puts "#{real_file} already exists!"
      end
    end
  end

  desc "Add a new user. You must supply NAME, EMAIL and PASSWORD. You may also supply STAFF=1 to give the user full permissions."
  task :user => :environment do
    if ENV['NAME'] && ENV['EMAIL'] && ENV['PASSWORD']
      user = User.create({
        :full_name => ENV['NAME'],
        :email => ENV['EMAIL'].dup,
        :password => ENV['PASSWORD'],
        :password_confirmation => ENV['PASSWORD'],
        :staff => (ENV['STAFF']) ? true : false
      })
      if user.save && user.confirm!
        puts "Added #{user}."
      else
        puts user.errors.full_messages
      end
    else
      puts "You must supply NAME, EMAIL and PASSWORD"
    end

  end
end

