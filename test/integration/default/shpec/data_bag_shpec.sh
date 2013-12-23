describe "data_bag"

  it "should create the private key"
    assert file_present '/home/testman/.ssh/server_rsa'

  it "should put the correct value into the private key"
    contents = $(cat /home/testman/.ssh/server_rsa)
    assert equal "$contents" "ABCD"

  it "should set the correct private key file owner"
    file_owner = $(ls -l /home/testman/.ssh/server_rsa | awk '{ print $3 }')
    assert equal "$file_owner" "testman"

  it "should create the ssh config file"
    assert file_present '/home/testman/.ssh/config'

  it "should add a an entry into the ssh config file"
    contents = $(cat /home/testman/.ssh/config | grep github)
    assert equal "$contents" "Host github.com"

  it "should create the known hosts file"
    assert file_present '/home/testman/.ssh/known_hosts'

  it "should add a an entry into the ssh config file"
    contents = $(cat /home/testman/.ssh/known_hosts | grep github)
    assert present "$contents"

end_describe
