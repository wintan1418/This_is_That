class PagesController < ApplicationController
  def home
    @categories = Category.alphabetical.limit(8)
  end

  def about
  end
end
