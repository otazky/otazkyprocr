# encoding: UTF-8
module ApplicationHelper
  def has_children?(link)    
    unless Refinery::Page.where('show_in_menu = true').find_by_parent_id(link.id).nil?
      return true
    end
    false
	end


	def bodu_cesky(n)

		return 'bod' if n==1
		return 'body' if n>1 && n<5
		return 'bodů'


	end

end