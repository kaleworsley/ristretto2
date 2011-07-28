CONFIG = {}
CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/config.yml")[RAILS_ENV] if File.exists?("#{::Rails.root.to_s}/config/config.yml")
CONFIG[:git_revision] = `git rev-parse HEAD 2>/dev/null`.to_s.strip

