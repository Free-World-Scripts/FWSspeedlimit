$(function(){
    window.addEventListener("message", function(event){
        var item = event.data;
        $('#Speed').text(`${item.Speed}`);
        if(item.Display){
            $('#all').fadeOut()

        }else{
            $('#all').fadeIn() 
        }
    })
})