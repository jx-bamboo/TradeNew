// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
App.cable = App.cable.subscriptions.create("PublicChannel", {
  connected: function() {
    console.log("connected");
  },
  disconnected: function() {
    console.log("disconnected");
  },
  received: function(repsoneData) {
  	console.log(repsoneData)
  	var data = repsoneData.data
  	switch(repsoneData.action){
  		case "btcusdt":
        if(data){
          $(".btc_table .btc_tbody").empty()
          for (var i=0; i < data.length; i++) {
            var htmlStr = "<tr>"+
            "<td>"+data[i].types+"</td>"+
            "<td>"+data[i].market+"</td>"+
            "<td>"+data[i].price+"</td>"+
            "<td>"+data[i].number+"</td>"+
            "<td>"+data[i].earn+"</td>"+
            "</tr>"
            $(".btc_table .btc_tbody").append(htmlStr)
          }
        }
  			break;
  		case "ethusdt":
  			if(data){
  				$(".eth_table .eth_tbody").empty()
		  		for (var i=0; i < data.length; i++) {
		  			var htmlStr = "<tr>"+
		  			"<td>"+data[i].types+"</td>"+
		  			"<td>"+data[i].market+"</td>"+
		  			"<td>"+data[i].price+"</td>"+
		  			"<td>"+data[i].number+"</td>"+
		  			"<td>"+data[i].earn+"</td>"+
		  			"</tr>"
		  			$(".eth_table .eth_tbody").append(htmlStr)
		  		}
		  	}
  			break;

  	}
  	
  },
  speak: function(data) {
    console.log(data);
    return this.perform('speak', data);
  }
});