function onChange(select) {
  var selectedOption = select.options[select.selectedIndex];
  if (selectedOption.label == 'Add new one') {
    // window.location.href = "/welcome";
    var form = document.getElementById("addNewDelivery");
    form.action = "/addNewSelectOption";
    form.submit();
  }
}

