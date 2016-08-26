class GroupsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def index
    @groups = Group.all
    if current_user
      @user_groups = current_user.groups
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:success] = 'Group was successfully created.'
      redirect_to edit_group_path(@group)
    else
      render :new
    end

  end

  def edit
    @edit = true
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:success] = 'Group was successfully updated'
      redirect_to groups_path
    else
      render :edit
    end

  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  def show
    @group = Group.includes(:users).find(params[:id])
    @current_group_id = @group.id

    fetch_users(@group)

    @coordinates = @users_on_map.map(&:fetch_coordinates)

    render 'home/index'
  end

  def add_user
    @group = Group.find(params[:group_id])
    @group.user_groupings.create(user_id: params[:user_id])
    redirect_to edit_group_path(@group)
  end

  private
    def group_params
      params.require(:group).permit(:name, user_grouping_ids: [])
    end

end
