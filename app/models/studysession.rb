class Studysession < ActiveRecord::Base
    has_many :sessionmembers
    has_many :users, through: :sessionmembers
end
