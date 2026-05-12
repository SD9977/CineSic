// Grab elements
const form = document.getElementById('entryForm');
const entryList = document.getElementById('entryList');
const searchBar = document.getElementById('searchBar');

// Load saved entries on page load
document.addEventListener('DOMContentLoaded', loadEntries);

// Handle form submission
form.addEventListener('submit', function(event) {
  event.preventDefault();

  const title = document.getElementById('title').value;
  const year = document.getElementById('year').value;
  const genre = document.getElementById('genre').value;
  const language = document.getElementById('language').value;

  const entry = { title, year, genre, language };

  saveEntry(entry);
  addEntryToList(entry);

  form.reset();
});

// Save entry to localStorage
function saveEntry(entry) {
  let entries = JSON.parse(localStorage.getItem('entries')) || [];
  entries.push(entry);
  localStorage.setItem('entries', JSON.stringify(entries));
}

// Load entries from localStorage
function loadEntries() {
  entryList.innerHTML = "";
  let entries = JSON.parse(localStorage.getItem('entries')) || [];
  entries.forEach(entry => addEntryToList(entry));
}

// Add entry to UI list
function addEntryToList(entry) {
  const li = document.createElement('li');
  li.textContent = `${entry.title} (${entry.year}) - ${entry.genre} [${entry.language}]`;

  const deleteBtn = document.createElement('button');
  deleteBtn.textContent = "Delete";
  deleteBtn.style.marginLeft = "10px";

  deleteBtn.addEventListener('click', () => {
    li.remove();
    deleteEntry(entry);
  });

  li.appendChild(deleteBtn);
  entryList.appendChild(li);
}

// Delete entry from localStorage
function deleteEntry(entry) {
  let entries = JSON.parse(localStorage.getItem('entries')) || [];
  entries = entries.filter(e => !(e.title === entry.title && e.year === entry.year && e.genre === entry.genre && e.language === entry.language));
  localStorage.setItem('entries', JSON.stringify(entries));
}

// Search functionality (includes language)
searchBar.addEventListener('input', function() {
  const query = searchBar.value.toLowerCase();
  let entries = JSON.parse(localStorage.getItem('entries')) || [];

  entryList.innerHTML = "";
  entries
    .filter(e =>
      e.title.toLowerCase().includes(query) ||
      e.genre.toLowerCase().includes(query) ||
      e.language.toLowerCase().includes(query)
    )
    .forEach(entry => addEntryToList(entry));
});
