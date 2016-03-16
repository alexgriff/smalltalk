class ConversationsController < ApplicationController

  def new
    @conversation = Conversation.new
    @review = @conversation.build_review
  end

  def create
    # conversation => {"partner_id"=>"7", "topic_ids"=>["1", ""], "review"=>{"rating"=>"3"}},
    # "partner_name"=>"Dude" }

    @conversation = Conversation.new(user: current_user)
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
    binding.pry

    redirect_to conversations_path
  end

  private

  def conversation_params
    params.require(:conversation).permit(:partner_id, :topic_ids => [], :review_attributes =>[:rating])
  end


end