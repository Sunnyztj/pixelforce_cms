class Admin::<%= controller_name.pluralize %>Controller < Admin::BaseController

  def index
    @<%= controller_name.underscore.pluralize %> = <%= controller_name %>.all
  end

  def new
    @<%= controller_name.underscore %> = <%= controller_name %>.new
  end

  def create
    @<%= controller_name.underscore %> = <%= controller_name %>.new params[:<%= controller_name.underscore %>]
    if @<%= controller_name.underscore %>.save
      redirect_to <%= controller_name.underscore.pluralize %>_path
    else
      render action: :new
    end
  end

  def edit
    @<%= controller_name.underscore %> = <%= controller_name %>.find params[:id]
  end

  def update
    @<%= controller_name.underscore %> = <%= controller_name %>.find params[:id]
    if @<%= controller_name.underscore %>.update_attributes params[:<%= controller_name.underscore %>]
      redirect_to <%= controller_name.underscore.pluralize %>_path
    else
      render action: :edit
    end
  end

  def destroy
    @<%= controller_name.underscore %> = <%= controller_name %>.find params[:id]
    @<%= controller_name.underscore %>.destroy
    redirect_to <%= controller_name.underscore.pluralize %>_path
  end

end