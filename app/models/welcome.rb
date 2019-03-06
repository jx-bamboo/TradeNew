class Welcome < ApplicationRecord
	scope :btcusdt, -> { order("created_at desc").where(coin_name: "BTC/USDT").limit(6) }
	scope :ethusdt, -> { order("created_at desc").where(coin_name: "ETH/USDT").limit(6) }


	def get_type
		(types == 0) ? "buy" : "sell"
	end

	def get_market
		(market == 0) ? "Huobi" : "Gate"
	end

	def self.list_limit_6 market="btcusdt"
		if market == "ethusdt"
			dataList = Welcome.ethusdt
		else
			dataList = Welcome.btcusdt
		end
		list = []
		if dataList.present?
			dataList.each_with_index do |data,index|
				list.push(
					{
						types: 				data.get_type,
						market: 			data.get_market,
						balance: 			data.balance,
						coin_name: 		data.coin_name,
						created_at: 	data.created_at,
						earn: 				data.earn,
						id: 					data.id,
						number: 			data.number,
						price: 				data.price,
						updated_at: 	data.updated_at
					}
				)
			end
		end
		return list
	end
end
