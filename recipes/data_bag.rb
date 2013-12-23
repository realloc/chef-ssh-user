include_recipe 'ssh-util'
include_recipe 'ssh-util-user'

if node[:users]
  node[:users].each do |username|
    user = data_bag_item('users', username)

    if user[:ssh_util]

      if user[:ssh_util][:ssh_known_hosts]
        Chef::Log.info "Configuring ssh known_hosts for #{username}..."
        user[:ssh_util][:ssh_known_hosts].each do |name, value|
          ssh_known_hosts name do
            user username
            key value[:key] if host.has_key?('key')
            hashed value[:hashed] if host.has_key?('hashed')
          end
        end
      end

      if user[:ssh_util][:ssh_config]
        Chef::Log.info "Configuring ssh config for #{username}..."
        user[:ssh_util][:ssh_config].each do |name, value|
          ssh_config name do
            user username
            options value[:options] if host.has_key?('options')
          end
        end
      end

      if user[:ssh_util][:ssh_private_keys]
        Chef::Log.info "Adding ssh private keys for #{username}..."
        user[:ssh_util][:ssh_private_keys].each do |name, value|
          ssh_private_key name do
            key value
            user username
          end
        end
      end
    end
  end
end
