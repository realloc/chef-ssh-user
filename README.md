# Chef SSH User

> Manage basic global or user's ssh configurations.

## Description

This cookbook features:

* Provides Chef LWRP:
  * `ssh_user_private_key`
  
* Includes *ssh-util's* Chef LWRP:
  * `ssh_util_known_hosts`
  * `ssh_util_config`
  
* A companion recipe for [user::data_bag](https://github.com/fnichol/chef-user).

## Usage

Include `recipe[ssh_user]` in your `run_list` and `ssh_user_private_key` resource will become available.

The `ssh_user::data_bag` recipe assumes that you're using the `user::data_bag` recipe from the excellent [user cookbook](https://github.com/fnichol/chef-user). It lets you configure ssh aspects in user specific data_bags, e.g.

```
{
  "id": "testman",
  ...
  "ssh_user": {
    "config": {
      "github.com": {
        "User": "git",
        "IdentityFile": "~/.ssh/github_rsa"
      }
    },
    "known_hosts": {
      "github.com": {
        "hashed": false
      }
    },
    "private_keys": {
      "github_rsa": "ABCD"
    }
  }
}
```

Requirements
------------

### Platform
This cookbook has been tested with the following OSes:

* ubuntu 12.04

### Cookbooks
The cookbook has got the following dependencies:

* [user](https://github.com/fnichol/chef-user)
* [ssh-util](http://community.opscode.com/cookbooks/ssh-util)

## Recipes

### default

No-op, does nothing.

### data_bag
Processes `node['users']` and performs the configuration for the ones whose data_bags enable it, e.g.

```
{
  "id" : "testman",
  ...
  "ssh_user": {
    "config": {
      "github.com": {
        "User": "git",
        "IdentityFile": "~/.ssh/github_rsa"
      }
    },
    "known_hosts": {
      "github.com": {
        "hashed": false
      }
    },
    "private_keys": {
      "github_rsa": "ABCD"
    }
  }
}
```

## Resources and Providers

### ssh_private_keys

#### Actions

<table>
  <thead>
    <tr>
      <th>Action</th>
      <th>Description</th>
      <th>Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>create</td>
      <td>Creates the user's <code>~/user/private_key</code> file.</td>
      <td>Yes</td>
    </tr>
    <tr>
      <td>delete</td>
      <td>Deletes  the user's <code>~/user/private_key</code> file.</td>
      <td>No</td>
    </tr>
  </tbody>
</table>

#### Attributes

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Default Value</th>
      <th>Required</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>name</td>
      <td><b>Name attribute:</b> Name of the key file.</td>
      <td><code>nil</code></td>
      <td>yes</td>
    </tr>
    <tr>
      <td>key</td>
      <td>A full line to add to the file.</td>
      <td><code>nil</code></td>
      <td>yes</td>
    </tr>
    <tr>
      <td>user</td>
      <td>An existing username.</td>
      <td><code>nil</code></td>
      <td>no</td>
    </tr>
    <tr>
      <td>path</td>
      <td>A full path to a where to put the key file. If used with the `user` attribute, this will take precedence over the path to a user's home direcotry, but the file will be created (if necessary) as that user.</code></td>
      <td><code>/etc/ssh</code></td>
      <td>no</td>
    </tr>
  </tbody>
</table>


#### Example

```
ssh_user_private_key 'github_key' do
  key get_my_super_secret_key
end

ssh_user_private_key 'testman_server_key' do
  key get_my_super_secret_key
  user 'testman'
end
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) 2013 franklin under the MIT license.
