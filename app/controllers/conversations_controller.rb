class ConversationsController < ApplicationController

  def new
    @conversation = Conversation.new

  end

  def create
    binding.pry
    # params = {"conversation"=>{"partner_id"=>"1"},
    # "partner_name"=>"Dude" }
    @conversation = Conversation.new(user: current_user)
    
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


end