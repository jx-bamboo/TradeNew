class WelcomeController < ApplicationController
  before_action :get_price
  require 'rest-client'
  require 'socket'

  def index
    p "--------index--------"

    @btcusdt = Welcome.btcusdt
    @ethusdt = Welcome.ethusdt
  end

  #火币价格：h_price，
  #gate价格：g_price = RestClient.get("https://data.gateio.co/api2/1/tickers")
  #{"result"=>"true", "last"=>"3744.14", "lowestAsk"=>"3746.33", "highestBid"=>"3744.14", 
  # "percentChange"=>"-1.99", "baseVolume"=>"1475031.71985011", "quoteVolume"=>"389.80562264", "high24hr"=>"3835.46", "low24hr"=>"3705"}
  # 0 = buy,Huobi; 1 = sell, Gate
  #
  def get_price
    begin
      gate = RestClient.get "https://data.gateio.co/api2/1/tickers"
      #huobi = RestClient.get "https://api.huobi.pro/market/tickers"

      huobi_btc_price = RestClient.get "https://api.huobi.pro/market/trade?symbol=btcusdt"
      huobi_eth_price = RestClient.get "https://api.huobi.pro/market/trade?symbol=ethusdt"
      #binance = RestClient.get "https://api.binance.com"
      #HardWorkerJob.perform_later

    rescue RestClient::ExceptionWithResponse => err
      puts 'Access denied'
      return err.response
    end

    gate_json = JSON.parse(gate.body)

    btc_rate = (gate_json["btc_usdt"]["percentChange"]).to_f
    eth_rate = (gate_json["tips_cnyx"]["percentChange"]).to_f

    @gate_btc_price = gate_json["btc_usdt"]["last"]
    @gate_eth_price = gate_json["eth_usdt"]["last"]


    @huobi_btc_price = JSON.parse(huobi_btc_price)["tick"]["data"][0]["price"]
    @huobi_eth_price = JSON.parse(huobi_eth_price)["tick"]["data"][0]["price"]

    #decimals = format("%.2f", rand())  #小数位

    typemarket, coin_name, price, num_grade, earn_grade = rand(2), rand(4), rand(6), rand(8), rand(10)  #买卖类型

    market = (coin_name%2 == 0) ? 0 : 1 #0=火币；1=gate

    _price = (price%2 == 0) ? 0 : 1 #0=ETH; 1=BTC

    #获取交易所价格
    if market == 0
      p "----火币----"
      if _price = 0
        price = @huobi_eth_price
      elsif _price == 1
        price = @huobi_btc_price
      end
    elsif market == 1
      p "----gate----"
      if _price ==0
        price = @gate_eth_price
      elsif _price == 1
        price = @gate_btc_price
      end
    end

    #获取数量
    group = rand(1..3)
    _number = rand(1..3) + rand()

    if num_grade >= 5
      if group == 1
        number = (_number/100).round(4)
      elsif group == 2
        number = (_number/10).round(3)
      elsif group == 3
        number = _number.round(2)
      end
    else
      if group == 1
        number = (rand()/100).round(4)
      elsif group == 2
        number = (rand()/10).round(3)
      elsif group == 3
        number = rand().round(2)
      end
    end

    p number,"--------------"

    # 获取收益
    if _price == 0

      if eth_rate > 0

        if eth_rate > 10
          _earn = rand()
        elsif eth_rate > 6
          _earn = rand()/10
        elsif eth_rate > 2
          _earn = rand()/100
        else
          _earn = rand()/1000
        end

      else

        if group >= 2
          _earn = rand()/100
        else
          _earn = -rand()/100
        end

      end

    elsif _price == 1
      if btc_rate > 0

        if btc_rate > 10
          _earn = rand()
        elsif btc_rate > 6
          _earn = rand()/10
        elsif btc_rate > 2
          _earn = rand()/100
        else
          _earn = rand()/1000
        end

      else

        if group >= 2
          _earn = rand()/100
        else
          _earn = -rand()/100
        end
        
      end
    end

    welcome_params = {
      :types => typemarket,
      :market => market,
      :price => price,
      :number => number,
      :earn => _earn,
      :coin_name => (_price == 0) ? "ETH/USDT" : "BTC/USDT" 
    }

    @welcome = Welcome.new(welcome_params)
    @welcome.save

=begin
    respond_to do |format|
      if @welcome.save
        format.html { redirect_to @welcome, notice: 'welcome was successfully created.' }
        format.json { render :show, status: :created, location: @welcome }
      else
        format.html { render :new }
        format.json { render json: @welcome.errors, status: :unprocessable_entity }
      end
    end
=end

  end
  
  
  private

  def num(x)
    arr = [25800, 26800, 29400, 31200, 32200, 27800, 28800, 32700, 34500, 35500, 49800, 51600, 52600, 11800, 12800, 10000, 11000, 12000, 13000, 13800, 14800]
    arr.each do |a|
      aa = (a*0.1492/0.3767)*(1+0.2).round(2)
      p a.to_s + ": " + aa.to_s
    end
    
  end

end

