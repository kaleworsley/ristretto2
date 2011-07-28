config = {}
config = YAML.load_file("#{::Rails.root.to_s}/config/config.yml")[::Rails.env] || {} if File.exists?("#{::Rails.root.to_s}/config/config.yml")
config[:git_revision] = `git rev-parse HEAD 2>/dev/null`.to_s.strip

CONFIG = config

