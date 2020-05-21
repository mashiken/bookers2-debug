class BookCommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def create
  	@book = Book.find(params[:book_id])
  	@book_comment = current_user.book_comments.new(book_comment_params)
  	@book_comment.book_id = @book.id
  	if @book_comment.save
  	  redirect_to @book
  	else
  	  @newbook = Book.new
  	  render "books/show"
  	end
  end

  def destroy
  	comment = BookComment.find(params[:id])
  	comment.destroy
    redirect_to book_path(comment.book_id)
  end

  private

  def book_comment_params
  	params.require(:book_comment).permit(:comment)
  end

  def correct_user
    comment = BookComment.find(params[:id])
    user = comment.user
    if current_user != user
      redirect_to books_path
    end
  end
end
