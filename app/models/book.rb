class Book < ActiveRecord::Base
  paginates_per 10
end
