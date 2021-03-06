class AuctionsController < ApplicationController
  before_action :set_auction, only: [ :show ]

  def index
    if !params[:state].nil? && params[:state] == 'closed'
      @auctions = Auction.closed.page params[:page]
      render :index_closed
    else
      @auctions = Auction.open.page params[:page]
    end
  end

  def show
    # オークション詳細情報ページでは、入札できるので、
    # 締め切りを過ぎているオークションがあれば、締める。
    Auction.close_all_over_deadline_auctions!
  end

  private

    def set_auction
      # 誰でもどのオークション情報でも見れる
      @auction = Auction.find(params[:id])
    end
end
