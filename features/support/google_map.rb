Before('~@google_map') do
  Settings.google_map['server'] = 'http://localhost'
end

After('~@google_map') do
  Settings.google_map['server'] = 'http://maps.googleapis.com'
end
