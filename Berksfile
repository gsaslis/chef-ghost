source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'apt'
end

cookbook 'apt'
cookbook 'compat_resource', '~> 12.16.3'
cookbook 'nodejs', '~> 2.4.0'
cookbook 'test', path: 'test/cookbooks/test'
