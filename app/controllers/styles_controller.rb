class StylesController < ApplicationController
  before_action :set_style, only: [:show, :update, :edit]
  def show
    @beers = @style.beers
  end

  def index
    @styles = Style.all
  end

  def set_style
    @style = Style.find(params[:id])
  end

  def edit
    @style = Style.find(params[:id])
  end

  def update
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to @style, notice: 'Style was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  def style_params
    params.require(:style).permit(:name, :description)
  end

end