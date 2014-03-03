class MadlibsController < ApplicationController
  def index
  	@madlibs = Madlib.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @madlib = Madlib.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @madlib = Madlib.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @madlib = Madlib.find(params[:id])
  end

  def create
    @madlib = Madlib.new(params[:madlib])
    @mablib.save
#    respond_to do |format|
#      if @mablib.save
#        format.html { redirect_to(@madlib, :notice => 'New Mad Lib created.') }
#      else
#        format.html { render :action => "new" }
#      end
#    end
  end
end
