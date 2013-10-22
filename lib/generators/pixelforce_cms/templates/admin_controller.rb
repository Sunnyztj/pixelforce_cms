class Admin::<%= @controller_name.pluralize.capitalize %>Controller < Admin::BaseController

  def index
    @<%= @controller_name.underscore.pluralize %> = <%= @controller_name.singularize.capitalize %>.all
  end

  def new
    @<%= @controller_name.singularize.underscore %> = <%= @controller_name.singularize.capitalize %>.new
  end

  def create
    @<%= @controller_name.singularize.underscore %> = <%= @controller_name.singularize.capitalize %>.new params[:<%= @controller_name.singularize.underscore %>]
    if @<%= @controller_name.singularize.underscore %>.save
      redirect_to <%= @controller_name.underscore.pluralize %>_path
    else
      render action: :new
    end
  end

  def edit
    @<%= @controller_name.singularize.underscore %> = <%= @controller_name.singularize.capitalize %>.find params[:id]
  end

  def update
    @<%= @controller_name.singularize.underscore %> = <%= @controller_name.singularize.capitalize %>.find params[:id]
    if @<%= @controller_name.singularize.underscore %>.update_attributes params[:<%= @controller_name.underscore %>]
      redirect_to <%= @controller_name.underscore.pluralize %>_path
    else
      render action: :edit
    end
  end

  def destroy
    @<%= @controller_name.singularize.underscore %> = <%= @controller_name.singularize.capitalize %>.find params[:id]
    @<%= @controller_name.singularize.underscore %>.destroy
    redirect_to <%= @controller_name.pluralize.underscore.pluralize %>_path
  end

end