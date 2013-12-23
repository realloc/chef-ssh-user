describe "data_bag"

  it "should create the private key"
    assert file_present '/home/testman/.ssh/github_rsa'

  it "should put the correct value into the private key"
    actual=$(cat /home/testman/.ssh/github_rsa)
    assert equal "$actual" "ABCD"

  it "should set the correct private key file owner"
    file_owner=$(ls -l /home/testman/.ssh/github_rsa | awk '{ print $3 }')
    assert equal "$file_owner" "testman"

  it "should create the ssh config file"
    assert file_present '/home/testman/.ssh/config'

  it "should add a an entry into the ssh config file"
    expected='Host github.com\n  IdentityFile ~/.ssh/github_rsa\n#End Chef SSH for github.com'
    actual=$(cat /home/testman/.ssh/config | grep github)
    assert equal "$actual" "$expected"

  it "should create the known hosts file"
    assert file_present '/home/testman/.ssh/known_hosts'

  it "should add a an entry into the ssh config file"
    actual=$(cat /home/testman/.ssh/known_hosts | grep github)
    assert present "$actual"

end_describe
