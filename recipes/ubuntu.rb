include_recipe 'nodejs'

package 'unzip'

include_recipe 'ghost-blog::nginx'

template '/etc/init.d/ghost' do
    source 'ghost.init.ubuntu.erb'
    owner 'root'
    group 'root'
    mode '0755'
end

include_recipe 'ghost-blog::_ghost'
