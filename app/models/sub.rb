class Sub < ActiveRecord::Base
  validates :name, :presence => true, :length => { :minimum => 3 }
  validates :mod_id, :presence => true

  belongs_to  :moderator,
              :class_name => "User",
              :foreign_key => :mod_id,
              :primary_key => :id

  has_many    :links
end
