class ConversationsController < ApplicationController
  before_action :find_conversation, only: [:show, :edit, :update, :destroy]

  def new
    @conversation = Conversation.new
    @review = @conversation.build_review
  end

  def create

    # params = {"conversation"=>{"partner_id"=>"1", "topic_ids"=>["1", "2"], "review"=>{"rating"=>"4"}},
    # "partner_name"=>"Dude" }
    @conversation = Conversation.new(user: current_user)
    @conversation.build_review
   
    #partner name
    if params[:partner_name].present?
      user_partners = current_user.partners.map { |partner| partner.name }

       #user typed name
      if user_partners.include?(params[:partner_name])
        @conversation.partner = current_user.partners.where(name: params[:partner_name])
      else
        @conversation.partner = Partner.create(name: params[:partner_name])
      end

    #user select from the existing name list
    else
      @conversation.partner = Partner.find(params[:conversation][:partner_id])
    end
    @conversation.update(conversation_params)
    @conversation.save

    redirect_to conversation_path(@conversation)
  end

  def show
  end

  def update
    @conversation.review.update(comment: params[:review_comment])
    binding.pry
    redirect_to @conversation
  end

  private

  def conversation_params
    params.require(:conversation).permit()
  end

  private

  def conversation_params
    params.require(:conversation).permit(:partner_id, :topic_ids => [], :review_attributes =>[:rating])
  end

  def find_conversation
    @conversation = Conversation.find(params[:id])
  end



end