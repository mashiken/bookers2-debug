class BookCommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def create
  	@book = Book.find(params[:book_id])
  	@book_comment = current_user.book_comments.new(book_comment_params)
  	@book_comment.book_id = @book.id
    @book_comment.save
  end

  def destroy
  	@book_comment = BookComment.find(params[:id])
    @book = @book_comment.book
  	@book_comment.destroy
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
