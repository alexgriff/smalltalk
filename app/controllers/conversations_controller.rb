class ConversationsController < ApplicationController
  before_action :find_conversation, only: [:show, :edit, :update, :destroy]

  def new
    @conversation = Conversation.new
    @review = @conversation.build_review
  end

  def create
    # params = {"conversation"=>{"partner_id"=>"1", "topic_ids"=>["1", "2"], "review_attributes"=>{"rating"=>"4"}},
    # "partner_name"=>"Dude" }
    
    @conversation = current_user.conversations.build(conversation_params)
   
    if params[:partner_name].present?
      @conversation.associate_or_create_partner_by_name(params[:partner_name])
    end

    @conversation.save
    redirect_to conversation_path(@conversation)

  end

  def show
  end

  def update
    if @conversation.review.update(comment: params[:review_comment])
      flash[:notice] = "Comment was successfully created!"
    redirect_to @conversation
    end 
  end

  private

  def conversation_params
    params.require(:conversation).permit(:partner_id, :partners_gender, :time, :topic_ids => [], :review_attributes =>[:rating])
  end

  def find_conversation
    @conversation = Conversation.find(params[:id])
  end

end