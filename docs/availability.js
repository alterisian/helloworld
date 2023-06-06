function incrementValue(cell) {
  var value = parseInt(cell.innerText) || 0;
  var existingClass = cell.classList.values()[0] || "empty";

  newValue = value + 1;
  cell.innerText = newValue;
  switch(newValue) {
    case 0:
    {
      // no action needed
      break;
    }
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
  if(!validateName()) return false; // Prevent form submission

  rows.forEach(function(row, rowIndex) {
    var day = row.querySelector("th").innerText;
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
      // if (!validateName()) {
      //   return;
      // }
      incrementValue(cell);
    });
  });
}

function toggleEarly() {  
  var thElements = document.querySelectorAll("th.early");

  console.log("toggleEarly called");

  thElements.forEach(function(th) {
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
  });
}


