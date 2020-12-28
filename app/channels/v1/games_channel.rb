class V1::GamesChannel < ApplicationCable::Channel
  def subscribed
    @game = Game.find(params[:game_id])

    stream_for @game, coder: ActiveSupport::JSON do
      transmit GameSerializer.new(@game, {
        params: {
          current_user: current_user
        }
      }).serializable_hash
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def join()
    @game.players.push(current_user) unless @game.players.include?(current_user)

    broadcast_to(@game, @game)
  end
end
