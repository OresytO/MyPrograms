function onChange(select, condition) {
  var selectedOption = select.options[select.selectedIndex];
  if (selectedOption.label == condition) {
    // window.location.href = "/welcome";
    var form = document.getElementById("addNewDelivery");
    form.action = "/addNewSelectOption";
    form.submit();
  }
}

