class Sessionmember < ActiveRecord::Base
  belongs_to :studysession
  belongs_to :user
end
