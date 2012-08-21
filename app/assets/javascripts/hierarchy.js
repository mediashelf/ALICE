      /*
        THREE FUNCTIONS
       */

      /* toggles the visibility of a caption, typically in response to
        a show/hide children action. NOTE that "hidechildren" is the
        logically significant class; "showchildren" is a placeholder. */
      function toggleVisibility(captionid)
      {
        var captionref = document.getElementById(captionid);

        if (captionref.className.indexOf('hidechildren') >= 0)
        {
          captionref.className = captionref.className.replace('hidechildren', 'showchildren');
        }
        else
        {
          captionref.className = captionref.className.replace('showchildren', 'hidechildren');
        }
      }

      /* A very particular function: sets the "selected/nonsel" class of a lvlX div according
        to whether the div's caption's enclosed checkbox is checked (selected) or unchecked (nonsel).
        In other words, this function does nothing except to ENSURE CONSISTENCY between the state
        of the checkbox and the class of the lX div(which in turn controls appearance and visibility
        of the enclosed caption.) Characteristically it will be called from the checkbox's "onchange" event.
       */
      function setSelect(checkboxid)
      {
        var checkbox = document.getElementById(checkboxid);
        var lvlXdiv = checkbox.parentNode.parentNode.parentNode;
        if(checkbox.checked && lvlXdiv.className.indexOf('selected') == -1)
        {
          lvlXdiv.className = lvlXdiv.className.replace('notsel', 'selected');
        }
        else if (!checkbox.checked && lvlXdiv.className.indexOf('notsel') == -1)
        {
          lvlXdiv.className = lvlXdiv.className.replace('selected', 'notsel');
        }
      }

      /* A utility function to identify all checked checkboxes IN THE HIERARCHY
         FORM (NOT THE HIERARCHY DIV) and return them as an array of DOM Element objects.
       */
      function getHierarchyCheckedCheckboxes()
      {
        var hierarchy = document.getElementById('hierarchy_form');
        var elements = hierarchy.elements;

        var retval = [];
        var current = null;
        for (indx = 0; indx < elements.length; indx++)
        {
          current = elements[indx];
          if((current.type == 'checkbox') && current.checked)
          {
            retval[retval.length] = current;
          }
        }
        return retval;
      }

