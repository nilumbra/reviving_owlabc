class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to student_root_path
    end
  end
  def how_it_works;end
  def our_team;end
  def faq;end
end