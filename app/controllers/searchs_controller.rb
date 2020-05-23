class SearchsController < ApplicationController

	def search
		@user_or_book = params[:table]
    @how_search = params[:choice]
    if @user_or_book == "1"
    	@search_users = User.search(params[:search], @user_or_book, @how_search )
    else
      @search_books = Book.search(params[:search], @user_or_book, @how_search )
    end
  end
end
