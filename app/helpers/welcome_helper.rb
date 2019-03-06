module WelcomeHelper
	def get_type(types)
		(types == 0) ? "buy" : "sell"
	end

	def get_market(market)
		(market == 0) ? "Huobi" : "Gate"
	end
end
