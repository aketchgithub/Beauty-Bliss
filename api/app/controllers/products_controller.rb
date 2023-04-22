# class ProductsController < ApplicationController
#     wrap_parameters format: []
#  before_action :authorize_owner, only: [:create]
 
# rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

#   def index
#     products = Product.all
#     render json: products.as_json(only: [:id, :name, :description, :price, :image_url ])
#   end

#   def show 
#     product = find_product
#     render json: product.as_json
#   end

#   def create 
#     @product = current_user.products.build(product_params)

#     if @product.save
#       redirect_to @product
#     else
#       render :new
#     end
#   end

#  def update
#   product = Product.find_by(id: params[:id])
#   render_not_found_response unless product.valid?
#   product.update(product_params)
#   app_response(status: 200, message: "Updated successfully")
#  end

#   private

#   def find_product
#     Product.find_by(id: params[:id]) || raise(ActiveRecord::RecordNotFound)
#   end

#   def render_not_found_response
#     render json: { error: "Product not found" }, status: :not_found 
#   end

#   def product_params
#     params.permit(:name, :description, :price, :image_url)
#   end


#   def authorize_owner
#     product = current_user.products.find_by(id: params[:id])
#     unless product
#       redirect_to root_path, alert: "You are not authorized to perform this action"
#     end
#   end
  

# end

class ProductsController < ApplicationController
  # before_action :authorize_owner, only: [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    products = Product.all
    render json: products.as_json(only: [:id, :name, :description, :price, :image_url])
  end

  def show 
    product = find_product
    render json: product.as_json
  end

  def new
    @product = current_user.products.build
  end


  def create 
    @product = current_user.products.build(product_params)
  
    if @product.save
      render json: @product.as_json, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  def update
    product = Product.find_by(id: params[:id])
    render_not_found_response unless product.valid?
    product.update(product_params)
    render json: { status: 200, message: "Updated successfully" }
  
  end

  private

  def find_product
    Product.find_by(id: params[:id]) || raise(ActiveRecord::RecordNotFound)
  end

  def render_not_found_response
    render json: { error: "Product not found" }, status: :not_found 
  end

  def product_params
    params.permit(:name, :description, :price, :image_url, :user_id)
  end

  def authorize_owner
    product = Product.find_by(id: params[:id])
    unless current_user == product.user
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end

  def authorize_owner
    product = Product.find_by(id: params[:id])
    return redirect_to root_path, alert: "Product not found" unless product
    return redirect_to root_path, alert: "You are not authorized to perform this action" unless current_user == product.user
  end
  

   def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end


# In this implementation, we're using a before_action callback to call the authorize_owner method 
# before the create action is executed. The authorize_owner method finds the product by its id, 
# and then checks if the currently logged in user is the owner of the product using current_user == product.user. 
# If the user is not the owner, we redirect them to the root path with an error message.
