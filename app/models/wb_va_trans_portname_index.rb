class WbVaTransPortnameIndex < ApplicationRecord

 scope :active, -> {where("status = ?" ,true)}

 validates :name, :presence => true
# validates :comment, :presence => true


end

