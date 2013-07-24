settings = YAML.load_file(File.join(Rails.root.to_s, "config", "settings.yml"))
BASIC_AUTH = settings["basic_auth"]
API_AUTH = settings["api"]
settings = ""