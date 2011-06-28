CONFIG = {}
CONFIG = YAML.load_file("#{RAILS_ROOT}/config/config.yml")[RAILS_ENV] if File.exists?("#{RAILS_ROOT}/config/config.yml")
CONFIG[:git_revision] = `git rev-parse HEAD 2>/dev/null`.to_s.strip

