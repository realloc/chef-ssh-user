def load_current_resource
  @name  = new_resource.name
  @user  = new_resource.user || false
  @path  = new_resource.path || (@user) ? (@user == 'root' ? '/root/.ssh' : "/home/#{@user}/.ssh") : node[:ssh][:private_key_path]
  @key   = new_resource.key
end

action :create do
  user, key, path, name = @user, @key, @path, @name

  file "#{path}/#{name}" do
    content key
    mode '0600'
    owner user if user
    action :create
  end
  new_resource.updated_by_last_action(true)
end

action :delete do
  path, name = @path, @name

  file "#{path}/#{name}" do
    action :delete
  end
  new_resource.updated_by_last_action(true)
end
