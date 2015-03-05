def load_current_resource
  @name  = new_resource.name
  @user  = new_resource.user
  @path  = new_resource.path || (@user ? (@user == 'root' ? '/root/.ssh' : "/home/#{@user}/.ssh") : node[:ssh][:private_key_path])
  @key   = new_resource.key
  @pub_key   = new_resource.pub_key
end

action :create do
  user, key, pub_key, path, name = @user, @key, @pub_key, @path, @name

  file "#{path}/#{name}" do
    content key
    mode '0600'
    owner user if user
    action :create
  end

  file "#{path}/#{name}.pub" do
    content pub_key
    mode '0644'
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

  file "#{path}/#{name}.pub" do
    action :delete
  end

  new_resource.updated_by_last_action(true)
end
