function incrementValue(cell) {
  var value = parseInt(cell.innerText) || 0;
  var existingClass = cell.classList.values()[0] || "empty";

  newValue = value + 1;
  cell.innerText = newValue;
  switch(newValue) {
    case 1:
    case 2:
    {
      cell.classList.remove(existingClass);
      cell.classList.add("orange");
      break;
    }
    case 3:
    default:
    {
      cell.classList.remove(existingClass);
      cell.classList.add("green");
      break;
    }
  }
}

function extractAvailabilityData() {
  var name = document.getElementById("name").value.trim();
  var table = document.querySelector("table");
  var rows = table.querySelectorAll("tr");
  var availabilityData = {};

  console.log("extractAvailabilityData ")
  if(!validateName()) return false; // Prevent form submission if no name

  rows.forEach(function(row, rowIndex) {
    var day = row.querySelector("th").innerText;
    console.log("day="+day);
    var cells = row.querySelectorAll("td");

    availabilityData[day] = {};

    cells.forEach(function(cell, cellIndex) {
      var hour = table.querySelector("tr:first-child th:nth-child(" + (cellIndex + 2) + ")").innerText;
      var value = parseInt(cell.innerText) || 0;

      console.log("cell day:"+day+" hour:"+hour+" value: "+value);

      availabilityData[day][hour] = value;
    });
  });

  console.log("Availability data for " + name + ":", availabilityData);

  return true;
}

function validateName() {
  var name = document.getElementById("name").value.trim();
  if (name === "") {
    alert("Please enter your name.");
    return false;
  }
  return true;
}

function addEventListenersToCells() {
  var cells = document.querySelectorAll("td");
  cells.forEach(function(cell) {
    cell.addEventListener("click", function() {      
      incrementValue(cell);
    });
  });
}

function toggleTableHeaderGroupVisibility(thGroup) {
  thGroup.forEach(function(th) {
    var columnIndex = th.cellIndex;
    var table = th.closest("table");
    var rows = table.querySelectorAll("tr");

    rows.forEach(function(row) {
      var cells = row.querySelectorAll("td");

      if (cells.length > columnIndex) {
        var cell = cells[columnIndex];
        if (cell.style.display === "none") {
          cell.style.display = ""; // Show the cell
        } else {
          cell.style.display = "none"; // Hide the cell
        }
      }
    });

    if (th.style.display === "none")
    { 
      th.style.display="";      
    }
    else
    {
      th.style.display="none";
    }
  });
}

function toggleTableRowGroupVisibility(trGroup) { 
  var rows = document.querySelectorAll("tr.weekend_row");

  rows.forEach(function(row) {
    if (row.style.display === "none") {
      row.style.display = "table-row"; // Show the row
    } else {
      row.style.display = "none"; // Hide the row
    }
  });
}

function toggleOutsideCoreHours() {  
  var thEarlyElements = document.querySelectorAll("th.early");
  var thLateElements = document.querySelectorAll("th.late");
  var trWeekendElements = document.querySelectorAll("tr.weekend");

  toggleTableHeaderGroupVisibility(thEarlyElements);
  toggleTableHeaderGroupVisibility(thLateElements);
  toggleTableRowGroupVisibility(trWeekendElements);
}


