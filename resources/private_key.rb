actions :create, :delete
default_action :create

attribute :name,  :kind_of => String, :name_attribute => true
attribute :user,  :kind_of => String
attribute :path,  :kind_of => String
attribute :key,   :kind_of => String

def initialize(*args)
  super
  @action = :create
end
