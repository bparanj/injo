class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  
  def comments
    Comment.all
    # Comment.all.scoped(:joins => {:user => :memberships}, :conditions => { :memberships => { :group_id => id } })
  end
end
