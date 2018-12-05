class Book < ApplicationRecord
  validates_presence_of :title, :pages, :publishing_year
end
