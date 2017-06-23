class WelcomeController < ApplicationController

  def index
    @lessons = Lesson.all
  end

  def test
    @question = Post.new
  end
end
