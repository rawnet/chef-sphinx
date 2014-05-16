package 'sphinxsearch' do
  if node['sphinx']['version']
    version node['sphinx']['version']
  end
end
