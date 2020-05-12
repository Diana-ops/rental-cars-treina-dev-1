class CarCategoriesController < ApplicationController

	before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy] 

	def index
		@car_categories = CarCategory.all
	end
	def show
		@car_category = CarCategory.find(id)
		#@car_models = CarModel.where(car_category: @car_category)
	end
	def new
		@car_category = CarCategory.new
	end
	def create
		@car_category = CarCategory.new(require_params)
		if @car_category.save	
	    		redirect_to @car_category
	    	else 
			render :new
	    	end
	end

	def edit
		@car_category = CarCategory.find(id)
	end

	def update
		@car_category = CarCategory.find(id)
		if @car_category.update(require_params)
			redirect_to @car_category
		else
			render :edit
		end
	end

	def destroy
		@car_category = CarCategory.find(id)
		@car_category.destroy

		redirect_to car_categories_path
	end

	private
	
	def require_params
		params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_part_insurance)
	end

	def id
		params[:id]
	end

	def authenticate_user
	    
	    if current_user.user?
	      redirect_to car_categories_path
	    end
	end
end
