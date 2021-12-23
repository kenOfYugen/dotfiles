{}:
''
  # Config for sworkstyle
  #
  # You can rename workspaces based on the exact application names or by generic pattern.
  # When it could not match anything it will use the fallback.
  #
  # format:
  #
  #   '{pattern}' = '{icon}'
  #
  # pattern: Can either be the exact "app_name" (app_id/class) of the window or a regex string in the format of `"/{regex}/"` which will match the window "title".
  # icon: Your beatifull icon
  #
  # verbose format:
  # 
  #  '{pattern}' = { type = 'generic' | 'exact', value = '{icon}' }
  #
  #
  # If it couldn't match something it will print:
  # 
  # WARN [sworkstyle:config] No match for '{app_name}' with title '{title}' 
  #
  # You can use {title} to do a generic matching 
  # You can use {app_name} to do an exact match

  fallback = ''

  [matching]
  'ncspot' = ''
  'discord' = 'ﭮ'
  'Steam' = ''
  'Google-chrome' = ''
  'Chromium' = ''
  'Code' = ''
  'code-oss' = ''
  'Spotify' = ''
  'GitHub Desktop' = ''
  '/(?i)Github.*Firefox/' = ''
  'firefox' = ''
  'Nightly' = ''
  'firefoxdeveloperedition' = ''
  '/nvim ?\w*/' = ''
  'neovide' = ''
  'Alacritty' = ''
  'Brave-browser' = '爵'
  'foot' = ''
''
