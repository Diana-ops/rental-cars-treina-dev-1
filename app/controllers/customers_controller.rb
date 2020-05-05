class CustomersController < ApplicationController
	
	def index
		@customers = Customer.all
	end

	def search
		@customers = Customer.where(name: params[:q]).or(Customer.where(document: params[:q]))
		render :index
	end

	def new
		@customer = Customer.new
	end
	def create
		@customer = Customer.new(require_params)
		if @customer.save	
	    		redirect_to root_path
	    	else 
			render :new
	    	end
	end

	def edit
		@customer = Customer.find(id)
	end

	def update
		@customer = Customer.find(id)
		if @customer.update(require_params)
			redirect_to customers_path
		else
			render :edit
		end
	end

	private
	
	def require_params
		params.require(:customer).permit(:name, :document, :email)
	end

	def id
		params[:id]
	end
end
