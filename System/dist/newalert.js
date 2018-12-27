//type的值为：success   /   error
function pageAlert(option, message, type) {
    swal({ title: option,
        text: message,
        type: type
    })
}