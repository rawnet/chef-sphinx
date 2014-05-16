tarball_url = "http://sphinxsearch.com/files/archive/sphinx-#{node['sphinx']['version']}.tar.gz"
tarball_path = "/tmp/sphinx-#{node['sphinx']['version']}.tar.gz"
prefix = "/usr/local"

unless `PATH=#{prefix}/bin:$PATH which searchd` != ''
  remote_file tarball_url do
    source tarball_url
    path tarball_path
    backup false
  end

  bash 'unarchive_source' do
    cwd File.dirname(tarball_path)
    code "tar zxf #{File.basename(tarball_path)} -C #{File.dirname(tarball_path)}"
    not_if do
      File.directory? "/tmp/sphinx-#{node['sphinx']['version']}"
    end
  end

  bash 'compile_sphinx_source' do
    cwd File.dirname(tarball_path)
    code "cd sphinx-#{node['sphinx']['version']} && ./configure --prefix=#{prefix} && make && make install"
  end
end
