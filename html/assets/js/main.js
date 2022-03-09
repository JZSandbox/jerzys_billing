let playerId = $('#player_id').val();
let ammount = $('#billing_ammount').val();
let title = $('#billing_title').val();
let text =  $('#billing_text').val();
let checked = false;
let defaultState = false;

window.addEventListener('message', (event) => {

     let data = event.data;
     let player = data.player;

     if(data.action == "openMenu") {
        $('#jerzysBilling').fadeIn()
        $('#playerId').val(player.citizenid)
     }

     if(data.action == "closeMenu") {
        $('#jerzysBilling').fadeOut()
     }

});

function closeMenu() {
    resetVal()
    $.post('https://jerzys_billing/hideMenu', JSON.stringify({}))
}

$(document).on("click", ".billing_close", function () { 
    closeMenu()
})

$(document).on("click", "#checkText", function(){

    checkChecked()
    if(checked == true) {
        console.log('true')
    }
})

$(document).on("click", ".billing_submit", function () { 


    let playerId = $('#player_id').val()
    let ammount = $('#billing_ammount').val();
    let title = $('#billing_title').val();
    let text =  $('#billing_text').val();

    if(checkIsFilled()) {
        $.ajax({
            url: 'https://jerzys_billing/submitBilling',
            type: 'POST',
            data: JSON.stringify({
                player : playerId,
                ammount : ammount,
                title : title,
                text : text,
            }),
            success: function() {
            },

        }) 
        closeMenu()
    }

 })



/** Function to toggle CheckBox **/
function checkChecked() {
    $('.checkbox_box').toggleClass('checked');
    $('.checkIcon').toggleClass('checked');
    $('.textArea').slideToggle('hide');
}

/* Silly Function to Check if Input is filled */
function checkIsFilled() {
    $('#player_id, #billing_ammount, #billing_title').each(function(index, element) {
        if ($(this).val() == '') {
            if(index == 0) {
                $.post('https://jerzys_billing/error')
                checked = false;
            }
        } else {
            checked = true;
        }
      });

      if(checked) {
          return true
      } else {
          return false
      }

}

/** Sending Error Function as NUI Callback **/
function error() {
    $.post('https://jerzys_billing/error')
}

/** Function to Reset all Input Values **/
function resetVal() {
    $('#player_id').val("");
    $('#billing_ammount').val("");
    $('#billing_title').val("");
    $('#billing_text').val("");
}

