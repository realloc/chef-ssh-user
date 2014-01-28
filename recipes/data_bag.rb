if node[:users]
  node[:users].each do |username|
    user = data_bag_item('users', username)

    if user['ssh_user']

	    userid = user['username'] ? user['username'] : username
	    home   = user['home'] ? user['home'] : (userid == 'root' ? '/root' : "/home/#{userid}")
	    dotssh = "#{home}/.ssh"

	    if user['ssh_user']['private_keys'] or user['ssh_user']['known_hosts'] or user['ssh_user']['config']
		    directory dotssh do
			    mode '0700'
			    owner userid
			    group userid if userid
			    action :create
		    end
	    end

	    if user['ssh_user']['private_keys']
        Chef::Log.info "Adding ssh private keys for #{username}..."
        user['ssh_user']['private_keys'].each do |name, value|
          ssh_user_private_key name do
            key value
            pub_key user['ssh_user']['public_keys'][name] if user['ssh_user']['public_keys'] && user['ssh_user']['public_keys'][name]  
            user userid
            path dotssh
          end
        end
      end

      if user['ssh_user']['known_hosts']
        Chef::Log.info "Configuring ssh known_hosts for #{username}..."
        user['ssh_user']['known_hosts'].each do |name, value|
          ssh_util_known_hosts name do
            user userid
            key value['key'] if value.has_key?('key')
            hashed value['hashed'] if value.has_key?('hashed')
            path "#{dotssh}/known_hosts"
          end
        end
      end

      if user['ssh_user']['config']
        Chef::Log.info "Configuring ssh config for #{username}..."
        user['ssh_user']['config'].each do |name, value|
          ssh_util_config name do
            user userid
            options value
            path "#{dotssh}/config"
          end
        end
      end

    end
  end
end
