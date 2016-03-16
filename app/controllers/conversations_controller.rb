class ConversationsController < ApplicationController

  def new
    @conversation = Conversation.new
    @review = @conversation.build_review
  end

  def create
    # params = {"conversation"=>{"partner_id"=>"1", "topic_ids"=>["1", "2"], "review"=>{"rating"=>"4"}},
    # "partner_name"=>"Dude" }
    @conversation = Conversation.new(user: current_user)
    @conversation.build_review
    binding.pry
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

    @conversation.save

    redirect_to conversations_path
  end

  private

  def conversation_params
    params.require(:conversation).permit()
  end

end