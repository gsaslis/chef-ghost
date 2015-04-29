case node['platform']
when 'debian', 'ubuntu'
    
    apt_repository 'nginx' do
        uri 'ppa:nginx/stable'
        distribution node['lsb']['codename']
    end

when 'centos'

   yum_repository 'nginx' do
       description 'Nginx.org Repository'
       baseurl "http://nginx.org/packages/centos/#{node['platform_version'].to_i}/$basearch/"
       gpgkey 'http://nginx.org/keys/nginx_signing.key'
       action :create
   end
end

package 'nginx'

%w{nxensite nxdissite}.each do |nxscript|
    template "#{node['ghost-blog']['nginx']['script_dir']}/#{nxscript}" do
        source "#{nxscript}.erb"
        mode '0755'
        owner 'root'
        group 'root'
    end
end
    
template "#{node['ghost-blog']['nginx']['conf_dir']}/#{node['ghost-blog']['nginx']['server_name']}.conf" do 
    source 'ghost.conf.erb'
    owner 'root'
    group 'root'
end

bash 'enable site config' do
    user 'root'
    cwd node['ghost-blog']['nginx']['conf_dir']
    code <<-EOH
    nxensite #{node['ghost-blog']['nginx']['server_name']}.conf
    EOH
    notifies :restart, 'service[nginx]', :immediately
end
