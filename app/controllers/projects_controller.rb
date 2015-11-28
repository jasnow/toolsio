class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to root_path, notice: I18n.t('flash.notice.project_created')
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @Project = Project.find(params[:id])

    if @Project.update(project_params)
      redirect_to root_path, notice: I18n.t('flash.notice.project_updated')
    else
      render :edit
    end

  end

  private

  def project_params
    params.require(:project).permit(:name, :client, :archived)
  end

end