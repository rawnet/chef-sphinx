package 'sphinxsearch' do
  if node['sphinx'] && node['sphinx']['version']
    version node['sphinx']['version']
  end
end
