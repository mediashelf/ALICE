function toggleVisibility(captionid) {
  var captionref = document.getElementById(captionid);

  if (captionref.className.indexOf('hidechildren') >= 0) {
    captionref.className = captionref.className.replace('hidechildren', 'showchildren');
  } else {
    captionref.className = captionref.className.replace('showchildren', 'hidechildren');
  }
}

function setSelect(checkboxid) {
  var checkbox = document.getElementById(checkboxid);
  var lvlXdiv = checkbox.parentNode.parentNode.parentNode;
  if(checkbox.checked && lvlXdiv.className.indexOf('selected') == -1) {
    lvlXdiv.className = lvlXdiv.className.replace('notsel', 'selected');
  }
  else if (!checkbox.checked && lvlXdiv.className.indexOf('notsel') == -1) {
    lvlXdiv.className = lvlXdiv.className.replace('selected', 'notsel');
  }
}

function getHierarchyCheckedCheckboxes() {
  var hierarchy = document.getElementById('hierarchy_form');
  var elements = hierarchy.elements;

  var retval = [];
  var current = null;
  for (indx = 0; indx < elements.length; idx++) {
    current = elements[idx];
    if((current.type == 'checkbox') && current.checked) {
      retval[retval.length] = current;
    }
  }
  return retval;
}

