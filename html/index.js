$(function(){
    $( "#all" ).draggable();  
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
var sPositions = localStorage.positions || "{}",
    positions = JSON.parse(sPositions);
$.each(positions, function (id, pos) {
    $("#" + id).css(pos)
})
$("#all").draggable({
    containment: "#containment-wrapper",
    scroll: false,
    stop: function (event, ui) {
        positions[this.id] = ui.position
        localStorage.positions = JSON.stringify(positions)
    }
});
document.onkeyup = function (data) {
    if (data.which == 27) {
        $.post('http://speedlimit/exit', JSON.stringify({}));
        return
    }
};