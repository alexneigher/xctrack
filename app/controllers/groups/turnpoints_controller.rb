module Groups
  class TurnpointsController < ApplicationController

    def edit
      @group = Group.find(params[:group_id])
      @turnpoint = Turnpoint.find(params[:id])
    end

    def update
      @group = Group.find(params[:group_id])
      @turnpoint = Turnpoint.find(params[:id])
      @turnpoint.update!(turnpoint_params)

      redirect_to edit_group_path(@group)
    end

    def new
      @group = Group.find(params[:group_id])
    end

    def create
      @group = Group.find(params[:group_id])
      @group.turnpoints.create!(turnpoint_params)

      redirect_to edit_group_path(@group)
    end

    def destroy
      @group = Group.find(params[:group_id])
      @turnpoint = Turnpoint.find(params[:id])

      @turnpoint.destroy

      redirect_to edit_group_path(@group)
    end

    private
      def turnpoint_params
        params.require(:turnpoint).permit(:name, :latitude, :longitude, :radius, :active, :sort_order)
      end

  end
end