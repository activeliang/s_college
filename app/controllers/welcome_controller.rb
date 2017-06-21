class WelcomeController < ApplicationController

  def index

  end

  def test
    @question = Post.new
  end
end
