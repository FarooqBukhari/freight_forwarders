class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.get(current_user.id, params[:user_id], params[:con_type])

    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
      format.html { redirect_to messages_index_path( id: @conversation.id ) }
    end
  end

  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    if !session[:conversations].nil?
      session[:conversations].include?(@conversation.id)
    end
  end
end