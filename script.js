// Grab elements
const form = document.getElementById('entryForm');
const entryList = document.getElementById('entryList');

// Handle form submission
form.addEventListener('submit', function(event) {
  event.preventDefault();

  // Get values
  const title = document.getElementById('title').value;
  const year = document.getElementById('year').value;
  const genre = document.getElementById('genre').value;

  // Create new list item
  const li = document.createElement('li');
  li.textContent = `${title} (${year}) - ${genre}`;

  // Add to list
  entryList.appendChild(li);

  // Clear form
  form.reset();
});
