class SolutionsController < ApplicationController
  def index
    @madlib = MadLib.find(params[:madlib_id])
    @solutions = @madlib.solutions

    respond_to do |format|
      format.html
    end
  end

  def show
    @solution = Solution.find(params[:id])
    @madlib = @solution.madlib
    @resolution = @solution.resolve

    respond_to do |format|
      format.html
    end
  end

  def new
    @madlib = MadLib.find(params[:madlib_id])
    @solution = @madlib.solutions.build

    respond_to do |format|
      format.html
    end
  end

  def edit
    @solution = Solution.find(params[:id])
    @madlib = @solution.madlib
  end

  def create
    @solution = MadLib.find(params[:madlib_id]).solutions.build

    @solution.fields = params[:fields]

    respond_to do |format|
      if @solution.save
        format.html { redirect_to(madlib_solution_url(@solution.madlib, @solution), :notice => 'Your solution has been created') }
      else
        format.html { redirect_to @solution.madlib, :notice => 'Error while creating solution' }
      end
    end
  end

  def update
    @solution = Solution.find(params[:id])
    @madlib = @solution.madlib
    @solution.fields = params[:fields]

    respond_to do |format|
      if @solution.save
        format.html { redirect_to(madlib_solution_url(@solution.madlib, @solution), :notice => 'Solution was successfully updated.') }
      else
        format.html { render :action => "edit" }

      end
    end
  end

  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy

    respond_to do |format|
      format.html { redirect_to(madlib_solutions_url(@solution.madlib)) }
    end
  end
end
