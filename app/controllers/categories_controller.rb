class CategoriesController < ApplicationController
  def index
    @categories = MenuItem.tag_counts_on(:categories)
  end
end
