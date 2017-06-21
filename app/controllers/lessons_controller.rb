class LessonsController < ApplicationController

  def show
    @lesson = Lesson.find(params[:id])
  end

  def syllabus
    @lesson = Lesson.find(params[:id])
    @chapters = @lesson.chapters
  end


end
