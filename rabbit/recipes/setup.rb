#
# Cookbook Name:: lockbox
# Recipe:: setup
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# Repositories
# include_recipe 'lockbox::remi'
# include_recipe 'lockbox::remi-php55'

# include_recipe 'php'

# %w{php-pdo php-pgsql php-intl php-pecl-apcu php-mbstring php-opcache}.each do |p|
# 	package p do
# 		action :install
# 	end
# end

# # This is for later refactoring. Lockbox specific
# package "php-ldap" do
# 	action :install
# end

# include_recipe 'php-fpm'
# php_fpm_pool 'www' do
# 	user "nginx"
# 	group "nobody"
# 	listen_owner "nginx"
# 	listen_group "nobody"
# end

# include_recipe 'nginx'
