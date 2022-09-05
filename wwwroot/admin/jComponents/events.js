  function treeDemoChanged() {
	var tree = jComponents.getComponent("treeDemo");
	var message = "Tree Demo:\n\nJust clicked: ";
	message += tree.data;
	
	if (tree.openNodes.length > 0) {
	  message += "\n\nOpen Items:";
	  for (var i=0;i<tree.openNodes.length;i++) {
		message += "\n - " + tree.openNodes[i];
	  }
	}
	addEvent(message);
  }
  
  function tabDemoChanged() {
	addEvent("Horizontal Tab demo: selectedIndex is " + jComponents.getComponent("tabDemo").selectedIndex);
  }

  function tab2DemoChanged() {
	addEvent("Vertical Tab demo: selectedIndex is " + jComponents.getComponent("tab2Demo").selectedIndex);
  }

  function accDemoChanged() {
	addEvent("Accordian demo: selectedIndex is " + jComponents.getComponent("accDemo").selectedIndex);
  }

  function acc2DemoChanged() {
	addEvent("Multiple Accordian demo: selectedIndex is " + jComponents.getComponent("acc2Demo").selectedIndex);
  }

  function addEvent(msg) {
	if (document.getElementById("events"))
	  document.getElementById("events").value = msg;
  }

  function Container1Change() {
	var state = jComponents.getComponent("Container1").isOpen ? "open" : "closed";
	addEvent("Continer 1 is now " + state + ".");
  }
  function Container2Change() {
	var state = jComponents.getComponent("Container2").isOpen ? "open" : "closed";
	addEvent("Continer 2 is now " + state + ".");
  }
  function Container2_1Change() {
	var state = jComponents.getComponent("Container2_1").isOpen ? "open" : "closed";
	addEvent("Continer 2_1 is now " + state + ".");
  }
