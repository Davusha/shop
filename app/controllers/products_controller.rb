class ProductsController < ApplicationController

    PRODUCT_REQUIRED_ATTR = %i[name main price]

    def add; end

    def new
        product = Product.new(product_params).tap { |p| p.user_id = @user["id"] }

        if product.save
            redirect_to "/"
        else
            redirect_to action: "add", error: "Error while saving product"
        end
    end

    def show
        product_id = params[:product_id].to_i
        if @user
            @conversations = Conversation.where(product_id: product_id)
            @user_conversations = Conversation.where(product_id: product_id, user_id: @user["id"]).select { |conversation| conversation.answer != "" }
            @users = User.all
        end
        @product = Product.find_by(id: product_id)
        @seller = User.find_by(id: @product.user_id)
    end

    def add_quesstion
        product_id = params[:id].to_i
        quesstion = params[:quesstion]

        conversation = Conversation.new(
            user_id: @user["id"], answer: "", quesstion: quesstion,
            product_id: product_id
        )
        result = conversation.save

        respond_to do |format|
            format.json do
              render json:
                  { result: result }
            end
        end
    end

    def add_answer
        conversation = Conversation.find_by(id: params[:id].to_i).tap { |p| p.answer = params[:answer] }
        result = conversation.save

        respond_to do |format|
            format.json do
              render json:
                  { result: result }
            end
        end
    end

    private

    def product_params
        params.require(:product).permit(PRODUCT_REQUIRED_ATTR)
    end
end
