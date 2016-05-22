class Studysession < ActiveRecord::Base
    validates :subject, presence: true
    validates :location, presence: true
    has_many :sessionmembers
    has_many :users, through: :sessionmembers
end
