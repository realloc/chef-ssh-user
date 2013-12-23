if node[:users]
  node[:users].each do |username|
    user = data_bag_item('users', username)

    if user['ssh_user']

      if user['ssh_user']['private_keys']
        Chef::Log.info "Adding ssh private keys for #{username}..."
        user['ssh_user']['private_keys'].each do |name, value|
          ssh_user_private_key name do
            key value
            user username
          end
        end
      end

      if user['ssh_user']['known_hosts']
        Chef::Log.info "Configuring ssh known_hosts for #{username}..."
        user['ssh_user']['known_hosts'].each do |name, value|
          ssh_util_known_hosts name do
            user username
            key value['key'] if value.has_key?('key')
            hashed value['hashed'] if value.has_key?('hashed')
          end
        end
      end

      if user['ssh_user']['config']
        Chef::Log.info "Configuring ssh config for #{username}..."
        user['ssh_user']['config'].each do |name, value|
          ssh_util_config name do
            user username
            options value
          end
        end
      end

    end
  end
end
